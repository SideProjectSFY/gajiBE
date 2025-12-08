# Gaji Backend - API Gateway

Spring Boot backend service implementing **Pattern B Architecture** for the Gaji platform.

## Architecture Overview

**Pattern B: Single API Gateway**

- Frontend → Spring Boot ONLY (port 8080)
- Spring Boot → FastAPI (internal proxy, port 8000)
- **Security**: FastAPI and Gemini API keys never exposed to frontend
- **Cost**: $700/year saved on SSL certificates and domains

## Tech Stack

- **Framework**: Spring Boot 3.2+
- **Language**: Java 17
- **Build Tool**: Gradle 8.x
- **Database**: PostgreSQL (MyBatis) - 13 metadata tables
- **Proxy Client**: Spring WebFlux WebClient
- **Security**: Spring Security + JWT
- **Documentation**: SpringDoc OpenAPI 3

## Prerequisites

- Java 17 or higher
- Gradle 8.x or higher
- PostgreSQL 15+ (for Story 0.3)
- FastAPI service running on port 8000 (optional for now)

## Quick Start

### 1. Build the project

```bash
./gradlew build
```

### 2. Run the application (Dev profile)

```bash
./gradlew bootRun --args='--spring.profiles.active=dev'
```

Or using Java:

```bash
java -jar build/libs/gaji-backend-0.0.1-SNAPSHOT.jar --spring.profiles.active=dev
```

### 3. Verify it's running

- Health Check: http://localhost:8080/actuator/health
- Swagger UI: http://localhost:8080/swagger-ui.html
- API Docs: http://localhost:8080/v3/api-docs

## Project Structure

```
src/main/java/com/gaji/corebackend/
├── config/              # Configuration classes
│   ├── WebClientConfig.java      # FastAPI proxy client
│   ├── CorsConfig.java            # CORS settings
│   └── SecurityConfig.java        # JWT security
├── controller/          # REST controllers
│   ├── AIProxyController.java    # FastAPI proxy
│   └── HealthCheckController.java # Health checks
├── service/             # Business logic (to be added)
├── mapper/              # MyBatis mappers (Story 0.3)
├── domain/              # Domain models (Story 0.3)
├── dto/                 # Request/response DTOs
├── client/              # External service clients
├── exception/           # Exception handlers
│   └── GlobalExceptionHandler.java
└── util/                # Utility classes

src/main/resources/
├── application.yml      # Configuration (dev/staging/prod)
└── mapper/              # MyBatis XML mappers (Story 0.3)
```

## Configuration

### Environment Variables

| Variable               | Description               | Default                                       |
| ---------------------- | ------------------------- | --------------------------------------------- |
| `DB_URL`               | PostgreSQL connection URL | `jdbc:postgresql://localhost:5432/gaji_dev`   |
| `DB_USERNAME`          | Database username         | `postgres`                                    |
| `DB_PASSWORD`          | Database password         | `postgres`                                    |
| `FASTAPI_BASE_URL`     | FastAPI service URL       | `http://localhost:8000`                       |
| `JWT_SECRET`           | JWT signing secret        | (must be set in production)                   |
| `CORS_ALLOWED_ORIGINS` | Allowed frontend origins  | `http://localhost:3000,http://localhost:5173` |

### Profiles

- **dev**: Development (localhost, verbose logging)
- **staging**: Staging environment
- **prod**: Production environment

## API Endpoints

### Health Check

```bash
GET /actuator/health
```

Returns:

```json
{
  "status": "UP",
  "components": {
    "springboot": { "status": "UP" },
    "db": { "status": "NOT_CONFIGURED" },
    "fastapi": { "status": "DOWN", "note": "FastAPI not running" }
  }
}
```

### AI Proxy Routes

All `/api/v1/ai/*` requests are proxied to FastAPI:

```bash
# GET request
GET /api/v1/ai/health → http://localhost:8000/api/health

# POST request
POST /api/v1/ai/chat → http://localhost:8000/api/chat

# Streaming
GET /api/v1/ai/chat/stream → http://localhost:8000/api/chat/stream
```

## Development

### Running Tests

```bash
./gradlew test
```

### Building for Production

```bash
./gradlew clean build -x test
```

### Code Style

This project follows standard Java conventions:

- 4 spaces for indentation
- Camel case for variables and methods
- Pascal case for classes
- Lombok annotations for boilerplate reduction

## WebClient Proxy Configuration

The FastAPI proxy is configured with:

- **Timeout**: 60 seconds (AI operations can be slow)
- **Retry**: 3 attempts with exponential backoff
- **Connection Pool**: 10 max connections
- **Error Handling**: Circuit breaker pattern

## Security Notes

- JWT authentication (to be fully implemented in Epic 6)
- CORS restricted to known frontend domains
- No hardcoded credentials (use environment variables)
- FastAPI URL never exposed to frontend
- Gemini API keys secured in FastAPI service

## Logging

- **Console**: Enabled in dev mode
- **File**: `/var/log/gaji-backend/application.log` (prod only)
- **Log Levels**: DEBUG (dev), INFO (staging), WARN (prod)

## Troubleshooting

### Application won't start

1. Check Java version: `java -version` (must be 17+)
2. Check Gradle version: `./gradlew --version`
3. Check port 8080 is available: `lsof -i :8080`

### FastAPI health check fails

This is expected if FastAPI service is not running. The application will still start successfully.

### Database connection fails

Database configuration will be implemented in Story 0.3. For now, the health check shows "NOT_CONFIGURED".

## Next Steps

- **Story 0.2**: FastAPI AI Service Setup
- **Story 0.3**: PostgreSQL Database Setup
- **Story 0.6**: Inter-Service Health Check
- **Epic 1**: Scenario Foundation APIs
- **Epic 6**: JWT Authentication

## Support

For issues or questions, contact the Gaji team at support@gaji.app
