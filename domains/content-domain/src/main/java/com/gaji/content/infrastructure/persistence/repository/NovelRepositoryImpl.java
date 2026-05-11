package com.gaji.content.infrastructure.persistence.repository;

import com.gaji.content.domain.model.Novel;
import com.gaji.content.domain.repository.NovelRepositoryCustom;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.Optional;

import static com.gaji.content.domain.model.QNovel.novel;

@RequiredArgsConstructor
public class NovelRepositoryImpl implements NovelRepositoryCustom {

    private final JPAQueryFactory queryFactory;

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
