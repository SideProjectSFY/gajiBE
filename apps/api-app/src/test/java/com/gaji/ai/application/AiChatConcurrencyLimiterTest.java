package com.gaji.ai.application;

import com.gaji.common.exception.ServiceUnavailableException;
import io.micrometer.core.instrument.simple.SimpleMeterRegistry;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class AiChatConcurrencyLimiterTest {

    @Test
    void execute_runsActionAndReleasesPermit() {
        SimpleMeterRegistry meterRegistry = new SimpleMeterRegistry();
        AiChatConcurrencyLimiter limiter = new AiChatConcurrencyLimiter(1, 0, meterRegistry);

        String result = limiter.execute(() -> "ok");

        assertEquals("ok", result);
        assertEquals(1, limiter.availablePermits());
        assertEquals(0, limiter.activeGenerations());
        assertEquals(0.0, meterRegistry.counter("gaji.ai.chat.generation.saturated").count());
    }

    @Test
    void execute_rejectsWhenCapacityIsSaturated() {
        SimpleMeterRegistry meterRegistry = new SimpleMeterRegistry();
        AiChatConcurrencyLimiter limiter = new AiChatConcurrencyLimiter(1, 0, meterRegistry);

        ServiceUnavailableException exception = assertThrows(
                ServiceUnavailableException.class,
                () -> limiter.execute(() -> limiter.execute(() -> "nested"))
        );

        assertTrue(exception.getMessage().contains("capacity is saturated"));
        assertEquals(1, limiter.availablePermits());
        assertEquals(0, limiter.activeGenerations());
        assertEquals(1.0, meterRegistry.counter("gaji.ai.chat.generation.saturated").count());
    }
}
