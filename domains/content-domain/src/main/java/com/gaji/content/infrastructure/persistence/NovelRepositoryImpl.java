package com.gaji.content.infrastructure.persistence;

import com.gaji.content.domain.model.Novel;
import com.gaji.content.domain.repository.NovelRepository;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static com.gaji.content.domain.model.QNovel.novel;

@Repository
@Primary
@RequiredArgsConstructor
public class NovelRepositoryImpl implements NovelRepository {

    private final NovelJpaRepository jpaRepository;
    private final JPAQueryFactory queryFactory;

    @Override
    public Novel save(Novel novel) {
        return jpaRepository.save(novel);
    }

    @Override
    public Optional<Novel> findById(UUID id) {
        return jpaRepository.findById(id);
    }

    @Override
    public boolean existsById(UUID id) {
        return jpaRepository.existsById(id);
    }

    @Override
    public java.util.List<Novel> findAll() {
        return jpaRepository.findAll();
    }

    @Override
    public List<Novel> findAllById(Iterable<UUID> ids) {
        return jpaRepository.findAllById(ids);
    }

    @Override
    public void deleteById(UUID id) {
        jpaRepository.deleteById(id);
    }

    @Override
    public Optional<Novel> findByGutenbergId(Integer gutenbergId) {
        return jpaRepository.findByGutenbergId(gutenbergId);
    }

    @Override
    public boolean existsByPgvectorCollectionId(String pgvectorCollectionId) {
        return jpaRepository.existsByPgvectorCollectionId(pgvectorCollectionId);
    }

    @Override
    public List<Novel> findByIngestionStatus(String ingestionStatus) {
        return queryFactory.selectFrom(novel)
                .where(novel.ingestionStatus.eq(ingestionStatus))
                .fetch();
    }

    @Override
    public Optional<Novel> findByPgvectorCollectionId(String pgvectorCollectionId) {
        Novel result = queryFactory.selectFrom(novel)
                .where(novel.pgvectorCollectionId.eq(pgvectorCollectionId))
                .fetchOne();
        return Optional.ofNullable(result);
    }
}
