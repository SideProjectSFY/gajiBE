package com.gaji.social.domain.repository;

import com.gaji.social.domain.model.Notification;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

public interface NotificationRepository {
    
    Notification save(Notification notification);
    
    Optional<Notification> findById(UUID id);
    
    void deleteById(UUID id);

    Page<Notification> findByUserIdOrderByCreatedAtDesc(UUID userId, Pageable pageable);
    
    void deleteByCreatedAtBefore(LocalDateTime timestamp);
}

