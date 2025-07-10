# Template Catalog

**Purpose**: Complete reference for all Simone framework templates  
**Audience**: All team members, Template maintainers  
**Last Updated**: 2025-01-10

## Overview

Simone's template system provides standardized, enterprise-grade documentation templates with comprehensive metadata management. Each template includes rich YAML frontmatter, structured sections, and integrated quality controls.

## Template Categories

### 🏗️ Project Foundation Templates
Core templates for project structure and governance

### 📋 Planning & Requirements Templates  
Strategic planning and requirement documentation

### 🎯 Execution & Quality Templates
Task execution and quality assurance documentation

### 🔄 DevOps & Release Templates
Development workflow and release management

### 📊 Review & Governance Templates
Project health and governance documentation

---

## 🏗️ Project Foundation Templates

### Project Manifest Template
**File**: `project_manifest_template.md`  
**Purpose**: Central project reference and health dashboard  
**When to Use**: Once per project during initialization

#### Key Features
- **Real-time status tracking** with health metrics
- **Sprint velocity** and capacity management  
- **Risk assessment** and mitigation tracking
- **Stakeholder communication** hub
- **Technical health** monitoring (coverage, debt, performance)

#### Metadata Fields (15+ fields)
```yaml
project_id: "{PROJECT_ID}"
project_name: "{PROJECT_NAME}"
project_type: "{PROJECT_TYPE}"         # web_app, mobile_app, api, library, tool
status: "{STATUS}"                     # active, maintenance, deprecated
health_score: "{HEALTH_SCORE}"         # 1-10 overall project health
current_milestone: "{MILESTONE_ID}"
current_sprint: "{SPRINT_ID}"
team_size: "{TEAM_SIZE}"
tech_stack: ["{TECH_1}", "{TECH_2}"]
```

#### Template Sections
1. **Project Overview** - Vision, goals, and strategic context
2. **Current Status** - Active milestone and sprint progress
3. **Health Metrics** - Test coverage, technical debt, performance
4. **Team & Resources** - Team composition and capacity
5. **Risk Management** - Current risks and mitigation strategies
6. **Architecture Summary** - High-level technical decisions
7. **Stakeholder Communication** - Updates and announcements

### Architecture Template  
**File**: `architecture_template.md`  
**Purpose**: Living architecture documentation with visual diagrams  
**When to Use**: Project initialization and major architecture changes

#### Key Features
- **Tech stack documentation** with Mermaid diagrams
- **Development workflow** integration
- **Performance and scalability** considerations
- **Security architecture** and compliance requirements
- **Evolution strategy** and technical debt management

#### Visual Documentation Standards
- **System Architecture**: `graph TD` Mermaid diagrams
- **Data Flow**: `sequenceDiagram` for API interactions
- **Deployment**: `flowchart` for infrastructure
- **State Management**: `stateDiagram-v2` for workflows

---

## 📋 Planning & Requirements Templates

### Milestone Meta Template
**File**: `milestone_meta_template.md`  
**Purpose**: Comprehensive milestone tracking and strategic planning  
**When to Use**: Major feature releases and strategic initiatives

#### Key Features
- **Strategic context** and business objectives
- **Sprint breakdown** with dependencies and timeline
- **Resource planning** and team composition requirements
- **Risk management** with detailed mitigation strategies
- **Success metrics** and KPIs with measurement plans
- **Quality standards** and deployment criteria

#### Metadata Fields (18+ fields)
```yaml
milestone_id: "{MILESTONE_ID}"
milestone_title: "{MILESTONE_TITLE}"
business_priority: "{PRIORITY}"        # critical, high, medium, low
strategic_theme: "{THEME}"             # growth, efficiency, innovation, maintenance
target_completion: "{DATE}"
budget_allocated: "{BUDGET}"
success_metrics: ["{METRIC_1}", "{METRIC_2}"]
stakeholders: ["{STAKEHOLDER_1}", "{STAKEHOLDER_2}"]
```

### Sprint Meta Template
**File**: `sprint_meta_template.md`  
**Purpose**: Detailed sprint planning and execution tracking  
**When to Use**: Beginning of each development sprint

#### Key Features
- **Capacity planning** with team utilization tracking
- **Task breakdown** with priority and complexity management
- **Quality gates** and definition of done criteria
- **Risk assessment** and dependency tracking
- **Progress metrics** and velocity measurement
- **Stakeholder communication** and reporting

### PRD Template
**File**: `prd_template.md`  
**Purpose**: Product Requirements Document for feature development  
**When to Use**: New features and product initiatives

#### Key Features
- **User personas** and journey mapping
- **Functional requirements** with detailed specifications
- **Non-functional requirements** (performance, security, usability)
- **Technical constraints** and integration requirements
- **Testing strategy** and acceptance criteria
- **Implementation planning** with resource allocation

### Technical Specifications Template
**File**: `specs_template.md`  
**Purpose**: Detailed technical implementation guidance  
**When to Use**: Complex features requiring detailed technical planning

