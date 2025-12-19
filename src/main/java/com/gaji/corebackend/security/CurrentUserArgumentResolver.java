package com.gaji.corebackend.security;

import com.gaji.corebackend.entity.User;
import com.gaji.corebackend.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.core.MethodParameter;
import org.springframework.lang.NonNull;
import org.springframework.lang.Nullable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

/**
 * Resolver for @CurrentUser annotation
 * Supports both UserPrincipal and User entity types
 */
@Component
@RequiredArgsConstructor
public class CurrentUserArgumentResolver implements HandlerMethodArgumentResolver {

    private final UserMapper userMapper;

    @Override
    public boolean supportsParameter(@NonNull MethodParameter parameter) {
        if (!parameter.hasParameterAnnotation(CurrentUser.class)) {
            return false;
        }
        
        Class<?> paramType = parameter.getParameterType();
        return paramType.equals(UserPrincipal.class) || paramType.equals(User.class);
    }

    @Override
    @Nullable
    @SuppressWarnings("null")
    public Object resolveArgument(
            @NonNull MethodParameter parameter,
            @Nullable ModelAndViewContainer mavContainer,
            @NonNull NativeWebRequest webRequest,
            @Nullable WebDataBinderFactory binderFactory
    ) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        
        if (authentication == null || !(authentication.getPrincipal() instanceof UserPrincipal)) {
            return null;
        }
        
        UserPrincipal principal = (UserPrincipal) authentication.getPrincipal();
        
        // If UserPrincipal is requested, return it directly
        if (parameter.getParameterType().equals(UserPrincipal.class)) {
            return principal;
        }
        
        // If User entity is requested, fetch from database
        if (parameter.getParameterType().equals(User.class)) {
            if (principal.getUserId() == null) {
                return null;
            }
            return userMapper.findById(principal.getUserId()).orElse(null);
        }
        
        return null;
    }
}
