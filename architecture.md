# Gaji Backend Architecture

**Version:** 2.0 (Modular Monolith Refactoring)
**Date:** 2026-02-23

## 1. Architectural Style: Modular Monolith

The **Gaji Backend** serves as the core business logic and API layer for the Gaji platform. We have adopted a **Modular Monolith** architecture to combine the simplicity of a monolithic deployment with the strong boundaries and maintainability of microservices.

The project is organized as a **Gradle Multi-Module** build, enforcing strict dependency rules between modules to prevent architectural erosion.

---

## 2. Project Structure

The codebase is divided into three distinct layers of modules:

### 2.1. `apps` (Application Layer)
These modules are the **executable entry points**. They contain the `SpringBootApplication` class, configuration, and controllers. They strictly **do not** contain business logic; instead, they orchestrate logic by delegating to `domains`.

- **`api-app`**: The primary REST API server for client applications (Web/Mobile).
  - Handles HTTP requests, authentication, and response formatting.
- **`admin-app`**: Internal administration and operations server.
  - Manages system configuration, feature flags, and operational dashboards.
- **`batch-app`**: Background processing and scheduled jobs.
  - Novel ingestion, statistics aggregation, etc.

**Dependency Rule**: `apps` -> `domains`, `shared-kernel`

### 2.2. `domains` (Business Layer)
These modules encapsulate specific business capabilities. Each domain is an independent unit following **DDD (Domain-Driven Design)** principles.

- **`auth-domain`**: User authentication, authorization, token management.
- **`content-domain`**: Management of novels, books, and static content.
- **`scenario-domain`**: Core "forking scenario" logic and state management.
- **`chat-domain`**: Conversation history, message persistence.
- **`social-domain`**: Community features (likes, follows, comments).
- **`search-domain`**: Search functionality abstraction.
- **`ai-domain`**: Integration with LLM generation, pgvector retrieval, and Elasticsearch retrieval.

**Dependency Rule**: `domains` -> `shared-kernel`.
*(Note: Domains should minimize direct dependencies on other domains. Communication is preferred via Domain Events or explicit Service Interfaces.)*

### 2.3. `shared-kernel` (Infrastructure & Core)
This module contains common utilities, base classes, and cross-cutting concerns shared by all domains.

- **Base Entities**: `BaseTimeEntity` (JPA Auditing).
- **Global Config**: `QueryDslConfig`, Security configurations.
- **Exceptions**: Standardized error handling (`BadRequestException`, etc.).
- **Utils**: Helper classes for Date/Time, String manipulation.

**Dependency Rule**: `shared-kernel` depends ONLY on external libraries.

---

## 3. Technology Stack

| Category | Technology | Version | Description |
|----------|------------|---------|-------------|
| **Language** | Java | 17 | LTS Version |
| **Framework** | Spring Boot | 3.2.1 | Application Framework |
| **Build Tool** | Gradle | 8.x | Multi-module Build System |
| **Persistence** | Spring Data JPA | - | ORM / Repository Abstraction |
| **Query Engine** | QueryDSL | 5.0.0 | Type-safe Dynamic SQL |
| **Database** | PostgreSQL | 15+ | Primary Relational DB |
| **Testing** | JUnit 5 | - | Unit/Integration Testing |
| **Architecture** | ArchUnit | - | Architecture Layout Verification |
| **Monitoring** | Micrometer | - | Metrics & Observability |

---

## 4. Module Internal Design (Layered DDD Architecture)

Each `domain` module follows a simplified **Layered DDD** structure. Unlike full Hexagonal Architecture, we focus on a clear unidirectional or concentric flow where the **Domain** is the core, surrounded by **Application** and **Infrastructure**.

```text
com.gaji.<domain-name>
├── api           (Presentation Layer)
│   ├── controller
│   └── dto (Request/Response DTOs)
├── application   (Application Layer)
│   ├── service   (Application Services / Use Cases)
│   └── dto       (Internal DTOs if needed)
├── domain        (Domain Layer - Core)
│   ├── model     (Entities, Value Objects)
│   ├── service   (Domain Services)
│   └── repository(Repository Interfaces)
└── infrastructure(Infrastructure Layer)
    └── persistence
        ├── entity (JPA Entities - if separated from Domain Model)
        └── repository (Repository Implementations)
```

### Dependency Rules (Enforced by ArchUnit)
1. **Domain Layer**: The core. Depends on NOTHING (Pure Java). Defines Repository Interfaces.
2. **Application Layer**: Depends on **Domain**. Orchestrates business flows.
3. **Infrastructure Layer**: Depends on **Domain** (implements Repositories) and **Application**.
4. **API Layer**: Depends on **Application** (calls Services) and **Domain** (uses DTOs/models).

---

## 5. Development Guidelines

### 5.1. Adding a New Feature
1. **Identify Domain**: Does it belong to an existing domain or a new one?
2. **Define Domain Model**: Create Entities and Value Objects in `domain.model`.
3. **Define Repository Interface**: Add interface in `domain.repository`.
4. **Implement Application Service**:
   - Implement business logic in `application.service`.
   - Use Domain Entities and Repositories.
5. **Implement Infrastructure**:
   - Implement Repository interface in `infrastructure.persistence`.
6. **Expose Endpoint**:
   - Create Controller in `api` package calling the Application Service.

### 5.2. Testing Strategy
- **Unit Tests**: Focus on `domain` logic and `application` services (mocking ports).
- **Integration Tests**: Verify `infrastructure` adapters with H2/TestContainers.
- **Architecture Tests**: Run `ArchUnit` tests to ensure no layer violations.

### 5.3. Database Migrations
- Each domain owns its schema (logical ownership).
- Flyway is used for schema versioning.
- **Constraint**: No cross-domain foreign keys (logical FKs only) to support future microservice split.
