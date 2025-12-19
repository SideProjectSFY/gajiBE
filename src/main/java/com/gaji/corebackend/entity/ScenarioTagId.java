package com.gaji.corebackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ScenarioTagId implements Serializable {
    private UUID scenarioId;
    private UUID tagId;
}
