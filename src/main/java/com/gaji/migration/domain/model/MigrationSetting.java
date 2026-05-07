package com.gaji.migration.domain.model;

import com.gaji.common.exception.BadRequestException;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter
@ToString
@NoArgsConstructor
public class MigrationSetting {

    private String key;
    private String value;
    private String description;
    private LocalDateTime updatedAt;

    public MigrationSetting(String key, String value, String description) {
        if (key == null || key.isBlank()) {
            throw new BadRequestException("Migration setting key cannot be empty");
        }
        if (!key.startsWith("ff.") && !key.startsWith("kpi.")) {
            throw new BadRequestException("Migration setting key must start with 'ff.' or 'kpi.'");
        }
        this.key = key;
        this.value = value;
        this.description = description;
        this.updatedAt = LocalDateTime.now();
    }

    private MigrationSetting(String key, String value, String description, LocalDateTime updatedAt) {
        this.key = key;
        this.value = value;
        this.description = description;
        this.updatedAt = updatedAt;
    }
    
    public void update(String newValue, String newDescription) {
        this.value = newValue;
        this.description = newDescription;
        this.updatedAt = LocalDateTime.now();
    }

    public static MigrationSetting reconstitute(String key, String value, String description, LocalDateTime updatedAt) {
        return new MigrationSetting(key, value, description, updatedAt);
    }
}

