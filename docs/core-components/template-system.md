# Template System Documentation

The Simone Framework provides a comprehensive template system designed to ensure consistency, completeness, and quality across all project documentation.

## Overview

The template system is located in `.simone/99_TEMPLATES/` and provides standardized formats for all document types used in the Simone workflow. Each template includes:

- **YAML frontmatter** with comprehensive metadata
- **Structured content sections** for consistency
- **Placeholder values** for easy customization
- **Cross-reference integration** for project connectivity
- **Quality standards** built into the format

## Template Categories

### 📋 Project Management Templates
- [`project_manifest_template.md`](#project-manifest-template) - Central project tracking
- [`milestone_meta_template.md`](#milestone-meta-template) - Milestone planning and tracking
- [`sprint_meta_template.md`](#sprint-meta-template) - Sprint execution planning
- [`project_review_template.md`](#project-review-template) - Project health assessments

### 🎯 Task & Development Templates
- [`task_template.md`](#task-template) - Individual task specification
- [`technical_debt_template.md`](#technical-debt-template) - Technical debt tracking and resolution
- [`bug_template.md`](#bug-template) - Unified bug handling (reporting, tracking, and resolution)
- [`commit_template.md`](#commit-template) - Structured commit messages
- [`pr_template.md`](#pr-template) - Pull request documentation

### 🏗️ Architecture & Documentation Templates
- [`adr_template.md`](#adr-template) - Architectural Decision Records
- [`architecture_template.md`](#architecture-template) - System architecture documentation with integrated checklist
- [`specs_template.md`](#specs-template) - Technical specifications
- [`prd_template.md`](#prd-template) - Product Requirements Documents

> **Note**: `architecture_initialization_checklist.md` has been deprecated and integrated into `architecture_template.md`

### 🚀 Release & Operations Templates
- [`release_template.md`](#release-template) - Release planning and documentation

---

## Template Details

### project_manifest_template.md

**Purpose**: Central project tracking and status document that provides a comprehensive overview of the entire project.

**Key Features**:
- **Project metadata** with health metrics
- **Current status** tracking (milestone, sprint, overall health)
- **Team information** and capacity planning
- **Quality gates** and compliance tracking
- **Risk assessment** with mitigation strategies
- **Technology stack** documentation

**YAML Frontmatter** (21+ fields):
```yaml
project_name: "{PROJECT_NAME}"
project_version: "{PROJECT_VERSION}"
created_date: "{CREATED_DATE}"
last_updated: "{LAST_UPDATED}"
current_milestone: "{CURRENT_MILESTONE}"
current_sprint: "{CURRENT_SPRINT}"
project_status: "{PROJECT_STATUS}" # planning, active, maintenance, completed, paused
health_metrics:
  test_coverage: {TEST_COVERAGE}
  documentation_complete: {DOCUMENTATION_PERCENTAGE}
  technical_debt_level: "{TECH_DEBT_LEVEL}"
quality_gates:
  code_review_required: true
  automated_testing_required: true
risk_assessment:
  overall_risk_level: "{OVERALL_RISK_LEVEL}"
```

**Content Sections**:
- Executive summary with project vision
- Current milestone and sprint status
- Team structure and responsibilities
- Technology stack and architecture overview
- Quality metrics and health indicators
- Risk assessment and mitigation plans
- Active work items and priorities

**Usage**: Created during project initialization and updated continuously by commands.

---

### task_template.md

**Purpose**: Comprehensive task specification with full lifecycle tracking.

**Key Features**:
- **Rich metadata** with 21+ YAML fields for tracking
- **Requirements specification** with acceptance criteria
- **Technical implementation** guidance
- **Testing requirements** and validation
- **Risk assessment** and mitigation
- **Progress tracking** with output logging

**YAML Frontmatter** (21+ fields):
```yaml
task_id: "{TASK_ID}"
task_title: "{TASK_TITLE}"
task_type: "{TASK_TYPE}" # feature, bug, refactor, documentation, infrastructure, research
milestone_id: "{MILESTONE_ID}"
sprint_id: "{SPRINT_ID}"
status: "{STATUS}" # pending, in_progress, review, testing, completed, blocked
priority: "{PRIORITY}" # low, medium, high, critical
complexity: "{COMPLEXITY}" # simple, medium, complex, very_complex
estimated_effort: "{ESTIMATED_EFFORT}" # hours
assignee: "{ASSIGNEE}"
dependencies: ["{DEPENDENCY_1}", "{DEPENDENCY_2}"]
tags: ["{TAG_1}", "{TAG_2}", "{TAG_3}"]
business_value: "{BUSINESS_VALUE}" # low, medium, high, critical
technical_value: "{TECHNICAL_VALUE}" # low, medium, high, critical
```

**Content Sections**:
- **Overview**: Description, business context, technical context
- **Requirements**: Functional and non-functional requirements
- **Technical Implementation**: Architecture impact, components affected
- **Testing Requirements**: Test cases, coverage, validation
- **Dependencies**: Prerequisites and relationships
- **Risk Assessment**: Potential issues and mitigation
- **Output Log**: Progress tracking and updates

**Usage**: Created by `create_general_task` and `create_sprint_tasks` commands.

---

### adr_template.md

**Purpose**: Architectural Decision Records for documenting important design decisions.

**Key Features**:
- **Decision context** and problem statement
- **Options analysis** with pros/cons
- **Decision rationale** and justification
- **Impact assessment** on system and team
- **Implementation guidance** and next steps
- **Review and update** lifecycle management

**YAML Frontmatter**:
```yaml
adr_id: "{ADR_ID}"
title: "{TITLE}"
status: "{STATUS}" # proposed, accepted, deprecated, superseded, review
decision_type: "{DECISION_TYPE}" # architectural, technical, process, infrastructure, security
impact_level: "{IMPACT_LEVEL}" # low, medium, high, critical
business_value: "{BUSINESS_VALUE}"
technical_value: "{TECHNICAL_VALUE}"
complexity: "{COMPLEXITY}"
risk_level: "{RISK_LEVEL}"
related_adrs: ["{RELATED_ADR_1}", "{RELATED_ADR_2}"]
```

**Content Sections**:
- **Quick Reference**: Decision summary, stakeholders, timeline
- **Context**: Problem statement and background
- **Decision**: Chosen solution and rationale
- **Options Considered**: Alternative approaches analyzed
- **Consequences**: Benefits, risks, trade-offs
- **Implementation**: Action items and guidance
- **Compliance**: Monitoring and validation requirements

**Usage**: Created during architectural planning and major technical decisions.

---

### milestone_meta_template.md

**Purpose**: Comprehensive milestone planning and tracking document.

**Key Features**:
- **Milestone scope** and objectives definition
- **Timeline planning** with dependencies
- **Resource allocation** and team planning
- **Success metrics** and measurement criteria
- **Risk management** and contingency planning
- **Quality standards** and acceptance criteria

**YAML Frontmatter**:
```yaml
milestone_id: "{MILESTONE_ID}"
milestone_name: "{MILESTONE_NAME}"
start_date: "{START_DATE}"
target_date: "{TARGET_DATE}"
status: "{STATUS}" # planning, active, testing, review, completed, cancelled
priority: "{PRIORITY}"
business_value: "{BUSINESS_VALUE}"
technical_complexity: "{TECHNICAL_COMPLEXITY}"
estimated_effort: {ESTIMATED_EFFORT} # person-weeks
team_size: {TEAM_SIZE}
completion_percentage: {COMPLETION_PERCENTAGE}
success_metrics:
  primary_metric: "{PRIMARY_METRIC}"
  target_values: ["{TARGET_VALUE_1}", "{TARGET_VALUE_2}"]
```

**Content Sections**:
- **Executive Summary**: Vision, objectives, value proposition
- **Scope Definition**: Included/excluded features, boundaries
- **Timeline & Dependencies**: Schedule, critical path, dependencies
- **Resource Planning**: Team allocation, skill requirements
- **Technical Architecture**: System changes, integration points
- **Quality Standards**: Testing, documentation, performance requirements
- **Risk Management**: Identified risks, mitigation strategies

**Usage**: Created during milestone planning and tracked throughout execution.

---

### technical_debt_template.md

**Purpose**: Comprehensive technical debt tracking and resolution planning.

**Key Features**:
- **Structured categorization** by type (code quality, architecture, security, performance, documentation, testing)
- **Severity assessment** with business and technical impact analysis
- **Risk evaluation** with likelihood and impact scoring
- **Resolution planning** with effort estimation and timeline
- **Integration hooks** with task management and sprint planning
- **Progress tracking** through debt lifecycle

**YAML Frontmatter**:
```yaml
debt_id: "TD_{DEBT_ID}"
title: "{DEBT_TITLE}"
category: "{CATEGORY}" # code_quality, architecture, security, performance, documentation, testing
severity: "{SEVERITY}" # critical, high, medium, low
created_date: "{CREATED_DATE}"
status: "{STATUS}" # active, planned, in_progress, resolved, wont_fix
estimated_effort: "{EFFORT_HOURS}"
business_impact: "{BUSINESS_IMPACT_DESCRIPTION}"
technical_impact: "{TECHNICAL_IMPACT_DESCRIPTION}"
affected_components: ["{COMPONENT_1}", "{COMPONENT_2}"]
related_debt: ["{RELATED_DEBT_ID}"]
blocking_tasks: ["{BLOCKED_TASK_ID}"]
risk_score: "{CALCULATED_RISK}" # 1-25 (likelihood × impact)
```

**Content Sections**:
- **Problem Description**: Detailed issue analysis with code examples
- **Impact Analysis**: Development velocity, maintenance cost, business impact
- **Risk Assessment**: Specific risks with probability and mitigation strategies
- **Resolution Planning**: Proposed solution with implementation phases
- **Alternative Solutions**: Other approaches considered with trade-offs
- **Dependencies and Blockers**: Prerequisites and blocking relationships
- **Monitoring and Validation**: Detection methods and success criteria

**Usage**: Created during code reviews, task execution, or dedicated debt assessment sessions. Integrated with task management for resolution planning.

---

### sprint_meta_template.md

**Purpose**: Sprint planning and execution tracking document.

**Key Features**:
- **Sprint goals** and objectives
- **Capacity planning** and team allocation
- **Task breakdown** and estimation
- **Daily standup** tracking
- **Sprint review** and retrospective
- **Velocity measurement** and improvement

**Content Sections**:
- **Sprint Overview**: Goals, duration, team capacity
- **Task Planning**: Backlog items, estimates, assignments
- **Daily Tracking**: Progress updates, blockers, adjustments
- **Quality Metrics**: Testing, review, deployment status
- **Sprint Review**: Completed work, demonstrations
- **Retrospective**: What worked, improvements, action items

**Usage**: Created at sprint start and updated throughout execution.

---

### bug_template.md

**Purpose**: Unified bug handling system covering the complete lifecycle from reporting through resolution.

**Key Features**:
- **Bug description** with reproduction steps
- **Environment information** and system context
- **Impact assessment** and severity classification
- **Root cause analysis** and investigation
- **Resolution tracking** and testing validation
- **Prevention measures** and follow-up actions

**Content Sections**:
- **Bug Summary**: Description, environment, severity
- **Reproduction**: Steps to reproduce, expected vs actual behavior
- **Investigation**: Root cause analysis, affected components
- **Resolution**: Fix description, testing validation
- **Prevention**: Measures to prevent recurrence

**Usage**: Created and managed by `do_bug` command throughout the bug lifecycle.

---

### pr_template.md

**Purpose**: Pull request documentation for code review and integration.

**Key Features**:
- **Change summary** with business justification
- **Technical details** and implementation approach
- **Testing validation** and quality checks
- **Review checklist** and acceptance criteria
- **Deployment considerations** and rollback plans
- **Documentation updates** and knowledge sharing

**Content Sections**:
- **Overview**: Summary, motivation, related issues
- **Changes**: Detailed description of modifications
- **Testing**: Test coverage, validation, quality checks
- **Review Guidance**: Focus areas, checklist, acceptance criteria
- **Deployment**: Considerations, rollback, monitoring

**Usage**: Created by `create_pr` command during code integration.

---

### architecture_template.md

**Purpose**: System architecture documentation and design specifications.

**Key Features**:
- **System overview** and architecture principles
- **Component design** with interfaces and dependencies
- **Data architecture** and flow diagrams
- **Security architecture** and threat modeling
- **Performance considerations** and scalability
- **Deployment architecture** and infrastructure

**Usage**: Created during system design and updated as architecture evolves.

---

### prd_template.md

**Purpose**: Product Requirements Document for feature specification.

**Key Features**:
- **Product vision** and business objectives
- **User stories** and acceptance criteria
- **Feature specification** with detailed requirements
- **User experience** design and workflows
- **Success metrics** and measurement criteria
- **Implementation roadmap** and dependencies

**Usage**: Created during product planning and feature definition.

---

## Template Usage Patterns

### Automated Template Usage

**Command Integration**:
- Commands automatically select appropriate templates
- Placeholder values are populated from project context
- Cross-references are generated automatically
- Metadata is inherited from parent documents

**Template Population Process**:
1. **Load template** from `.simone/99_TEMPLATES/`
2. **Extract context** from project manifest and related documents
3. **Populate placeholders** with actual values
4. **Generate cross-references** to related documents
5. **Validate completeness** of required fields
6. **Create document** in appropriate directory

### Manual Template Usage

**For New Document Types**:
1. Copy relevant template from `.simone/99_TEMPLATES/`
2. Place in appropriate directory (e.g., `.simone/04_GENERAL_TASKS/`)
3. Replace all placeholder values (`{PLACEHOLDER}`)
4. Update YAML frontmatter with actual metadata
5. Complete all required content sections
6. Update project manifest with new document reference

### Template Customization

**Project-Specific Adaptations**:
- Add custom fields to YAML frontmatter as needed
- Include project-specific sections
- Modify content structure for team preferences
- Add additional quality standards or checkpoints
- Integrate with external tools and systems

**Best Practices**:
- Maintain core structure and metadata requirements
- Document customizations in project documentation
- Ensure cross-reference compatibility is preserved
- Test template modifications with actual usage
- Keep customizations minimal and well-justified

## Metadata Standards

### YAML Frontmatter Requirements

**Universal Fields** (present in all templates):
```yaml
id: "{UNIQUE_IDENTIFIER}"
title: "{DOCUMENT_TITLE}"
type: "{DOCUMENT_TYPE}"
created_date: "{YYYY-MM-DD HH:MM}"
updated_date: "{YYYY-MM-DD HH:MM}"
status: "{CURRENT_STATUS}"
```

**Tracking Fields** (for work items):
```yaml
milestone_id: "{MILESTONE_ID}"
sprint_id: "{SPRINT_ID}"
priority: "{PRIORITY_LEVEL}"
complexity: "{COMPLEXITY_LEVEL}"
estimated_effort: "{EFFORT_ESTIMATE}"
assignee: "{ASSIGNED_PERSON}"
```

**Quality Fields** (for assessments):
```yaml
business_value: "{VALUE_LEVEL}"
technical_value: "{VALUE_LEVEL}"
risk_level: "{RISK_LEVEL}"
dependencies: ["{DEPENDENCY_LIST}"]
tags: ["{TAG_LIST}"]
```

### Status Taxonomies

**Universal Status Values**:
- `draft` → `review` → `approved` → `active` → `completed` → `archived`
- `blocked` (transitional state from any status)
- `deprecated` (for superseded documents)

**Priority Levels**: `low` | `medium` | `high` | `critical`
**Complexity Levels**: `simple` | `medium` | `complex` | `very_complex`
**Risk Levels**: `low` | `medium` | `high` | `critical`
**Value Levels**: `low` | `medium` | `high` | `critical`

## Cross-Reference System

### Link Patterns

**Internal Document References**:
```markdown
[Document Title](../folder/document.md)
[Section Name](document.md#section-anchor)
```

**Auto-Linkable Identifiers**:
- `TASK_##` - Links to task files
- `ADR_###` - Links to architectural decisions
- `S##_M##` - Links to sprint documents
- `M##` - Links to milestone documents
- `BUG###` - Links to bug reports

**Dependency Declarations**:
```yaml
dependencies: ["TASK_001", "ADR_005", "M02"]
blocked_by: ["TASK_003", "ADR_002"]
related_docs: ["../01_PROJECT_DOCS/ARCHITECTURE.md"]
```

### Cross-Reference Validation

**Automated Checks**:
- Verify all referenced documents exist
- Validate dependency relationships are not circular
- Check that linked sections exist in target documents
- Ensure milestone/sprint references are valid
- Confirm tag consistency across related documents

**Manual Validation**:
- Review logical consistency of relationships
- Verify business logic dependencies make sense
- Check that technical dependencies are accurate
- Ensure timeline dependencies are realistic

## Template Lifecycle Management

### Version Control

**Template Updates**:
- Templates are versioned with the framework
- Breaking changes require migration guidance
- Backward compatibility is maintained when possible
- Update notifications are provided to users

**Project-Specific Versions**:
- Projects can maintain custom template versions
- Custom templates should extend, not replace core templates
- Document customizations for team onboarding
- Periodically sync with framework updates

### Quality Assurance

**Template Validation**:
- All placeholder values must be replaceable
- YAML frontmatter must be valid and complete
- Content sections must be logically structured
- Cross-references must follow standard patterns
- Examples and guidance must be accurate

**Usage Monitoring**:
- Track which templates are used most frequently
- Identify common customization patterns
- Monitor completion rates for different sections
- Gather feedback on template effectiveness

## Integration with Commands

### Command-Template Mapping

| Command | Primary Template | Secondary Templates |
|---------|------------------|-------------------|
| `initialize` | `project_manifest_template.md` | `architecture_template.md` |
| `create_general_task` | `task_template.md` | - |
| `create_sprint_tasks` | `task_template.md` | `sprint_meta_template.md` |
| `do_bug` | `bug_template.md` | `task_template.md` |
| `create_sprints_from_milestone` | `sprint_meta_template.md` | `milestone_meta_template.md` |
| `create_pr` | `pr_template.md` | - |
| `commit` | `commit_template.md` | - |
| `project_review` | `project_review_template.md` | - |
| `log_technical_debt` | `technical_debt_template.md` | - |
| `do_task` | `task_template.md` | `technical_debt_template.md` (for debt logging) |

### Template Enhancement Features

**Context-Aware Population**:
- Commands analyze project state to populate relevant fields
- Related document information is automatically included
- Team and capacity information is inherited from project manifest
- Technical context is extracted from architecture documents

**Smart Defaults**:
- Priority levels are suggested based on milestone importance
- Complexity estimates use historical task data
- Risk assessments consider project and technical factors
- Effort estimates reference similar completed tasks

## Best Practices

### Template Usage

1. **Always use templates** - Don't create documents from scratch
2. **Complete all sections** - Even if briefly, address every template section
3. **Update metadata promptly** - Keep status and progress information current
4. **Maintain cross-references** - Link related documents and dependencies
5. **Follow naming conventions** - Use consistent, sortable file names

### Template Customization

1. **Extend, don't replace** - Add to templates rather than removing sections
2. **Document modifications** - Explain why customizations were needed
3. **Test thoroughly** - Ensure customized templates work with commands
4. **Share improvements** - Contribute useful enhancements back to framework
5. **Version control** - Track template changes with the project

### Quality Standards

1. **Complete all YAML fields** - Every metadata field should have a value
2. **Use consistent terminology** - Follow established status and priority values
3. **Validate cross-references** - Ensure all links and dependencies are correct
4. **Review before approval** - Have templates reviewed like code changes
5. **Keep current** - Update templates as project context changes

## Troubleshooting

### Common Issues

**Missing YAML Fields**:
- Compare document against template version
- Check for required fields that were skipped
- Validate YAML syntax and formatting
- Ensure all placeholder values are replaced

**Broken Cross-References**:
- Verify target documents exist at specified paths
- Check that referenced sections exist
- Validate dependency IDs are correct
- Update references after file renames or moves

**Inconsistent Metadata**:
- Compare related documents for consistency
- Check parent-child relationship alignment
- Verify status progression makes logical sense
- Ensure timestamps reflect actual work

### Validation Commands

```bash
# Check for incomplete templates
grep -r "{.*}" .simone/ --include="*.md"

# Validate YAML frontmatter
python -c "import yaml; yaml.safe_load(open('.simone/path/to/file.md').read().split('---')[1])"

# Check cross-references
grep -r "\[.*\](.*\.md)" .simone/ | grep -v "http"
```

## Advanced Features

### Template Automation

**Auto-Generation Opportunities**:
- Generate task templates from user stories
- Create ADR templates from architecture discussions
- Auto-populate sprint templates from milestone breakdown
- Generate bug templates from error logs or user reports

**Integration Possibilities**:
- Connect to issue tracking systems
- Sync with project management tools
- Import from requirements management systems
- Export to documentation platforms

### Analytics and Insights

**Template Usage Analytics**:
- Track completion rates by template type
- Identify frequently skipped sections
- Monitor time-to-completion for different document types
- Analyze correlation between completeness and project success

**Quality Metrics**:
- Measure cross-reference accuracy and completeness
- Track metadata consistency across related documents
- Monitor template adherence and customization patterns
- Assess documentation quality impact on project outcomes

---

The Simone template system provides a robust foundation for consistent, high-quality project documentation that integrates seamlessly with development workflows and enables effective project management and collaboration.