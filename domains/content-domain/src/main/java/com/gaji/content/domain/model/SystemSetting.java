package com.gaji.content.domain.model;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SystemSetting {

    private String key;
    private String value;
    private String description;
    private LocalDateTime updatedAt;
}
