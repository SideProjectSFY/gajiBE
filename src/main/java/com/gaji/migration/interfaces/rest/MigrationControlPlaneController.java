package com.gaji.migration.interfaces.rest;

import com.gaji.migration.application.command.UpdateMigrationSettingCommand;
import com.gaji.migration.application.dto.DrillResult;
import com.gaji.migration.application.usecase.ManageMigrationFlagsUseCase;
import com.gaji.migration.application.usecase.PerformRollbackDrillUseCase;
import com.gaji.migration.domain.model.AiPath;
import com.gaji.migration.domain.model.RouteTarget;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Slf4j
@Validated
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/admin/migration")
@Tag(name = "Migration Control Plane", description = "Migration safety feature flags and rollback drills")
public class MigrationControlPlaneController {

    private final ManageMigrationFlagsUseCase manageMigrationFlagsUseCase;
    private final PerformRollbackDrillUseCase performRollbackDrillUseCase;

    @GetMapping("/flags")
    @Operation(summary = "Get migration flag snapshot")
    public ResponseEntity<Map<String, String>> getFlags() {
        return ResponseEntity.ok(manageMigrationFlagsUseCase.getFlagSnapshot());
    }

    @PutMapping("/flags")
    @Operation(summary = "Update migration feature flag")
    public ResponseEntity<Map<String, String>> updateFlag(@Valid @RequestBody UpdateSettingRequest request) {
        manageMigrationFlagsUseCase.updateFlag(new UpdateMigrationSettingCommand(request.key(), request.value(), request.description()));
        return ResponseEntity.ok(Map.of(
                "key", request.key(),
                "value", request.value(),
                "status", "updated"
        ));
    }

    @PutMapping("/kpi-baselines")
    @Operation(summary = "Update migration KPI baseline value for observability dashboard")
    public ResponseEntity<Map<String, String>> updateKpiBaseline(@Valid @RequestBody UpdateSettingRequest request) {
        manageMigrationFlagsUseCase.updateKpiBaseline(new UpdateMigrationSettingCommand(request.key(), request.value(), request.description()));
        return ResponseEntity.ok(Map.of(
                "key", request.key(),
                "value", request.value(),
                "status", "updated"
        ));
    }

    @GetMapping("/routes/{routeKey}/target")
    @Operation(summary = "Resolve route target by migration flag")
    public ResponseEntity<Map<String, String>> resolveRouteTarget(@PathVariable String routeKey) {
        RouteTarget target = manageMigrationFlagsUseCase.resolveRouteTarget(routeKey);
        return ResponseEntity.ok(Map.of(
                "routeKey", routeKey,
                "target", target.name()
        ));
    }

    @GetMapping("/ai-path")
    @Operation(summary = "Resolve AI route path by migration canary flags")
    public ResponseEntity<Map<String, String>> resolveAiPath(
            @RequestParam(defaultValue = "migration-control-plane") String stickinessKey
    ) {
        AiPath aiPath = manageMigrationFlagsUseCase.resolveAiPath(stickinessKey);
        return ResponseEntity.ok(Map.of(
                "stickinessKey", stickinessKey,
                "selectedPath", aiPath.name(),
                "executedPath", AiPath.LEGACY.name()
        ));
    }

    @PostMapping("/drills/ai-rollback")
    @Operation(summary = "Run AI direct-to-legacy rollback drill")
    public ResponseEntity<DrillResult> runAiRollbackDrill(
            @RequestParam(defaultValue = "migration-drill-ai") String stickinessKey
    ) {
        return ResponseEntity.ok(performRollbackDrillUseCase.runAiRollbackDrill(stickinessKey));
    }

    @PostMapping("/drills/route-rollback")
    @Operation(summary = "Run Next.js route-to-legacy rollback drill")
    public ResponseEntity<DrillResult> runRouteRollbackDrill(
            @RequestParam(defaultValue = "catalog") String routeKey
    ) {
        return ResponseEntity.ok(performRollbackDrillUseCase.runRouteRollbackDrill(routeKey));
    }

    public record UpdateSettingRequest(
            @NotBlank String key,
            @NotBlank String value,
            String description
    ) {
    }
}
