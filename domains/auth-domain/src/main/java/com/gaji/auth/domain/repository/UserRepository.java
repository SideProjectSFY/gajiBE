package com.gaji.auth.domain.repository;

import com.gaji.auth.domain.model.User;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface UserRepository {
    
    User save(User user);
    
    Optional<User> findById(UUID id);
    
    List<User> findAllById(Iterable<UUID> ids);
    
    boolean existsById(UUID id);
    
    void deleteById(UUID id);
    
    Optional<User> findByEmail(String email);
    
    Optional<User> findByUsername(String username);
    
    List<User> searchUsers(String query);
    
    boolean existsByEmail(String email);
    
    boolean existsByUsername(String username);
}
