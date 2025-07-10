# Bug Reporting Guide

## Overview

The Simone framework now includes comprehensive bug reporting and tracking functionality designed to integrate seamlessly with the existing task management system. This guide covers how to report, track, and resolve bugs using the new bug management commands.

## Bug Reporting Workflow

### 1. Creating Bug Reports

Use the `/project:simone:create_bug` command to create comprehensive bug reports:

```bash
/project:simone:create_bug "Login form validation fails for special characters"
```

This command will:
- Create a detailed bug report in `.simone/06_BUGS/`
- Automatically generate a sequential bug ID (BUG001, BUG002, etc.)
- Use the comprehensive bug template with all required metadata
- Generate associated fix tasks automatically
- Update the project manifest with bug tracking

### 2. Bug Report Structure

Each bug report includes:

**Metadata (YAML frontmatter):**
- Bug ID, title, severity, priority
- Status tracking and assignment
- Component and environment information
- Effort estimation and tracking
- Related bugs and dependencies

**Comprehensive Sections:**
- **Bug Summary**: Description, expected vs actual behavior, impact assessment
- **Reproduction Details**: Step-by-step reproduction, prerequisites, test data
- **Environment Information**: System details, configuration, affected components
- **Evidence & Documentation**: Screenshots, error messages, logs, console output
- **Analysis & Investigation**: Root cause analysis, affected code areas, architecture impact
- **Fix Strategy**: Proposed solutions, alternatives, risk assessment
- **Implementation Plan**: Fix tasks, testing requirements, verification criteria
- **Progress Tracking**: Status log, work notes, blockers
- **Quality Checklist**: Comprehensive validation requirements

### 3. Bug Severity and Priority Guidelines

**Severity Levels:**
- **Critical**: System crashes, data loss, security vulnerabilities
- **High**: Major functionality broken, significant user impact
- **Medium**: Minor functionality issues, workarounds available
- **Low**: Cosmetic issues, nice-to-have improvements

**Priority Levels:**
- **Critical**: Must fix immediately
- **High**: Fix in current sprint
- **Medium**: Fix in next sprint
- **Low**: Fix when resources allow

## Bug Resolution Workflow

### 1. Starting Bug Fixes

Use the `/project:simone:fix_bug` command to begin fixing a bug:

```bash
/project:simone:fix_bug BUG001
```

This command will:
- Analyze the bug report and current status
- Create or locate associated fix tasks
- Set appropriate status tracking
- Execute comprehensive bug fix implementation
- Perform bug-specific testing and verification
- Update all related documentation and tracking

### 2. Bug Status Progression

**Status Flow:**
1. **open** → Bug reported and analyzed
2. **in_progress** → Fix implementation started
3. **testing** → Fix completed, verification in progress
4. **closed** → Bug verified fixed and resolved
5. **wont_fix** → Bug marked as won't fix (with justification)

### 3. Automatic Task Integration

The bug system automatically:
- Creates fix tasks when bugs are reported
- Links tasks to bugs with cross-references
- Synchronizes status between bugs and tasks
- Tracks effort and progress across both systems
- Updates project manifest and metrics

## Directory Structure

```
.simone/
├── 06_BUGS/                    # Bug reports directory
│   ├── BUG001_Login_Issue.md   # Individual bug reports
│   ├── BUG002_UI_Problem.md
│   └── ...
├── 99_TEMPLATES/
│   └── bug_template.md         # Comprehensive bug template
└── .claude/commands/simone/
    ├── create_bug.md           # Bug creation command
    └── fix_bug.md             # Bug fixing command
```

## Integration with Existing Systems

### Task Management
- Bugs automatically create associated fix tasks
- Tasks follow existing naming conventions (T### for general, sprint sequence for sprints)
- Status synchronization between bugs and tasks
- Effort tracking across both systems

### Project Manifest
- New "Open Bugs" section tracks all active bugs
- Links to bug reports with status and priority
- Bug statistics and metrics tracking
- Integration with project health monitoring

### Sprint Planning
- Critical/High priority bugs automatically added to current sprint
- Medium priority bugs added based on capacity
- Low priority bugs go to general tasks unless explicitly prioritized
- Bug fix tasks follow existing sprint conventions

## Quality Assurance

### Bug Report Quality
- Comprehensive template ensures all necessary information
- Technical analysis based on actual codebase research
- Clear reproduction steps and verification criteria
- Risk assessment and impact analysis

### Fix Quality
- Root cause analysis required, not just symptom treatment
- Comprehensive testing including regression testing
- Code quality standards maintained
- Documentation updates included

### Process Quality
- Automatic cross-referencing and status synchronization
- Metrics tracking for continuous improvement
- Lessons learned capture for pattern identification
- Integration with existing quality checkpoints

## Best Practices

### Reporting Bugs
1. **Be Specific**: Use clear, descriptive titles
2. **Include Context**: Provide environment and configuration details
3. **Document Evidence**: Include error messages, logs, screenshots
4. **Assess Impact**: Evaluate user and business impact
5. **Suggest Solutions**: Propose potential fixes if known

### Fixing Bugs
1. **Understand Root Cause**: Don't just treat symptoms
2. **Consider Alternatives**: Evaluate multiple solution approaches
3. **Test Thoroughly**: Include regression and edge case testing
4. **Document Changes**: Update relevant documentation
5. **Learn and Improve**: Capture lessons for prevention

### Managing Bug Lifecycle
1. **Triage Promptly**: Assess and prioritize new bugs quickly
2. **Communicate Status**: Keep stakeholders informed of progress
3. **Track Metrics**: Monitor resolution time and quality
4. **Review Patterns**: Identify recurring issues for prevention
5. **Close Completely**: Ensure proper verification and documentation

## Commands Reference

### `/project:simone:create_bug <title>`
Creates a comprehensive bug report with automatic task generation.

**Features:**
- Sequential bug ID generation
- Comprehensive template population
- Automatic fix task creation
- Project manifest updates
- Cross-reference management

### `/project:simone:fix_bug <bug_id>`
Executes complete bug fix workflow with specialized tracking.

**Features:**
- Bug analysis and status management
- Task creation and execution
- Comprehensive testing and verification
- Documentation updates
- Resolution reporting

## Metrics and Reporting

The bug system tracks:
- **Resolution Time**: Time from report to closure
- **Effort Accuracy**: Estimated vs actual effort
- **Quality Metrics**: Regression rate, re-open rate
- **Pattern Analysis**: Common root causes, affected components
- **Process Efficiency**: Workflow bottlenecks and improvements

This data integrates with project health monitoring and review processes for continuous improvement.