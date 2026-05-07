package com.gaji.ai.application;

import com.gaji.common.exception.ServiceUnavailableException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;
import java.util.function.Supplier;

@Slf4j
@Component
public class AiChatConcurrencyLimiter {

    private final Semaphore semaphore;
    private final int maxConcurrentGenerations;
    private final long acquireTimeoutMs;

    public AiChatConcurrencyLimiter(
            @Value("${gaji.ai.chat.max-concurrent-generations:10}") int maxConcurrentGenerations,
            @Value("${gaji.ai.chat.acquire-timeout-ms:500}") long acquireTimeoutMs
    ) {
        this.maxConcurrentGenerations = Math.max(1, maxConcurrentGenerations);
        this.acquireTimeoutMs = Math.max(0, acquireTimeoutMs);
        this.semaphore = new Semaphore(this.maxConcurrentGenerations);
    }

    public <T> T execute(Supplier<T> action) {
        boolean acquired = false;
        try {
            acquired = semaphore.tryAcquire(acquireTimeoutMs, TimeUnit.MILLISECONDS);
            if (!acquired) {
                log.warn(
                        "ai_chat_generation_capacity_saturated maxConcurrentGenerations={} availablePermits={}",
                        maxConcurrentGenerations,
                        semaphore.availablePermits()
                );
                throw new ServiceUnavailableException(
                        "AI chat generation capacity is saturated. Please retry shortly."
                );
            }
            return action.get();
        } catch (InterruptedException ex) {
            Thread.currentThread().interrupt();
            throw new ServiceUnavailableException("Interrupted while waiting for AI chat generation capacity", ex);
        } finally {
            if (acquired) {
                semaphore.release();
            }
        }
    }

    int availablePermits() {
        return semaphore.availablePermits();
    }
}
