#!/bin/bash

# Gaji Backend - Quick Start Script
# Builds and runs the Spring Boot application

echo "======================================"
echo "Gaji Backend - Quick Start"
echo "======================================"
echo ""

# Check Java version
echo "Checking Java version..."
java_version=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d'.' -f1)
if [ "$java_version" -lt 17 ]; then
    echo "✗ Java 17 or higher is required"
    echo "  Current version: $(java -version 2>&1 | head -n 1)"
    exit 1
fi
echo "✓ Java version: $(java -version 2>&1 | head -n 1)"
echo ""

# Build the project
echo "Building project..."
./gradlew clean build -x test
if [ $? -ne 0 ]; then
    echo "✗ Build failed"
    exit 1
fi
echo "✓ Build successful"
echo ""

# Start the application
echo "Starting Gaji Backend (dev profile)..."
echo "Application will be available at: http://localhost:8080"
echo ""
echo "Useful URLs:"
echo "  - Health Check: http://localhost:8080/actuator/health"
echo "  - Swagger UI:   http://localhost:8080/swagger-ui.html"
echo "  - API Docs:     http://localhost:8080/v3/api-docs"
echo ""
echo "Press Ctrl+C to stop the application"
echo ""

./gradlew bootRun --args='--spring.profiles.active=dev'
