package com.gaji.scenario.application;

import com.gaji.shared.contract.dto.ScenarioResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ScenarioFacade {

    private final ScenarioService scenarioService;

    @Transactional(readOnly = true)
    public ScenarioResponse getScenario(UUID scenarioId) {
        return scenarioService.getScenario(scenarioId);
    }

    @Transactional(readOnly = true)
    public java.util.List<ScenarioResponse> findAllScenariosByIds(java.util.List<UUID> scenarioIds) {
        return scenarioService.findAllScenariosByIds(scenarioIds);
    }
}
