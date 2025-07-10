# CLAUDE.md - Bug Reports Directory Structure Guide

## Overview
This directory contains all bug reports for the project, providing comprehensive tracking, analysis, and resolution workflows. Each bug is treated as a first-class entity with specialized handling and integration with the task management system.

## Bug Report Naming Convention
**CRITICAL**: Bug report files MUST follow this exact pattern:
```
BUG###_<Bug_Title_Snake_Case>.md
```

- `BUG###` - Sequential bug number with leading zeros (BUG001, BUG002, etc.)
- `_` - Single underscore separator
- `<Bug_Title_Snake_Case>` - Descriptive title using underscores for spaces

### Examples:
- ✅ `bug001-login-form-validation-error.md`
- ✅ `bug002-dashboard-loading-performance.md`
- ✅ `bug003-api-response-timeout.md`
- ❌ `bug1-login-error.md` (missing leading zeros)
- ❌ `BUG001-Login-Error.md` (wrong separator)
- ❌ `Login_Error.md` (missing BUG### prefix)

## Bug Report Structure
Each bug report MUST contain:

### 1. YAML Frontmatter (REQUIRED)
All bug metadata for tracking and automation:
```yaml
---
bug_id: "BUG###"
bug_title: "Clear, specific bug description"
bug_type: "bug"                                    # Always "bug"
severity: "critical|high|medium|low"
priority: "critical|high|medium|low"
status: "open|in_progress|testing|closed|wont_fix"
created_date: "YYYY-MM-DD"
updated_date: "YYYY-MM-DD"
reporter: "Reporter Name"
assignee: "TBD|Claude|Developer Name"
milestone_id: "M##|N/A"
sprint_id: "S##|N/A"
component: "frontend|backend|database|api|infrastructure"
environment: "production|staging|development|local"
browser: "Browser name|N/A"
os: "Operating system|N/A"
version: "Product version"
tags: ["tag1", "tag2", "tag3"]
duplicate_of: "BUG###|N/A"
related_bugs: ["BUG###", "BUG###"]
estimated_effort: "hours|TBD"
actual_effort: "hours|0"
---
```

### 2. Comprehensive Content Sections
Following the bug template structure:

#### Core Information
- **Bug Summary**: Description, expected vs actual behavior, impact assessment
- **Reproduction Details**: Step-by-step reproduction, prerequisites, test data
- **Environment Information**: System details, configuration, affected components

#### Analysis & Investigation
- **Evidence & Documentation**: Screenshots, error messages, logs, console output
- **Analysis & Investigation**: Root cause analysis, affected code areas, architecture impact
- **Fix Strategy**: Proposed solutions, alternatives, risk assessment

#### Implementation & Resolution
- **Implementation Plan**: Fix tasks, testing requirements, verification criteria
- **Progress Tracking**: Status log, work notes, blockers
- **Resolution**: Final solution, code changes, testing results

#### Quality & Relationships
- **Quality Checklist**: Comprehensive validation requirements
- **Relationships**: Related bugs, features, dependencies

## Severity and Priority Guidelines

### Severity Levels
- **Critical**: System crashes, data loss, security vulnerabilities, complete feature failure
- **High**: Major functionality broken, significant user impact, workarounds difficult
- **Medium**: Minor functionality issues, workarounds available, limited user impact
- **Low**: Cosmetic issues, nice-to-have improvements, minimal impact

### Priority Assessment
- **Critical**: Must fix immediately, blocks all work
- **High**: Fix in current sprint, significant business impact
- **Medium**: Fix in next sprint, moderate business impact
- **Low**: Fix when resources allow, minimal business impact

## Status Workflow

### Status Progression
```
open → in_progress → testing → closed
  ↓         ↓           ↓
wont_fix  blocked    (reopened)
```

### Status Definitions
- **open**: Bug reported, analyzed, ready for assignment
- **in_progress**: Developer actively working on fix
- **testing**: Fix implemented, verification in progress
- **closed**: Bug verified fixed and resolved
- **wont_fix**: Bug marked as won't fix with justification
- **blocked**: Fix work halted due to dependencies

## Integration with Task Management

### Automatic Task Creation
When bugs are created, the system automatically:
- **Critical/High Severity**: Creates task in current sprint
- **Medium Severity**: Creates task in current sprint if capacity allows, otherwise general tasks
- **Low Severity**: Creates task in general tasks unless explicitly prioritized

### Task Naming Convention
Bug fix tasks follow pattern:
```
Fix BUG###: <Bug_Title>
```

### Cross-Reference Management
- Bug reports link to associated fix tasks
- Tasks reference originating bug reports
- Status synchronization between bugs and tasks
- Effort tracking consolidated across both systems

## Commands That Work With Bugs

### create_bug.md
**Usage**: `/project:simone:create_bug "Bug description"`
**Purpose**: Creates comprehensive bug report with automatic task generation
**Output**: 
- New bug report in 06_BUGS/
- Associated fix task in appropriate location
- Updated project manifest

### fix_bug.md
**Usage**: `/project:simone:fix_bug BUG###`
**Purpose**: Executes specialized bug fix workflow
**Process**:
1. Analyzes bug report and current status
2. Creates or locates associated fix task
3. Implements comprehensive bug fix
4. Performs specialized testing and verification
5. Updates all tracking and documentation

### update_task_status.md
**Integration**: Automatically updates bug status when associated task status changes
**Synchronization**: Maintains consistency between bug and task tracking

## Quality Standards

### Bug Report Quality
- **Completeness**: All template sections properly filled
- **Accuracy**: Information verified and current
- **Clarity**: Clear reproduction steps and descriptions
- **Evidence**: Supporting documentation included

### Fix Quality
- **Root Cause**: Addresses underlying cause, not just symptoms
- **Testing**: Comprehensive verification including regression testing
- **Documentation**: All relevant documentation updated
- **Integration**: Proper integration with existing systems

### Process Quality
- **Traceability**: Clear links between bugs, tasks, and resolutions
- **Metrics**: Tracking for continuous improvement
- **Communication**: Stakeholder updates and team coordination
- **Learning**: Lessons captured for future prevention

## Project Manifest Integration

### Bug Tracking Section
The project manifest (`00_PROJECT_MANIFEST.md`) includes:
```markdown
## 4. Open Bugs

- [ ] bug001: [Bug Title](06_BUGS/bug001-bug-title.md) - Status: Open (Priority: high)
- [ ] bug002: [Bug Title](06_BUGS/bug002-bug-title.md) - Status: in_progress (Priority: medium)
```

### Bug Statistics
- Total bug count
- Open vs closed bugs
- Severity distribution
- Resolution time metrics

## MCP Server Integration

### Sequential Thinking
- Structures bug analysis and fix implementation systematically
- Ensures comprehensive problem-solving approach
- Maintains logical flow in complex bug investigations

### Work History
- Tracks all bug-related activities and decisions
- Maintains history of similar bugs and their resolutions
- Provides context for pattern recognition and improvement

### Context7
- Preserves context about bug investigations and fixes
- Maintains relationships between bugs and code changes
- Supports complex multi-session bug resolution

### Serena
- Enhances code analysis for root cause identification
- Provides advanced debugging and fix suggestions
- Improves integration with existing codebase

## Best Practices

### Bug Reporting
1. **Be Specific**: Use clear, descriptive titles and descriptions
2. **Include Context**: Provide complete environment and configuration details
3. **Document Evidence**: Include error messages, logs, screenshots, console output
4. **Assess Impact**: Evaluate user, business, and technical impact thoroughly
5. **Suggest Solutions**: Propose potential fixes if you have insights

### Bug Investigation
1. **Reproduce First**: Always reproduce the bug before attempting fixes
2. **Understand Root Cause**: Don't just treat symptoms
3. **Consider Side Effects**: Evaluate impact on related functionality
4. **Document Analysis**: Record investigation findings and decisions
5. **Plan Testing**: Define comprehensive verification approach

### Bug Resolution
1. **Test Thoroughly**: Include original reproduction plus regression testing
2. **Update Documentation**: Ensure all relevant docs reflect changes
3. **Communicate Progress**: Keep stakeholders informed throughout process
4. **Learn and Improve**: Capture lessons for prevention and process improvement
5. **Verify Completely**: Ensure fix addresses all aspects of the bug

## Common Mistakes to Avoid

### Bug Creation
- Creating bugs without the BUG### prefix
- Using hyphens instead of underscores in filenames
- Incomplete reproduction steps or environment information
- Not assessing severity and priority appropriately
- Forgetting to update the project manifest

### Bug Resolution
- Treating symptoms instead of root causes
- Insufficient testing, especially regression testing
- Not updating related documentation
- Poor communication with stakeholders
- Not capturing lessons learned for future prevention

### Process Management
- Not linking bugs to fix tasks properly
- Inconsistent status updates between bugs and tasks
- Not tracking effort and metrics for improvement
- Forgetting to close bugs after verification
- Not reviewing bug patterns for systemic improvements

---

**Note**: This directory integrates seamlessly with the Simone framework's task management, sprint planning, and project health monitoring systems. All bug-related commands follow established Simone conventions while providing specialized handling for bug-specific workflows.