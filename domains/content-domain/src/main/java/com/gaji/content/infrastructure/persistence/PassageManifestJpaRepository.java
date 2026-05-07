package com.gaji.content.infrastructure.persistence;

import com.gaji.content.domain.model.PassageManifest;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface PassageManifestJpaRepository extends JpaRepository<PassageManifest, String> {

    List<PassageManifest> findByNovelIdOrderByIndexedAtDesc(UUID novelId);
}
