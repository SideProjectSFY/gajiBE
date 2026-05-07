package com.gaji.auth.application;

import com.gaji.auth.domain.model.User;
import com.gaji.auth.domain.repository.UserRepository;
import com.gaji.shared.contract.dto.UserDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserFacade {

    private final UserRepository userRepository;

    @Transactional(readOnly = true)
    public boolean existsById(UUID userId) {
        return userRepository.existsById(userId);
    }

    @Transactional(readOnly = true)
    public List<User> findAllById(List<UUID> ids) {
        return userRepository.findAllById(ids);
    }

    @Transactional(readOnly = true)
    public User findById(UUID id) {
        return userRepository.findById(id).orElse(null);
    }

    @Transactional(readOnly = true)
    public List<UserDTO> searchUsers(String query, int page, int size) {
        List<User> users = userRepository.searchUsers(query);

        return users.stream()
                .skip((long) page * size)
                .limit(size)
                .map(user -> UserDTO.builder()
                        .id(user.getId())
                        .username(user.getUsername())
                        .email(user.getEmail())
                        .bio(user.getBio())
                        .avatarUrl(user.getAvatarUrl())
                        .build())
                .collect(Collectors.toList());
    }
}
