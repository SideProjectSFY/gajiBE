package com.gaji.ai.application;

import com.gaji.common.exception.ServiceUnavailableException;
import io.micrometer.core.instrument.Counter;
import io.micrometer.core.instrument.Gauge;
import io.micrometer.core.instrument.MeterRegistry;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Flux;

import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.function.Supplier;

@Slf4j
@Component
public class AiChatConcurrencyLimiter {

    private final Semaphore semaphore;
    private final int maxConcurrentGenerations;
    private final long acquireTimeoutMs;
    private final AtomicInteger activeGenerations = new AtomicInteger();
    private final Counter saturationCounter;

    @Autowired
    public AiChatConcurrencyLimiter(
            @Value("${gaji.ai.chat.max-concurrent-generations:10}") int maxConcurrentGenerations,
            @Value("${gaji.ai.chat.acquire-timeout-ms:500}") long acquireTimeoutMs,
            MeterRegistry meterRegistry
    ) {
        this.maxConcurrentGenerations = Math.max(1, maxConcurrentGenerations);
        this.acquireTimeoutMs = Math.max(0, acquireTimeoutMs);
        this.semaphore = new Semaphore(this.maxConcurrentGenerations);
        this.saturationCounter = Counter.builder("gaji.ai.chat.generation.saturated")
                .description("Number of AI chat generation requests rejected by the local concurrency limiter")
                .register(meterRegistry);
        Gauge.builder("gaji.ai.chat.generation.active", activeGenerations, AtomicInteger::get)
                .description("Current number of active AI chat generation requests")
                .register(meterRegistry);
        Gauge.builder("gaji.ai.chat.generation.available", semaphore, Semaphore::availablePermits)
                .description("Available permits in the local AI chat generation concurrency limiter")
                .register(meterRegistry);
    }

    AiChatConcurrencyLimiter(int maxConcurrentGenerations, long acquireTimeoutMs) {
        this(maxConcurrentGenerations, acquireTimeoutMs, io.micrometer.core.instrument.Metrics.globalRegistry);
    }

    public <T> T execute(Supplier<T> action) {
        boolean acquired = false;
        try {
            acquired = tryAcquirePermit();
            return action.get();
        } catch (InterruptedException ex) {
            Thread.currentThread().interrupt();
            throw new ServiceUnavailableException("Interrupted while waiting for AI chat generation capacity", ex);
        } finally {
            if (acquired) {
                activeGenerations.decrementAndGet();
                semaphore.release();
            }
        }
    }

    public <T> Flux<T> executeFlux(Supplier<Flux<T>> action) {
        boolean acquired = false;
        try {
            tryAcquirePermit();
            acquired = true;
            return action.get()
                    .doFinally(_signal -> releasePermit());
        } catch (InterruptedException ex) {
            Thread.currentThread().interrupt();
            return Flux.error(new ServiceUnavailableException(
                    "Interrupted while waiting for AI chat generation capacity",
                    ex
            ));
        } catch (RuntimeException ex) {
            if (acquired) {
                releasePermit();
            }
            return Flux.error(ex);
        }
    }

    private boolean tryAcquirePermit() throws InterruptedException {
        boolean acquired = semaphore.tryAcquire(acquireTimeoutMs, TimeUnit.MILLISECONDS);
        if (!acquired) {
            saturationCounter.increment();
            log.warn(
                    "ai_chat_generation_capacity_saturated maxConcurrentGenerations={} availablePermits={}",
                    maxConcurrentGenerations,
                    semaphore.availablePermits()
            );
            throw new ServiceUnavailableException(
                    "AI chat generation capacity is saturated. Please retry shortly."
            );
        }
        activeGenerations.incrementAndGet();
        return true;
    }

    private void releasePermit() {
        activeGenerations.decrementAndGet();
        semaphore.release();
    }

    int availablePermits() {
        return semaphore.availablePermits();
    }

    int activeGenerations() {
        return activeGenerations.get();
    }
}
