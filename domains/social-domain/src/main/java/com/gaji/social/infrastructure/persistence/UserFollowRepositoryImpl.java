package com.gaji.social.infrastructure.persistence;

import com.gaji.social.domain.model.UserFollow;
import com.gaji.social.domain.model.UserFollowId;
import com.gaji.social.domain.repository.UserFollowRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class UserFollowRepositoryImpl implements UserFollowRepository {

    private final UserFollowJpaRepository jpaRepository;

    @Override
    public UserFollow save(UserFollow userFollow) {
        return jpaRepository.save(userFollow);
    }

    @Override
    public Optional<UserFollow> findById(UserFollowId id) {
        return jpaRepository.findById(id);
    }

    @Override
    public boolean existsById(UserFollowId id) {
        return jpaRepository.existsById(id);
    }

    @Override
    public void deleteById(UserFollowId id) {
        jpaRepository.deleteById(id);
    }

    @Override
    public long countByFollowerId(UUID followerId) {
        return jpaRepository.countByFollowerId(followerId);
    }

    @Override
    public long countByFolloweeId(UUID followeeId) {
        return jpaRepository.countByFolloweeId(followeeId);
    }

    @Override
    public boolean existsByFollowerIdAndFolloweeId(UUID followerId, UUID followeeId) {
        return jpaRepository.existsByFollowerIdAndFolloweeId(followerId, followeeId);
    }

    @Override
    public Page<UserFollow> findByFolloweeId(UUID followeeId, Pageable pageable) {
        return jpaRepository.findByFolloweeId(followeeId, pageable);
    }

    @Override
    public Page<UserFollow> findByFollowerId(UUID followerId, Pageable pageable) {
        return jpaRepository.findByFollowerId(followerId, pageable);
    }
}
