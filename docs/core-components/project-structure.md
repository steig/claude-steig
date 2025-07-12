# Project Structure

**Last Updated**: 2025-07-10  
**Version**: 2.1.0  
**Framework**: Simone Framework

## Overview

The Simone Framework uses a well-organized directory structure to manage all aspects of your software development lifecycle. This document provides a comprehensive guide to the project structure, naming conventions, and best practices for organizing your project files.

## Core Directory Structure

```
your-project/
├── .simone/                    # Simone framework directory
│   ├── 00_PROJECT_MANIFEST.md  # Central project reference
│   ├── 01_PROJECT_DOCS/        # Technical foundation documents
│   ├── 02_REQUIREMENTS/        # Business requirements by milestone
│   ├── 03_SPRINTS/            # Sprint organization and task definitions
│   ├── 04_GENERAL_TASKS/      # Non-sprint specific tasks
│   ├── 05_ARCHITECTURAL_DECISIONS/ # ADRs for key decisions
│   ├── 06_BUGS/               # Bug tracking and resolution
│   ├── 07_TECHNICAL_DEBT/     # Technical debt tracking and management
│   ├── 10_STATE_OF_PROJECT/   # Project review history
│   ├── 99_TEMPLATES/          # Standardized file templates
│   └── config.yml             # Project configuration
├── .claude/                   # Claude Code configuration
│   ├── CLAUDE.md             # Claude-specific instructions
│   ├── commands/             # Custom commands
│   └── templates/            # Claude templates
├── src/                      # Source code
├── tests/                    # Test files
├── docs/                     # Project documentation
├── scripts/                  # Build and utility scripts
└── README.md                 # Project overview
```

## Directory Details

### `.simone/` - Framework Core

The `.simone/` directory is the heart of the Simone Framework, containing all project management artifacts organized in a numbered structure for optimal sorting and navigation.

#### Core Structure Overview

```
.simone/
├── 00_PROJECT_MANIFEST.md          # Central project reference
├── 01_PROJECT_DOCS/                # Technical foundation documents
├── 02_REQUIREMENTS/                # Business requirements by milestone
├── 03_SPRINTS/                     # Sprint organization and task definitions
├── 04_GENERAL_TASKS/               # Non-sprint specific tasks
├── 05_ARCHITECTURAL_DECISIONS/     # ADRs for key decisions
├── 06_BUGS/                        # Bug tracking and resolution
├── 07_TECHNICAL_DEBT/              # Technical debt tracking and management
├── 10_STATE_OF_PROJECT/            # Project review history
└── 99_TEMPLATES/                   # Standardized file templates
```

#### `00_PROJECT_MANIFEST.md` - Central Reference

The project manifest is the single source of truth for project status:

```yaml
---
project_name: "Example Project"
project_description: "A sample project demonstrating Simone Framework"
current_milestone: "M01_Core_Platform"
current_sprint: "S01_M01_Foundation"
project_status: "active"
last_updated: "2025-01-10"
---

# Project Manifest

## Current Focus
- **Milestone**: M01 - Core Platform Development
- **Sprint**: S01 - Foundation Setup
- **Key Objectives**: User authentication, basic CRUD operations

## Quick Links
- [Current Sprint](03_SPRINTS/S01_M01_Foundation/)
- [Architecture](01_PROJECT_DOCS/ARCHITECTURE.md)
- [Requirements](02_REQUIREMENTS/M01_Core_Platform/)
```

#### `01_PROJECT_DOCS/` - Technical Foundation

Essential technical documentation that guides development:

```
01_PROJECT_DOCS/
├── ARCHITECTURE.md             # System architecture (REQUIRED)
├── API_SPECIFICATION.md        # API documentation
├── DATABASE_SCHEMA.md          # Database design
├── INTEGRATION_GUIDES.md       # Third-party integrations
└── SECURITY_REQUIREMENTS.md    # Security specifications
```

#### `02_REQUIREMENTS/` - Milestone-Based Requirements

Organized by milestone with PRDs and technical specifications:

```
02_REQUIREMENTS/
├── M01_Core_Platform/
│   ├── M01_PRD.md              # Product Requirements Document
│   ├── M01_SPECS.md            # Technical Specifications
│   └── M01_milestone_meta.md   # Milestone metadata
└── M02_User_Management/
    ├── M02_PRD.md
    ├── M02_SPECS.md
    └── M02_milestone_meta.md
```

#### `03_SPRINTS/` - Sprint Execution

Sprint planning and task organization:

