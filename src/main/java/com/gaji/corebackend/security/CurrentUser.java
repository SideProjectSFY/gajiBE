package com.gaji.corebackend.security;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Annotation to inject the currently authenticated user
 * Usage: @CurrentUser UserPrincipal user or @CurrentUser User user
 * Set required=false to allow null for public endpoints
 */
@Target(ElementType.PARAMETER)
@Retention(RetentionPolicy.RUNTIME)
public @interface CurrentUser {
    /**
     * Whether authentication is required
     * If false, the parameter may be null for unauthenticated requests
     */
    boolean required() default true;
}
