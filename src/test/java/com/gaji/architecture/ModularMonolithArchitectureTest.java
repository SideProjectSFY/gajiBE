package com.gaji.architecture;

import com.tngtech.archunit.core.domain.JavaClasses;
import com.tngtech.archunit.core.importer.ClassFileImporter;
import com.tngtech.archunit.junit.AnalyzeClasses;
import com.tngtech.archunit.junit.ArchTest;
import com.tngtech.archunit.lang.ArchRule;
import org.junit.jupiter.api.Test;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.noClasses;
import static org.junit.jupiter.api.Assertions.assertTrue;

@AnalyzeClasses(packages = "com.gaji")
public class ModularMonolithArchitectureTest {

    private static final List<String> TARGET_DOMAINS = List.of(
            "auth", "content", "scenario", "chat", "social", "search"
    );

    private static final List<String> REQUIRED_LAYERS = List.of(
            "domain", "application", "infrastructure", "interfaces"
    );

    private static final Pattern DOMAIN_PATTERN = Pattern.compile("^com\\.gaji\\.([a-z]+)\\..*");

    @ArchTest
    static final ArchRule no_legacy_corebackend_package_dependency =
            noClasses()
                    .should()
                    .dependOnClassesThat()
                    .resideInAnyPackage("com.gaji.corebackend..");

    @ArchTest
    static final ArchRule domain_layer_must_not_depend_on_framework_packages =
            noClasses()
                    .that().resideInAnyPackage("com.gaji..domain..")
                    .should()
                    .dependOnClassesThat()
                    .resideInAnyPackage(
                            "org.springframework..",
                            "org.apache.ibatis..",
                            "org.mybatis..",
                            "jakarta.persistence..",
                            "jakarta.transaction.."
                    );

    @Test
    void targeted_domains_have_required_ddd_layers() {
        JavaClasses importedClasses = new ClassFileImporter().importPackages("com.gaji");

        for (String domain : TARGET_DOMAINS) {
            for (String layer : REQUIRED_LAYERS) {
                String expectedPrefix = "com.gaji." + domain + "." + layer;
                boolean exists = importedClasses.stream()
                        .anyMatch(javaClass -> javaClass.getPackageName().startsWith(expectedPrefix));

                assertTrue(
                        exists,
                        "Missing required package layer: " + expectedPrefix + ".."
                );
            }
        }
    }

    @Test
    void cross_domain_application_dependencies_must_use_facades() {
        JavaClasses importedClasses = new ClassFileImporter().importPackages("com.gaji");

        for (var sourceClass : importedClasses) {
            String sourceDomain = extractDomain(sourceClass.getPackageName());
            if (!TARGET_DOMAINS.contains(sourceDomain)
                    || !sourceClass.getPackageName().contains(".application.")) {
                continue;
            }

            for (var dependency : sourceClass.getDirectDependenciesFromSelf()) {
                String targetPackage = dependency.getTargetClass().getPackageName();
                String targetDomain = extractDomain(dependency.getTargetClass().getPackageName());
                if (!TARGET_DOMAINS.contains(targetDomain)
                        || sourceDomain.equals(targetDomain)
                        || !targetPackage.contains(".application.")) {
                    continue;
                }
                String targetSimpleName = dependency.getTargetClass().getSimpleName();
                assertTrue(
                        targetSimpleName.endsWith("Facade"),
                        "Cross-domain application dependency must target Facade: "
                                + sourceClass.getFullName() + " -> " + dependency.getTargetClass().getFullName()
                );
            }
        }
    }

    private String extractDomain(String packageName) {
        Matcher matcher = DOMAIN_PATTERN.matcher(packageName + ".");
        if (matcher.find()) {
            return matcher.group(1);
        }
        return "";
    }
}
