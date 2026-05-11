package com.gaji.architecture;

import com.gaji.GajiBackendApplication;
import org.junit.jupiter.api.Test;
import org.springframework.modulith.core.ApplicationModules;

import static org.junit.jupiter.api.Assertions.assertTrue;

class ModulithStructureTest {

    @Test
    void detect_modular_structure() {
        ApplicationModules modules = ApplicationModules.of(GajiBackendApplication.class);
        assertTrue(modules.stream().count() > 0, "At least one application module should be discoverable");
    }
}