```
03_SPRINTS/
├── S01_M01_Foundation/
│   ├── S01_M01_sprint_meta.md  # Sprint metadata and goals
│   ├── TASK_001_Setup_Database.md
│   └── TASK_002_Auth_Framework.md
└── S02_M01_Core_Features/
    ├── S02_M01_sprint_meta.md
    └── TASK_003_User_CRUD.md
```

#### `04_GENERAL_TASKS/` - Non-Sprint Tasks

Tasks that don't belong to specific sprints:

```
04_GENERAL_TASKS/
├── TASK_15_Code_Refactoring.md
├── TASK_16_Documentation_Update.md
└── TASK_17_Performance_Optimization.md
```

#### `05_ARCHITECTURAL_DECISIONS/` - ADRs

Architectural Decision Records for key technical choices:

```
05_ARCHITECTURAL_DECISIONS/
├── ADR_001_Database_Choice.md
├── ADR_002_Authentication_Strategy.md
└── ADR_003_API_Design_Pattern.md
```

#### `06_BUGS/` - Bug Tracking

Bug reports and resolution tracking:

```
06_BUGS/
├── BUG_001_Login_Timeout.md
├── BUG_002_Memory_Leak.md
└── RESOLVED/
    └── BUG_000_Initial_Setup.md
```

#### `07_TECHNICAL_DEBT/` - Debt Management

**NEW**: Technical debt tracking and management system:

```
07_TECHNICAL_DEBT/
├── CLAUDE.md                   # Usage instructions and guidelines
├── DEBT_REGISTRY.md           # Master registry of all debt items
├── ACTIVE/                    # Current debt items requiring attention
│   ├── TD_001_duplicate_validation.md
│   ├── TD_002_inefficient_queries.md
│   └── TD_003_missing_error_handling.md
└── RESOLVED/                  # Archive of resolved debt items
    └── TD_000_setup_example.md
```

The technical debt system provides:

- **Structured Categorization**: Code quality, architecture, security, performance, documentation, testing
- **Severity Assessment**: Critical, high, medium, low priority levels
- **Impact Analysis**: Quantified development velocity and maintenance cost impact
- **Resolution Planning**: Effort estimation, dependency tracking, and strategic timing
- **Workflow Integration**: Seamless integration with existing Simone commands and processes

Each debt item includes comprehensive metadata for tracking:

```yaml
---
debt_id: "TD_001"
title: "Duplicate User Validation Logic"
category: "code_quality"
severity: "medium"
created_date: "2025-01-10"
status: "active"
estimated_effort: "4"
business_impact: "Increased maintenance burden"
technical_impact: "Code duplication across 3 components"
---
```

#### `10_STATE_OF_PROJECT/` - Project Reviews

Timestamped project health snapshots:

```
10_STATE_OF_PROJECT/
├── 2025-01-01_08-00_project_review.md
├── 2025-01-15_14-30_milestone_review.md
└── 2025-01-30_16-00_sprint_retrospective.md
```

#### `99_TEMPLATES/` - File Templates

Standardized templates for consistent documentation:

```
99_TEMPLATES/
├── task_template.md
├── technical_debt_template.md     # NEW: Technical debt template
├── milestone_meta_template.md
├── sprint_meta_template.md
├── bug_template.md
├── adr_template.md
└── project_review_template.md
```

#### Legacy Structure (`milestones/`)

Stores milestone definitions and tracking:

```
milestones/
├── active/
│   ├── q1-2025-product-launch.yml
│   └── q2-2025-scaling.yml
├── completed/
│   └── mvp-release.yml
└── templates/
    └── milestone-template.yml
```

Example milestone structure:
```yaml
# milestones/active/q1-2025-product-launch.yml
metadata:
  title: "Q1 2025 Product Launch"
  description: "Initial product release with core features"
  status: "active"
  start_date: "2025-01-01"
  target_date: "2025-03-31"
  owner: "@product-team"
  
objectives:
  - "Launch MVP with core features"
  - "Achieve 95% test coverage"
  - "Complete security audit"
  
deliverables:
  - name: "User Authentication"
    status: "completed"
  - name: "Payment Integration"
    status: "in-progress"
  - name: "Admin Dashboard"
    status: "planned"
```

#### `sprints/`

Contains sprint planning and execution data:

```
sprints/
├── current/
│   └── sprint-2025-01-15.yml
├── upcoming/
│   └── sprint-2025-01-29.yml
├── completed/
│   ├── sprint-2025-01-01.yml
│   └── sprint-2024-12-15.yml
└── retrospectives/
    └── sprint-2025-01-01-retro.md
```

