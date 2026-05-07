package com.gaji.migration.infrastructure.persistence.repository;

import com.gaji.migration.infrastructure.persistence.entity.MigrationSettingEntity;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

import static com.gaji.migration.infrastructure.persistence.entity.QMigrationSettingEntity.migrationSettingEntity;

@Repository
@RequiredArgsConstructor
public class MigrationSettingDslRepository {

    private final JPAQueryFactory queryFactory;

    public List<MigrationSettingEntity> findByPrefix(String prefix) {
        return queryFactory
                .selectFrom(migrationSettingEntity)
                .where(migrationSettingEntity.key.startsWith(prefix))
                .fetch();
    }
}
