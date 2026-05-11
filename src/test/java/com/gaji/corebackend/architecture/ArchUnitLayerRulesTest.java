package com.gaji.architecture;

import com.tngtech.archunit.core.domain.Dependency;
import com.tngtech.archunit.core.domain.JavaClass;
import com.tngtech.archunit.core.domain.JavaClasses;
import com.tngtech.archunit.core.importer.ClassFileImporter;
import com.tngtech.archunit.lang.ArchRule;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.junit.jupiter.api.Assertions.assertTrue;
import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.noClasses;

class ArchUnitLayerRulesTest {

    private static final String BASE = "com.gaji..";
    private static final Pattern APP_PACKAGE = Pattern.compile("^com\\.gaji\\.([a-z]+)\\.application(?:\\..*)?$");
    private static final Pattern MAPPER_PACKAGE = Pattern.compile("^com\\.gaji\\.([a-z]+)\\.infrastructure\\.persistence\\.mapper(?:\\..*)?$");

    @Test
    void domain_models_should_not_depend_on_interfaces_or_application() {
        JavaClasses imported = new ClassFileImporter().importPackages(BASE);

        ArchRule interfacesRule = noClasses()
                .that().resideInAPackage("..domain.model..")
                .should().dependOnClassesThat().resideInAPackage("..interfaces..");

        ArchRule applicationRule = noClasses()
                .that().resideInAPackage("..domain.model..")
                .should().dependOnClassesThat().resideInAPackage("..application..");

        interfacesRule.check(imported);
        applicationRule.check(imported);
    }

    @Test
    void application_should_not_depend_on_interfaces() {
        JavaClasses imported = new ClassFileImporter().importPackages(BASE);

        ArchRule rule = noClasses()
                .that().resideInAPackage("..application..")
                .should().dependOnClassesThat().resideInAPackage("..interfaces..");

        rule.check(imported);
    }

    @Test
    void infrastructure_should_not_depend_on_interfaces() {
        JavaClasses imported = new ClassFileImporter().importPackages(BASE);

        ArchRule rule = noClasses()
                .that().resideInAPackage("..infrastructure..")
                .should().dependOnClassesThat().resideInAPackage("..interfaces..");

        rule.check(imported);
    }

    @Test
    void interfaces_should_not_depend_on_mappers() {
        JavaClasses imported = new ClassFileImporter().importPackages(BASE);

        ArchRule rule = noClasses()
                .that().resideInAPackage("..interfaces..")
                .should().dependOnClassesThat().resideInAPackage("..infrastructure.persistence.mapper..");

        rule.check(imported);
    }

    @Test
    void application_should_not_depend_on_cross_domain_mappers() {
        JavaClasses imported = new ClassFileImporter().importPackages(BASE);
        List<String> violations = new ArrayList<>();

        for (JavaClass sourceClass : imported) {
            String sourcePackage = sourceClass.getPackageName();
            Matcher sourceMatcher = APP_PACKAGE.matcher(sourcePackage);
            if (!sourceMatcher.find()) {
                continue;
            }
            String sourceDomain = sourceMatcher.group(1);

            for (Dependency dependency : sourceClass.getDirectDependenciesFromSelf()) {
                Matcher targetMatcher = MAPPER_PACKAGE.matcher(dependency.getTargetClass().getPackageName());
                if (!targetMatcher.find()) {
                    continue;
                }

                String targetDomain = targetMatcher.group(1);
                if (!sourceDomain.equals(targetDomain)) {
                    violations.add(sourceClass.getFullName() + " -> " + dependency.getTargetClass().getFullName());
                }
            }
        }

        assertTrue(violations.isEmpty(),
                "Disallowed cross-domain mapper dependencies found in application layer:\n" + String.join("\n", violations));
    }

    @Test
    void cross_domain_service_dependencies_should_follow_allow_list() {
        JavaClasses imported = new ClassFileImporter().importPackages(BASE);

        Map<String, Set<String>> allowedDependencies = Map.of(
                "chat", Set.of("scenario", "content"),
                "scenario", Set.of("chat", "content"),
                "social", Set.of("auth", "content", "chat")
        );

        List<String> violations = new ArrayList<>();

        for (JavaClass sourceClass : imported) {
            String sourcePackage = sourceClass.getPackageName();
            Matcher sourceMatcher = APP_PACKAGE.matcher(sourcePackage);
            if (!sourceMatcher.find()) {
                continue;
            }

            String sourceDomain = sourceMatcher.group(1);

            for (Dependency dependency : sourceClass.getDirectDependenciesFromSelf()) {
                String targetPackage = dependency.getTargetClass().getPackageName();
                Matcher targetMatcher = APP_PACKAGE.matcher(targetPackage);
                if (!targetMatcher.find()) {
                    continue;
                }

                String targetDomain = targetMatcher.group(1);
                if (sourceDomain.equals(targetDomain)) {
                    continue;
                }

                boolean allowed = allowedDependencies
                        .getOrDefault(sourceDomain, Set.of())
                        .contains(targetDomain);

                if (!allowed) {
                    violations.add(sourceClass.getFullName() + " -> " + dependency.getTargetClass().getFullName());
                }
            }
        }

        assertTrue(violations.isEmpty(),
                "Disallowed cross-domain application dependencies found:\n" + String.join("\n", violations));
    }
}
