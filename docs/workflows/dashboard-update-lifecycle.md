# Dashboard Update Lifecycle

## Overview

The `dashboard.md` file serves as the central project status and metrics view. This document defines when and how the dashboard should be updated throughout the project lifecycle.

## Update Triggers

### 🔄 Automatic Updates (High Priority)

#### Sprint-Level Events
- **Sprint Start**: When `/project:simone:create_sprint_tasks` is executed
- **Sprint End**: When all sprint tasks are completed or sprint is closed
- **Sprint Velocity Changes**: After 3+ tasks completed in current sprint (recalculate velocity)

#### Task-Level Events  
- **Task Status Change**: When `/project:simone:update_task_status` is executed
- **Task Completion**: Immediately when task marked as `completed`
- **Task Blocking**: When task marked as `blocked` (update risk assessment)

#### Milestone Events
- **Milestone Creation**: When `/project:simone:create_milestone` is executed
- **Milestone Progress**: When milestone completion percentage changes by ≥10%
- **Milestone Completion**: Immediately when milestone marked as `completed`

### 📅 Scheduled Updates (Medium Priority)

#### Weekly Updates (Every Monday)
- **Health Indicators**: Documentation coverage, code quality, technical debt
- **Team Capacity**: Current load, available capacity, velocity trends
- **Risk Assessment**: Review and update current risks and mitigation status

#### Sprint Boundaries
- **Sprint Retrospective**: Update velocity, lessons learned, process improvements
- **Sprint Planning**: Update upcoming milestones, capacity planning

### 🔧 Manual Updates (As Needed)

#### Project Structure Changes
- **New team members**: Update team structure table
- **Architecture decisions**: Update technical debt and risk sections
- **External dependencies**: Update business metrics and risks

#### Quality Gate Events
- **Code reviews completed**: Update quality metrics
- **Security audits**: Update risk assessment
- **Performance testing**: Update quality indicators

## Update Commands

### Primary Update Command
```bash
/project:simone:update_dashboard
```

**Triggers:**
- Analyzes current project state from manifest, tasks, and sprints
- Calculates metrics and progress percentages
- Updates all dynamic sections with current data
- Sets next update date based on project velocity

### Integration with Existing Commands

#### Enhanced Commands (Auto-Update Dashboard)
These commands should automatically trigger dashboard updates:

```bash
# Task Management
/project:simone:update_task_status T01_S01 completed
/project:simone:do_task T01_S01

# Sprint Management  
/project:simone:create_sprint_tasks
/project:simone:close_sprint S01_M01

# Milestone Management
/project:simone:create_milestone "Feature description"
/project:simone:complete_milestone M01

# Project Health
/project:simone:project_review
/project:simone:quality_review
```

#### Command Enhancement Pattern
Each command should:
1. Execute its primary function
2. Check if dashboard update criteria are met
3. Call dashboard update if triggered
4. Log dashboard update in command output

## Dashboard Data Sources

### Real-Time Data (Always Current)
- **Project Manifest**: Current milestone, sprint, project status
- **Task Files**: Task counts, completion status, sprint progress
- **Git History**: Recent commits, PR status, branch activity

### Calculated Metrics (Updated on Trigger)
- **Sprint Velocity**: Rolling average of last 3 sprints
- **Progress Percentages**: Task completion ratios
- **Health Indicators**: Derived from task metadata and git activity

### Manual Data (Periodic Updates)
- **Team Structure**: Capacity, roles, availability
- **Risk Assessment**: Probability, impact, mitigation status
- **Business Metrics**: External metrics not tracked in Simone

## Update Frequency Guidelines

### Critical Updates (Immediate)
- Task completion that affects milestone progress
- Sprint completion or major blocking issues
- Risk level changes (low → medium → high)

### Standard Updates (Within 24 hours)
- Regular task status changes
- Weekly health indicator updates
- Team capacity changes

### Maintenance Updates (Weekly)
- Cleanup of completed items
- Trend analysis updates
- Historical data archival

## Implementation Strategy

### Phase 1: Manual Process
- Document update triggers in this file
- Train team on when to run `/project:simone:update_dashboard`
- Establish weekly review process

### Phase 2: Semi-Automated
- Enhance existing commands to trigger dashboard updates
- Add dashboard update notifications to command outputs
- Implement basic validation of dashboard data freshness

### Phase 3: Fully Automated
- Implement git hooks for automatic updates on commits
- Add CI/CD integration for deployment-triggered updates
- Create monitoring for dashboard staleness

## Dashboard Staleness Detection

### Warning Indicators
- **Yellow (Stale)**: Last updated >3 days ago with active development
- **Red (Critical)**: Last updated >7 days ago or major events missed

### Validation Checks
```bash
# Check dashboard freshness
grep "Last Updated" .simone/dashboard.md

# Validate against recent activity
git log --since="$(grep 'Last Updated' .simone/dashboard.md | cut -d' ' -f3-)" --oneline

# Check for missing sprint/milestone updates
diff <(grep -r "status: completed" .simone/03_SPRINTS/) <(grep "✅" .simone/dashboard.md)
```

## Quality Standards

### Dashboard Content Requirements
- **Accuracy**: All metrics reflect current project state
- **Completeness**: No {PLACEHOLDER} values in published dashboard
- **Consistency**: Status values match source documents
- **Timeliness**: Updated within 24 hours of major events

### Review Process
1. **Automated Validation**: Check for placeholders and date consistency
2. **Peer Review**: Team member verifies metrics accuracy
3. **Stakeholder Review**: Project lead approves before external sharing

## Integration with MCP Servers

### Work History Server
- Track dashboard update patterns
- Identify optimal update frequencies
- Suggest improvements based on usage

### Context7 Server
- Maintain dashboard context across sessions
- Preserve custom configurations
- Enable personalized dashboard views

## Troubleshooting

### Common Issues
- **Outdated metrics**: Re-run data collection from source files
- **Missing placeholders**: Check template application
- **Inconsistent status**: Validate against task file metadata

### Recovery Procedures
- **Data corruption**: Regenerate from template with current data
- **Missing updates**: Backfill from git history and task logs
- **Template drift**: Merge template updates with customizations

---

## Quick Reference

### Update Command
```bash
/project:simone:update_dashboard
```

### Check Staleness
```bash
grep "Last Updated" .simone/dashboard.md
```

### Force Refresh
```bash
/project:simone:update_dashboard --force
```

### Validate Data
```bash
/project:simone:validate_dashboard
```

---

*Dashboard Update Lifecycle v1.0 | Simone Framework | Comprehensive project tracking*