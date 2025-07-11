# 📊 {PROJECT_NAME} Dashboard

---
**Last Updated**: {LAST_UPDATED_DATE}  
**Project**: {PROJECT_NAME}  
**Status**: {PROJECT_STATUS}  
**Current Sprint**: {CURRENT_SPRINT}  

---

## 🎯 Project Overview

### Key Metrics
- **Overall Progress**: {OVERALL_PROGRESS}% Complete
- **Active Milestones**: {ACTIVE_MILESTONES}
- **Sprint Velocity**: ~{VELOCITY} tasks/week
- **Team Size**: {TEAM_SIZE}
- **Time Tracking**: {PROJECT_DURATION}

### Health Indicators
| Metric | Status | Trend |
|--------|--------|-------|
| Documentation Coverage | {DOC_COVERAGE_STATUS} {DOC_COVERAGE}% | {DOC_TREND} |
| Code Quality | {QUALITY_STATUS} {QUALITY_LEVEL} | {QUALITY_TREND} |
| Technical Debt | {DEBT_STATUS} {DEBT_LEVEL} | {DEBT_TREND} |
| User Feedback | {FEEDBACK_STATUS} {FEEDBACK_LEVEL} | {FEEDBACK_TREND} |

---

## 🏗️ Current Milestones

### {MILESTONE_ID}: {MILESTONE_NAME} {MILESTONE_STATUS_ICON}
**Status**: {MILESTONE_STATUS}  
**Duration**: {MILESTONE_START} - {MILESTONE_END}  
**Progress**: {MILESTONE_PROGRESS}%

**Key Deliverables**:
{MILESTONE_DELIVERABLES}

{ADDITIONAL_MILESTONES}

---

## 🏃‍♂️ Sprint Overview

### Sprint History
| Sprint | Period | Focus | Completed | Velocity |
|--------|--------|-------|-----------|----------|
{SPRINT_HISTORY_TABLE}

### Current Sprint ({CURRENT_SPRINT_ID}): {CURRENT_SPRINT_NAME}
**Duration**: {CURRENT_SPRINT_DURATION}  
**Capacity**: {CURRENT_SPRINT_CAPACITY} tasks  
**Progress**: {CURRENT_SPRINT_PROGRESS}% ({CURRENT_SPRINT_COMPLETED}/{CURRENT_SPRINT_TOTAL} completed)

#### Active Tasks
{CURRENT_SPRINT_TASKS}

---

## 📈 Progress Tracking

### Gantt Chart Representation

```
{GANTT_CHART_VISUALIZATION}
```

**Legend**: █ Active Development │ ─ Testing/QA │ ░ Planning

### Milestone Timeline
```
{MILESTONE_TIMELINE_VISUALIZATION}
```

---

## 🐛 Issues & Technical Debt

### High Priority Issues
| ID | Priority | Status | Description | Assigned | ETA |
|----|----------|--------|-------------|----------|-----|
{HIGH_PRIORITY_ISSUES_TABLE}

### Technical Debt Summary
{TECHNICAL_DEBT_SUMMARY}

### Debt Trend
```
{DEBT_TREND_VISUALIZATION}
```

---

## 📋 Task Management

### Task Distribution by Type
```
{TASK_TYPE_DISTRIBUTION}
```

### Completion Status
- **Total Tasks**: {TOTAL_TASKS}
- **Completed**: {COMPLETED_TASKS} ({COMPLETED_PERCENTAGE}%)
- **In Progress**: {IN_PROGRESS_TASKS} ({IN_PROGRESS_PERCENTAGE}%)
- **Pending**: {PENDING_TASKS} ({PENDING_PERCENTAGE}%)

### Recent Completions (Last 7 days)
{RECENT_COMPLETIONS}

---

## 👥 Team & Capacity

### Current Team Structure
| Role | Member | Capacity | Current Load | Available |
|------|--------|----------|--------------|-----------|
{TEAM_STRUCTURE_TABLE}

### Velocity Tracking
```
{VELOCITY_CHART}
```

---

## 🎯 Key Performance Indicators

### Quality Metrics
| Metric | Target | Current | Status |
|--------|--------|---------|--------|
{QUALITY_METRICS_TABLE}

### Business Metrics
{BUSINESS_METRICS}

---

## 🚨 Risk Assessment

### Current Risks
| Risk | Probability | Impact | Mitigation | Owner | Status |
|------|-------------|--------|------------|-------|--------|
{RISKS_TABLE}

### Risk Trend
```
{RISK_TREND_VISUALIZATION}
```

---

## 📅 Upcoming Milestones

### Next 30 Days
{NEXT_30_DAYS}

### Next Quarter ({NEXT_QUARTER})
{NEXT_QUARTER_ITEMS}

### Long-term Vision ({LONG_TERM_PERIOD})
{LONG_TERM_VISION}

---

## 🔗 Quick Links

### Documentation
- [📖 Main README](../README.md)
- [📋 Backlog](../BACKLOG.md)
- [📝 Changelog](../CHANGELOG.md)
- [🚀 Getting Started](../docs/getting-started/quick-start.md)

### Development
- [⚙️ Commands Reference](../.claude/commands/simone/)
- [📄 Templates](./99_TEMPLATES/)
- [🧪 Examples](../examples/)
- [🔧 Scripts](../scripts/)

### Project Management
- [📊 Project Manifest](./00_PROJECT_MANIFEST.md)
- [📋 Current Tasks](./03_SPRINTS/)
- [📝 ADRs](./05_ARCHITECTURAL_DECISIONS/)
- [📈 Reviews](./10_STATE_OF_PROJECT/)

---

## 📊 Dashboard Actions

### Quick Commands
```bash
# Update task status
/project:simone:update_task_status <TASK_ID> <STATUS>

# Create new sprint
/project:simone:create_sprints_from_milestone

# Generate milestone
/project:simone:create_milestone "<description>"

# Project review
/project:simone:project_review

# Quality check
/project:simone:quality_review

# Update dashboard
/project:simone:update_dashboard
```

### Dashboard Maintenance
- **Update Frequency**: {UPDATE_FREQUENCY}
- **Data Sources**: YAML frontmatter, git history, task files
- **Automation**: {AUTOMATION_LEVEL}
- **Manual Updates**: {MANUAL_UPDATE_ITEMS}

---

*Dashboard automatically updated from project data. For real-time updates, see individual task files and project manifest.*

**Next Update**: {NEXT_UPDATE_DATE}