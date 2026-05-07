package com.gaji.migration.application.service;

import com.gaji.migration.application.command.UpdateMigrationSettingCommand;
import com.gaji.migration.application.dto.DrillResult;
import com.gaji.migration.application.port.out.MigrationMetricsPort;
import com.gaji.migration.application.usecase.ManageMigrationFlagsUseCase;
import com.gaji.migration.application.usecase.PerformRollbackDrillUseCase;
import com.gaji.migration.domain.model.AiPath;
import com.gaji.migration.domain.model.MigrationSetting;
import com.gaji.migration.domain.model.MigrationSettingRepository;
import com.gaji.migration.domain.model.RouteTarget;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class MigrationRollbackDrillService implements PerformRollbackDrillUseCase {

    private static final String AI_ENABLED_KEY = "ff.ai.direct.enabled";
    private static final String AI_KILL_SWITCH_KEY = "ff.ai.direct.kill_switch";
    private static final String AI_PERCENT_KEY = "ff.ai.direct.percent";
    private static final String NEXTJS_ROUTE_PREFIX = "ff.nextjs.route.";

    private final ManageMigrationFlagsUseCase migrationFlagsUseCase;
    private final MigrationSettingRepository repository;
    private final MigrationMetricsPort metricsPort;

    @Override
    public DrillResult runAiRollbackDrill(String stickinessKey) {
        long startedAt = System.currentTimeMillis();
        String safeStickinessKey = (stickinessKey == null || stickinessKey.isBlank()) ? "drill-ai-default" : stickinessKey;

        MigrationSetting originalEnabled = repository.findByKey(AI_ENABLED_KEY);
        MigrationSetting originalKillSwitch = repository.findByKey(AI_KILL_SWITCH_KEY);
        MigrationSetting originalPercent = repository.findByKey(AI_PERCENT_KEY);

        boolean success = false;
        try {
            migrationFlagsUseCase.updateFlag(new UpdateMigrationSettingCommand(AI_ENABLED_KEY, "true", "AI rollback drill - temporary"));
            migrationFlagsUseCase.updateFlag(new UpdateMigrationSettingCommand(AI_KILL_SWITCH_KEY, "false", "AI rollback drill - temporary"));
            migrationFlagsUseCase.updateFlag(new UpdateMigrationSettingCommand(AI_PERCENT_KEY, "100", "AI rollback drill - temporary"));
            AiPath initial = migrationFlagsUseCase.resolveAiPath(safeStickinessKey);

            migrationFlagsUseCase.updateFlag(new UpdateMigrationSettingCommand(AI_ENABLED_KEY, "false", "AI rollback drill - temporary"));
            AiPath rolledBack = migrationFlagsUseCase.resolveAiPath(safeStickinessKey);

            success = initial == AiPath.DIRECT && rolledBack == AiPath.LEGACY;

            long recoveryMs = System.currentTimeMillis() - startedAt;
            metricsPort.recordDrillResult("ai", success, recoveryMs);

            log.info("AI rollback drill completed success={} initial={} rolledBack={} recoveryMs={}",
                    success, initial, rolledBack, recoveryMs);
            return DrillResult.builder()
                    .drillType("ai")
                    .success(success)
                    .initial(initial.name())
                    .rolledBack(rolledBack.name())
                    .recoveryMs(recoveryMs)
                    .build();
        } finally {
            restoreSetting(AI_ENABLED_KEY, originalEnabled, "false", "AI direct enable flag");
            restoreSetting(AI_KILL_SWITCH_KEY, originalKillSwitch, "false", "AI direct kill switch");
            restoreSetting(AI_PERCENT_KEY, originalPercent, "0", "AI direct rollout percent");
        }
    }

    @Override
    public DrillResult runRouteRollbackDrill(String routeKey) {
        long startedAt = System.currentTimeMillis();
        String normalizedRouteKey = routeKey == null || routeKey.isBlank() ? "catalog" : routeKey.toLowerCase();
        String flagKey = NEXTJS_ROUTE_PREFIX + normalizedRouteKey;

        MigrationSetting originalRouteSetting = repository.findByKey(flagKey);
        boolean success = false;
        try {
            migrationFlagsUseCase.updateFlag(new UpdateMigrationSettingCommand(flagKey, "true", "Route rollback drill - temporary"));
            RouteTarget initial = migrationFlagsUseCase.resolveRouteTarget(normalizedRouteKey);

            migrationFlagsUseCase.updateFlag(new UpdateMigrationSettingCommand(flagKey, "false", "Route rollback drill - temporary"));
            RouteTarget rolledBack = migrationFlagsUseCase.resolveRouteTarget(normalizedRouteKey);

            success = initial == RouteTarget.NEXTJS && rolledBack == RouteTarget.LEGACY;

            long recoveryMs = System.currentTimeMillis() - startedAt;
            metricsPort.recordDrillResult("route", success, recoveryMs);

            log.info("Route rollback drill completed routeKey={} success={} initial={} rolledBack={} recoveryMs={}",
                    normalizedRouteKey, success, initial, rolledBack, recoveryMs);
            return DrillResult.builder()
                    .drillType("route")
                    .success(success)
                    .initial(initial.name())
                    .rolledBack(rolledBack.name())
                    .recoveryMs(recoveryMs)
                    .build();
        } finally {
            restoreSetting(flagKey, originalRouteSetting, "false", "Route flag");
        }
    }

    private void restoreSetting(String key, MigrationSetting original, String defaultValue, String description) {
        if (original != null) {
            migrationFlagsUseCase.updateFlag(new UpdateMigrationSettingCommand(key, original.getValue(), original.getDescription()));
        } else {
            migrationFlagsUseCase.updateFlag(new UpdateMigrationSettingCommand(key, defaultValue, description));
        }
    }
}