#### Key Features
- **System architecture** and component design
- **API specifications** with detailed endpoint documentation
- **Database design** and data models
- **Security architecture** and threat modeling
- **Performance requirements** and testing strategy
- **Implementation phases** and deployment strategy

---

## 🎯 Execution & Quality Templates

### Task Template
**File**: `task_template.md`  
**Purpose**: Comprehensive task management with implementation guidance  
**When to Use**: All development work items

#### Key Features
- **Detailed YAML frontmatter** with 21+ metadata fields
- **Business and technical context** integration
- **Phased implementation** with subtask breakdown
- **Risk assessment** and mitigation planning
- **Quality checklists** and review processes
- **Comprehensive output logging** and retrospectives

#### Metadata Fields (21+ fields)
```yaml
task_id: "{TASK_ID}"
task_title: "{TASK_TITLE}"
task_type: "{TASK_TYPE}"               # feature, bug, refactor, documentation, infrastructure, research
milestone_id: "{MILESTONE_ID}"
sprint_id: "{SPRINT_ID}"
status: "{STATUS}"                     # pending, in_progress, review, testing, completed, blocked
priority: "{PRIORITY}"                 # low, medium, high, critical
complexity: "{COMPLEXITY}"             # simple, medium, complex, very_complex
estimated_effort: "{ESTIMATED_EFFORT}" # hours
actual_effort: "{ACTUAL_EFFORT}"       # hours
assignee: "{ASSIGNEE}"
dependencies: ["{DEPENDENCY_1}"]
blocked_by: ["{BLOCKER_1}"]
tags: ["{TAG_1}", "{TAG_2}"]
risk_level: "{RISK_LEVEL}"             # low, medium, high
business_value: "{BUSINESS_VALUE}"     # low, medium, high, critical
technical_value: "{TECHNICAL_VALUE}"   # low, medium, high, critical
```

#### Template Sections
1. **Overview** - Description, context, success criteria
2. **Requirements** - Functional, non-functional, acceptance criteria
3. **Technical Implementation** - Architecture impact, design, approach
4. **Testing Strategy** - Unit, integration, E2E, performance tests
5. **Dependencies & Constraints** - Prerequisites and limitations
6. **Risk Assessment** - Identified risks and mitigation plans
7. **Implementation Subtasks** - Phase-by-phase breakdown
8. **Quality Checklist** - Code quality, testing, documentation standards
9. **Review & Approval** - Approval criteria and reviewers
10. **Output Log** - Implementation notes and decisions
11. **Post-Completion** - Retrospective and lessons learned

### Bug Template
**File**: `bug_template.md`  
**Purpose**: Structured bug reporting and resolution tracking  
**When to Use**: All bug reports and issue tracking

#### Key Features
- **Detailed reproduction steps** and environment information
- **Impact assessment** (user, business, technical impact)
- **Evidence collection** (screenshots, logs, network traces)
- **Root cause analysis** and fix strategy documentation
- **Testing requirements** and verification criteria
- **Progress tracking** and relationship management

#### Metadata Fields (24+ fields)
```yaml
bug_id: "{BUG_ID}"
bug_title: "{BUG_TITLE}"
severity: "{SEVERITY}"                 # critical, high, medium, low
priority: "{PRIORITY}"                 # critical, high, medium, low
status: "{STATUS}"                     # open, in_progress, testing, closed, wont_fix
component: "{COMPONENT}"               # frontend, backend, database, api, infrastructure
environment: "{ENVIRONMENT}"          # production, staging, development, local
browser: "{BROWSER}"                   # if applicable
os: "{OS}"                            # if applicable
version: "{VERSION}"                   # product version where bug was found
reproduction_rate: "{RATE}"           # always, sometimes, rare
estimated_effort: "{EFFORT}"          # hours to fix
```

### ADR Template
**File**: `adr_template.md`  
**Purpose**: Architecture Decision Records with comprehensive analysis  
**When to Use**: Significant architectural or technical decisions

#### Key Features
- **Structured decision process** with stakeholder input
- **Alternative analysis** with decision matrix
- **Implementation planning** with risk assessment
- **Success metrics** and monitoring plan
- **Compliance and governance** integration
- **Review checklist** and status tracking

---

## 🔄 DevOps & Release Templates

### Commit Template
**File**: `commit_template.md`  
**Purpose**: Standardized commit message format with semantic versioning  
**When to Use**: All code commits (automated via `/commit` command)

#### Key Features
- **Structured commit types** (feat, fix, refactor, docs, test, etc.)
- **Scope identification** (component or area affected)
- **Task/bug ID integration** for traceability
- **Semantic versioning impact** guidance
- **Branch-specific templates** for different workflow types

#### Commit Message Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Example**:
```
feat(auth): implement T01_S02 JWT token validation

- Add middleware for token verification
- Implement refresh token rotation
- Add comprehensive error handling
- Include rate limiting for auth endpoints

Refs: TASK_01_S02_User_Authentication.md
Closes: #123
```

