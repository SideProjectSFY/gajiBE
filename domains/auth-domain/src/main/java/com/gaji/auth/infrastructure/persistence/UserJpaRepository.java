package com.gaji.auth.infrastructure.persistence;

import com.gaji.auth.domain.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface UserJpaRepository extends JpaRepository<User, UUID>, QuerydslPredicateExecutor<User> {
    Optional<User> findByEmail(String email);
    Optional<User> findByUsername(String username);
    
    @Query("SELECT u FROM User u WHERE u.username LIKE CONCAT('%', :query, '%') OR u.email LIKE CONCAT('%', :query, '%')")
    List<User> searchUsers(@Param("query") String query);
    
    boolean existsByEmail(String email);
    boolean existsByUsername(String username);
}