Sprint file structure:
```yaml
# sprints/current/sprint-2025-01-15.yml
metadata:
  sprint_number: 42
  start_date: "2025-01-15"
  end_date: "2025-01-29"
  milestone: "q1-2025-product-launch"
  team_capacity: 160  # hours
  
goals:
  - "Complete user authentication flow"
  - "Implement payment gateway integration"
  - "Fix critical production bugs"
  
tasks:
  - task_id: "TASK-001"
    status: "in-progress"
    assignee: "@jane.doe"
  - task_id: "TASK-002"
    status: "completed"
    assignee: "@john.smith"
```

#### `tasks/`

Individual task definitions and tracking:

```
tasks/
├── active/
│   ├── TASK-001-implement-login.yml
│   └── TASK-002-fix-memory-leak.yml
├── completed/
│   └── 2025-01/
│       └── TASK-000-setup-ci.yml
└── templates/
    ├── bug-fix.yml
    ├── feature.yml
    └── technical-debt.yml
```

Task structure:
```yaml
# tasks/active/TASK-001-implement-login.yml
metadata:
  task_id: "TASK-001"
  title: "Implement user login flow"
  type: "feature"
  priority: "high"
  status: "in-progress"
  sprint: "sprint-2025-01-15"
  
description: |
  Implement secure user authentication with JWT tokens
  
technical_details:
  components:
    - "auth-service"
    - "frontend-login"
    - "jwt-middleware"
  
  dependencies:
    - "database-schema"
    - "security-policy"
    
estimation:
  original: 8  # hours
  remaining: 3
  
assignee: "@jane.doe"
reviewer: "@john.smith"
```

#### `templates/`

Custom project templates that extend the framework defaults:

```
templates/
├── tasks/
│   ├── security-review.yml
│   └── performance-optimization.yml
├── documents/
│   ├── design-review.md
│   └── post-mortem.md
└── checklists/
    ├── deployment.md
    └── code-review.md
```

#### `governance/`

Project policies and governance documents:

```
governance/
├── policies/
│   ├── code-standards.md
│   ├── security-policy.yml
│   └── review-requirements.yml
├── compliance/
│   ├── gdpr-checklist.md
│   └── sox-compliance.yml
└── approvals/
    └── decision-log.yml
```

#### `metrics/`

Performance and quality metrics tracking:

```
metrics/
├── velocity/
│   ├── 2025-01.json
│   └── historical.json
├── quality/
│   ├── code-coverage.json
│   ├── bug-metrics.json
│   └── technical-debt.json
└── dashboards/
    └── team-performance.json
```

#### `teams/`

Team structure and member information:

```
teams/
├── structure.yml
├── members/
│   ├── jane-doe.yml
│   └── john-smith.yml
└── capacity/
    └── 2025-q1.yml
```

### `.claude/` - Claude Code Integration

Contains Claude-specific configuration and customizations:

```
.claude/
├── CLAUDE.md                  # Project-specific Claude instructions
├── commands/
│   └── simone/               # Simone-specific commands
│       ├── quick-fix.md
│       └── review-pr.md
└── templates/
    └── responses/
        └── code-review.md
```

### Source Code Organization

#### `src/` - Application Source

Organize based on your project's architecture:

**Monolithic Structure:**
```
src/
├── controllers/
├── models/
├── services/
├── utils/
└── config/
```

**Microservices Structure:**
```
src/
├── services/
│   ├── auth-service/
│   ├── payment-service/
│   └── user-service/
├── shared/
│   ├── utils/
│   └── types/
└── gateway/
```

**Frontend Structure:**
```
src/
├── components/
├── pages/
├── hooks/
├── utils/
├── styles/
└── assets/
```

### `tests/` - Test Organization

Mirror your source structure:

```
tests/
├── unit/
│   ├── controllers/
│   ├── models/
│   └── services/
├── integration/
│   ├── api/
│   └── database/
├── e2e/
│   ├── user-flows/
│   └── admin-flows/
└── fixtures/
    └── test-data/
```

### `docs/` - Documentation

Comprehensive project documentation:

```
docs/
├── api/
│   ├── rest-api.md
│   └── graphql-schema.md
├── architecture/
│   ├── system-design.md
│   ├── database-schema.md
│   └── decisions/          # ADRs
├── guides/
│   ├── development.md
│   ├── deployment.md
│   └── troubleshooting.md
└── diagrams/
    ├── architecture.puml
    └── sequence-diagrams/
```