### Pull Request Template
**File**: `pr_template.md`  
**Purpose**: Comprehensive PR documentation with quality gates  
**When to Use**: All pull requests (automated via `/create_pr` command)

#### Key Features
- **AI-generated content** from task context and git history
- **Dynamic checklists** based on change type and impact
- **Code quality criteria** and security review requirements
- **Testing requirements** and deployment considerations
- **Integration** with task/bug tracking and project management

#### Template Sections
1. **Summary** - Changes overview with task/bug references
2. **Implementation Details** - Technical approach and decisions
3. **Testing** - Test coverage and validation approach
4. **Quality Checklist** - Dynamic checklist based on changes
5. **Deployment Notes** - Deployment considerations and requirements
6. **Review Criteria** - Specific review focus areas

### Release Template
**File**: `release_template.md`  
**Purpose**: Professional release documentation with metrics  
**When to Use**: Version releases and deployments

#### Key Features
- **Automated content generation** from git history and task completion
- **Semantic versioning** integration with changelog generation
- **Breaking change detection** and migration guides
- **Quality metrics** and performance benchmarks
- **Stakeholder communication** variants for different audiences

---

## 📊 Review & Governance Templates

### Project Review Template
**File**: `project_review_template.md`  
**Purpose**: Comprehensive project health assessment  
**When to Use**: End of sprints, milestones, or regular health checks

#### Key Features
- **Multi-dimensional health metrics** across technical and process areas
- **Architecture compliance assessment** with ADR alignment
- **Development process evaluation** and team performance metrics
- **Risk assessment** and mitigation progress tracking
- **Actionable recommendations** with ownership and timelines

#### Review Coverage Areas
1. **Test Infrastructure Health** - Coverage, quality, automation
2. **Documentation Alignment** - Completeness and currency
3. **Architecture Assessment** - Compliance and evolution
4. **File Organization** - Structure and maintainability
5. **Technical Decision Evaluation** - ADR effectiveness
6. **Process Assessment** - Development workflow efficiency
7. **Team Performance** - Velocity and collaboration metrics

---

## Template Usage Guidelines

### Template Selection Matrix

| Project Phase | Primary Templates | Secondary Templates |
|---------------|-------------------|-------------------|
| **Initialization** | Project Manifest, Architecture | ADR, Specs |
| **Planning** | Milestone Meta, Sprint Meta, PRD | Technical Specs |
| **Development** | Task, Bug | Commit, PR |
| **Review** | Project Review | Release |
| **Governance** | ADR | All templates for compliance |

### Customization Guidelines

#### Organization-Specific Customization
1. **Metadata fields** - Add organization-specific tracking fields
2. **Quality standards** - Customize quality checklists for your standards
3. **Approval workflows** - Modify review and approval sections
4. **Integration points** - Add references to your toolchain
5. **Compliance requirements** - Include regulatory or compliance sections

#### Template Versioning
- **Template version tracking** in metadata
- **Backward compatibility** for existing documents
- **Migration procedures** when templates are updated
- **Change management** process for template modifications

### Best Practices

#### Template Usage Best Practices
1. **Use templates consistently** - Don't skip sections or create ad-hoc documentation
2. **Fill metadata completely** - Rich metadata enables automation and reporting
3. **Update templates** - Keep documents current as work progresses
4. **Cross-reference appropriately** - Link related documents and decisions
5. **Maintain quality** - Follow template guidelines for section completeness

#### Template Maintenance Best Practices
1. **Regular reviews** - Assess template effectiveness quarterly
2. **Feedback collection** - Gather user feedback on template usability
3. **Continuous improvement** - Update templates based on lessons learned
4. **Version management** - Track template changes and provide migration guides
5. **Training and onboarding** - Ensure team understands template usage

## Integration with Simone Commands

### Automated Template Usage
Many Simone commands automatically use templates:

| Command | Template Used | Auto-Generated Content |
|---------|---------------|----------------------|
| `/project:simone:initialize` | Project Manifest, Architecture | Project metadata, tech stack |
| `/project:simone:create_sprint_tasks` | Task Template | Task metadata, implementation guidance |
| `/project:simone:create_bug` | Bug Template | Bug metadata, reproduction steps |
| `/project:simone:commit` | Commit Template | Semantic commit messages |
| `/project:simone:create_pr` | PR Template | PR description, quality checklists |
| `/project:simone:project_review` | Project Review Template | Health metrics, recommendations |

### Template Validation
Simone includes built-in template validation:
- **Metadata completeness** - Ensures required fields are populated
- **Cross-reference integrity** - Validates links between documents
- **Consistency checks** - Verifies naming conventions and structure
- **Quality standards** - Enforces documentation quality requirements

---

**Next Steps**: Explore specific template categories in detail:
- [Task Templates](./task-templates.md) for execution documentation
- [Planning Templates](./planning-templates.md) for strategic planning
- [Quality Templates](./quality-templates.md) for governance and review