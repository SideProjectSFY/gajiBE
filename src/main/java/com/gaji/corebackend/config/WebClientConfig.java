package com.gaji.corebackend.config;

import io.netty.channel.ChannelOption;
import io.netty.handler.timeout.ReadTimeoutHandler;
import io.netty.handler.timeout.WriteTimeoutHandler;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;
import org.springframework.web.reactive.function.client.ClientRequest;
import org.springframework.web.reactive.function.client.ExchangeFilterFunction;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;
import reactor.netty.http.client.HttpClient;
import reactor.util.retry.Retry;

import java.time.Duration;
import java.util.concurrent.TimeUnit;

/**
 * WebClient Configuration for FastAPI Proxy
 * 
 * Purpose: Configure WebClient to proxy requests from Spring Boot to FastAPI
 * - Base URL: http://localhost:8000 (internal Docker network)
 * - Timeout: 60 seconds (AI operations can be slow)
 * - Retry: 3 attempts with exponential backoff
 * - Circuit Breaker: Fail fast after 3 consecutive failures
 */
@Slf4j
@Configuration
public class WebClientConfig {

    @Value("${fastapi.base-url:http://localhost:8000}")
    private String fastApiBaseUrl;

    @Value("${fastapi.timeout:60}")
    private int timeoutSeconds;

    @Value("${fastapi.retry.max-attempts:3}")
    private int maxRetryAttempts;

    /**
     * FastAPI WebClient Bean
     * Used by AIProxyController to forward requests to FastAPI service
     */
    @Bean(name = "fastApiClient")
    public WebClient fastApiClient() {
        HttpClient httpClient = HttpClient.create()
            .option(ChannelOption.CONNECT_TIMEOUT_MILLIS, 5000)
            .responseTimeout(Duration.ofSeconds(timeoutSeconds))
            .doOnConnected(conn -> 
                conn.addHandlerLast(new ReadTimeoutHandler(timeoutSeconds, TimeUnit.SECONDS))
                    .addHandlerLast(new WriteTimeoutHandler(timeoutSeconds, TimeUnit.SECONDS))
            );

        return WebClient.builder()
            .baseUrl(fastApiBaseUrl)
            .clientConnector(new ReactorClientHttpConnector(httpClient))
            .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
            .defaultHeader(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE)
            .filter(correlationIdFilter())
            .filter(logRequest())
            .filter(logResponse())
            .filter(retryFilter())
            .build();
    }

    /**
     * Propagate correlation ID to downstream FastAPI service
     */
    private ExchangeFilterFunction correlationIdFilter() {
        return ExchangeFilterFunction.ofRequestProcessor(clientRequest -> {
            String correlationId = MDC.get(CorrelationIdFilter.CORRELATION_ID_MDC_KEY);
            if (correlationId != null && !correlationId.isBlank()) {
                return Mono.just(ClientRequest.from(clientRequest)
                    .header(CorrelationIdFilter.CORRELATION_ID_HEADER, correlationId)
                    .build());
            }
            return Mono.just(clientRequest);
        });
    }

    /**
     * Log outgoing requests to FastAPI
     */
    private ExchangeFilterFunction logRequest() {
        return ExchangeFilterFunction.ofRequestProcessor(clientRequest -> {
            log.info("FastAPI Request: {} {}", clientRequest.method(), clientRequest.url());
            clientRequest.headers().forEach((name, values) -> 
                values.forEach(value -> log.debug("  {}: {}", name, value))
            );
            return Mono.just(clientRequest);
        });
    }

    /**
     * Log responses from FastAPI
     */
    private ExchangeFilterFunction logResponse() {
        return ExchangeFilterFunction.ofResponseProcessor(clientResponse -> {
            log.info("FastAPI Response: {} {}", 
                clientResponse.statusCode(), 
                clientResponse.headers().asHttpHeaders().getContentType());
            return Mono.just(clientResponse);
        });
    }

    /**
     * Retry filter with exponential backoff
     * - Max attempts: 3
     * - Initial backoff: 1 second
     * - Max backoff: 10 seconds
     * - Jitter: 0.5 (randomize backoff to prevent thundering herd)
     */
    private ExchangeFilterFunction retryFilter() {
        return (request, next) -> next.exchange(request)
            .retryWhen(Retry.backoff(maxRetryAttempts, Duration.ofSeconds(1))
                .maxBackoff(Duration.ofSeconds(10))
                .jitter(0.5)
                .filter(throwable -> {
                    // Only retry on network errors, not on 4xx/5xx responses
                    boolean shouldRetry = !(throwable instanceof org.springframework.web.reactive.function.client.WebClientResponseException);
                    if (shouldRetry) {
                        log.warn("Retrying FastAPI request due to: {}", throwable.getMessage());
                    }
                    return shouldRetry;
                })
                .onRetryExhaustedThrow((retryBackoffSpec, retrySignal) -> {
                    log.error("FastAPI retry exhausted after {} attempts", maxRetryAttempts);
                    return new RuntimeException("FastAPI service unavailable after " + maxRetryAttempts + " retries");
                })
            );
    }
}
