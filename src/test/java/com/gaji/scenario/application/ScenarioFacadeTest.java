package com.gaji.scenario.application;

import com.gaji.shared.contract.dto.ScenarioResponse;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertSame;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class ScenarioFacadeTest {

    private ScenarioService scenarioService;
    private ScenarioFacade scenarioFacade;

    @BeforeEach
    void setUp() {
        scenarioService = Mockito.mock(ScenarioService.class);
        scenarioFacade = new ScenarioFacade(scenarioService);
    }

    @Test
    void getScenario_delegatesToScenarioService() {
        UUID scenarioId = UUID.randomUUID();
        ScenarioResponse expected = Mockito.mock(ScenarioResponse.class);
        when(scenarioService.getScenario(scenarioId)).thenReturn(expected);

        ScenarioResponse actual = scenarioFacade.getScenario(scenarioId);

        assertSame(expected, actual);
        verify(scenarioService).getScenario(scenarioId);
    }
}