## Naming Conventions

### Files and Directories

**General Rules:**
- Use lowercase with hyphens: `user-service.js`, `api-gateway/`
- Be descriptive but concise: `auth-middleware.js` not `m.js`
- Group related files: `user-auth/`, `payment-processing/`

**Specific Patterns:**
- Tasks: `TASK-{number}-{brief-description}.yml`
- Milestones: `{quarter}-{year}-{name}.yml`
- Sprints: `sprint-{start-date}.yml`
- ADRs: `ADR-{number}-{title}.md`

### Code Files

**JavaScript/TypeScript:**
```
- Components: PascalCase → UserProfile.tsx
- Utilities: camelCase → formatDate.js
- Constants: UPPER_SNAKE → API_ENDPOINTS.js
- Interfaces: PascalCase with I prefix → IUserData.ts
```

**Python:**
```
- Modules: snake_case → user_service.py
- Classes: PascalCase → UserAuthentication
- Functions: snake_case → get_user_data()
- Constants: UPPER_SNAKE → MAX_RETRIES
```

## Best Practices

### 1. Maintain Consistency

- Follow established patterns throughout the project
- Document any deviations in CLAUDE.md
- Use linters and formatters to enforce standards

### 2. Logical Grouping

Group files by:
- **Feature**: All files for a feature together
- **Type**: Similar file types together
- **Layer**: Architectural layers separated

### 3. Avoid Deep Nesting

Keep directory structure shallow:
```
# Good
src/services/user/auth.js

# Avoid
src/services/user/authentication/handlers/login/index.js
```

### 4. Use Index Files

Create index files for cleaner imports:
```javascript
// src/services/index.js
export * from './user-service';
export * from './payment-service';
export * from './notification-service';
```

### 5. Separate Concerns

Keep different aspects of the project separated:
- Source code vs configuration
- Production code vs tests
- Public assets vs private resources

## Environment-Specific Files

### Development
```
.env.development
docker-compose.dev.yml
webpack.dev.js
```

### Production
```
.env.production
docker-compose.prod.yml
webpack.prod.js
```

### Testing
```
.env.test
jest.config.js
cypress.config.js
```

## Git Integration

### Ignored Files

Standard `.gitignore` entries:
```
# Dependencies
node_modules/
vendor/

# Build outputs
dist/
build/
*.pyc

# Environment files
.env
.env.*

# IDE files
.vscode/
.idea/
*.swp

# OS files
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Temporary files
tmp/
temp/
```

### Protected Files

Never commit:
- Private keys
- API credentials
- Database passwords
- Personal information

## Migration Guide

### From Existing Projects

1. **Analyze Current Structure**
   ```bash
   find . -type f -name "*.js" | head -20
   ```

2. **Create Simone Directories**
   ```bash
   claude-code "/project:simone:initialize --preserve-existing"
   ```

3. **Gradually Migrate**
   - Start with new features following structure
   - Refactor existing code incrementally
   - Update imports and references

### Structure Validation

Use Simone's validation command:
```bash
claude-code "/project:simone:validate_structure"
```

This will check:
- Required directories exist
- Naming conventions are followed
- No sensitive files in wrong locations
- Template files are valid

## Customization

### Project-Specific Structure

Add custom directories as needed:
```yaml
# .simone/config.yml
custom_directories:
  - name: "migrations"
    path: "database/migrations"
    description: "Database migration files"
    
  - name: "seeds"
    path: "database/seeds"
    description: "Test data seeds"
```

### Team Preferences

Document team-specific conventions:
```yaml
# .simone/governance/team-conventions.yml
conventions:
  frontend:
    component_structure: "atomic"  # atoms, molecules, organisms
    style_approach: "css-modules"
    
  backend:
    api_style: "rest"  # or graphql
    database_naming: "snake_case"
```

## Tools and Automation

### Structure Generators

Create new components with correct structure:
```bash
# Generate a new service
claude-code "/project:simone:generate_service --name=notification"

# Generate a new feature
claude-code "/project:simone:generate_feature --name=user-profile"
```

### Linting and Validation

Configure tools to enforce structure:
```json
// .eslintrc.json
{
  "rules": {
    "filenames/match-regex": ["error", "^[a-z-]+$", true]
  }
}
```

## Conclusion

A well-organized project structure is crucial for maintainability and team collaboration. The Simone Framework provides a flexible yet opinionated structure that scales from small projects to large enterprise applications. Customize as needed while maintaining consistency and clarity throughout your project.