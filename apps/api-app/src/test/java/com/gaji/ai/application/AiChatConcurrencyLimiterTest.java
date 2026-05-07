package com.gaji.ai.application;

import com.gaji.common.exception.ServiceUnavailableException;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class AiChatConcurrencyLimiterTest {

    @Test
    void execute_runsActionAndReleasesPermit() {
        AiChatConcurrencyLimiter limiter = new AiChatConcurrencyLimiter(1, 0);

        String result = limiter.execute(() -> "ok");

        assertEquals("ok", result);
        assertEquals(1, limiter.availablePermits());
    }

    @Test
    void execute_rejectsWhenCapacityIsSaturated() {
        AiChatConcurrencyLimiter limiter = new AiChatConcurrencyLimiter(1, 0);

        ServiceUnavailableException exception = assertThrows(
                ServiceUnavailableException.class,
                () -> limiter.execute(() -> limiter.execute(() -> "nested"))
        );

        assertTrue(exception.getMessage().contains("capacity is saturated"));
        assertEquals(1, limiter.availablePermits());
    }
}
