# Update Dashboard - Automated Dashboard Update and Metrics Calculation

Updates the project dashboard with current metrics, progress tracking, and comprehensive project status from all data sources.

## Create a TODO with EXACTLY these 7 Items

1. Parse update arguments and validate data sources
2. Collect real-time data from project manifest and task files
3. Calculate metrics and progress percentages
4. Generate dynamic visualizations and charts
5. Update dashboard template with current data
6. Validate dashboard completeness and accuracy
7. Set next update schedule and automation triggers

## DETAILS on every TODO item

### 1. Parse update arguments and validate data sources

**Arguments Format:** `[options] [scope] [validation_level]`

**Examples:**
- `/project:simone:update_dashboard` (full update with validation)
- `/project:simone:update_dashboard --force` (skip staleness checks)
- `/project:simone:update_dashboard metrics` (metrics-only update)
- `/project:simone:update_dashboard --dry-run` (preview changes only)

**Update Options:**
- **--force**: Skip staleness validation and force complete refresh
- **--dry-run**: Preview changes without writing to dashboard file
- **--metrics-only**: Update only calculated metrics, skip structural changes
- **--silent**: Suppress detailed output, show only summary

**Scope Options:**
- **full**: Complete dashboard refresh (default)
- **metrics**: Update metrics and calculations only
- **structure**: Update template structure and sections
- **content**: Update dynamic content and data only

**Validation Requirements:**
- Verify `.simone/00_PROJECT_MANIFEST.md` exists and is readable
- Confirm template file exists at `.simone/99_TEMPLATES/dashboard_template.md`
- Check write permissions for `.simone/DASHBOARD.md` or `.simone/dashboard.md`
- Validate git repository status for commit history analysis

### 2. Collect real-time data from project manifest and task files

**MCP INTEGRATION:** Use MCP servers for enhanced data collection:
- **Sequential Thinking**: Structure data collection systematically
- **GitHub**: Track historical patterns and trends
- **Context7**: Maintain context about project evolution
- **Serena**: Enhance data analysis and validation

**Primary Data Sources:**

**Project Manifest (`00_PROJECT_MANIFEST.md`):**
```yaml
# Extract YAML frontmatter for:
project_name: "Project Name"
current_milestone_id: "M02"
current_sprint_id: "S07_M02"
project_status: "active"
created_date: "2025-01-01"
```

**Task Files Analysis:**
```bash
# Task status aggregation
find .simone/03_SPRINTS -name "*.md" -exec grep -l "status:" {} \;
find .simone/04_GENERAL_TASKS -name "*.md" -exec grep -l "status:" {} \;

# Count by status
grep -r "status: completed" .simone/03_SPRINTS/ | wc -l
grep -r "status: in_progress" .simone/03_SPRINTS/ | wc -l
grep -r "status: pending" .simone/03_SPRINTS/ | wc -l
```

**Sprint Data Collection:**
- Current sprint progress from `03_SPRINTS/S##_M##_*/`
- Sprint metadata from `S##_M##_sprint_meta.md` files
- Task completion rates and velocity calculations
- Sprint history for trend analysis

**Git History Analysis:**
```bash
# Recent activity (last 30 days)
git log --since="30 days ago" --oneline --all

# Commit frequency and patterns
git log --since="30 days ago" --pretty=format:"%ad" --date=short | sort | uniq -c

# Branch activity
git branch -a --format="%(refname:short) %(committerdate:relative)"
```

### 3. Calculate metrics and progress percentages

**Core Metrics Calculations:**

**Overall Progress:**
```
overall_progress = (completed_tasks / total_tasks) * 100
milestone_progress = (completed_milestone_tasks / total_milestone_tasks) * 100
sprint_progress = (completed_sprint_tasks / total_sprint_tasks) * 100
```

**Velocity Tracking:**
```
# Calculate rolling 3-sprint average
recent_sprints = last_3_completed_sprints()
sprint_velocity = sum(tasks_completed_per_sprint) / number_of_sprints
weekly_velocity = sprint_velocity * (sprint_length_days / 7)
```

**Health Indicators:**

**Documentation Coverage:**
```bash
# Count documented vs undocumented components
doc_files = find . -name "*.md" | wc -l
code_files = find . -name "*.py" -o -name "*.js" -o -name "*.ts" | wc -l
doc_coverage = (documented_components / total_components) * 100
```

**Technical Debt Level:**
```bash
# Analyze technical debt files
debt_files = find .simone/07_TECHNICAL_DEBT -name "*.md" | wc -l
debt_severity = grep -r "severity: high" .simone/07_TECHNICAL_DEBT/ | wc -l
```

**Quality Metrics:**
- Bug count and severity distribution
- Code review completion rates
- Test coverage (if available from CI/CD)
- Performance indicators

### 4. Generate dynamic visualizations and charts

**ASCII Chart Generation:**

**Gantt Chart Creation:**
```
Timeline Visualization:
M01: ████████████████████ (100%) Jan 1-15
M02: ████████████░░░░░░░░ (65%)  Jan 16-31
M03: ░░░░░░░░░░░░░░░░░░░░ (0%)   Feb 1-15
```

**Sprint Velocity Chart:**
```
Sprint Velocity Trend:
S05: ████████ (8 tasks)
S06: ██████ (6 tasks)  
S07: ████████████ (12 tasks)
Avg: ████████░ (8.7 tasks/sprint)
```

**Progress Tracking Charts:**
```
Task Distribution:
Completed    ████████████████████ 67% (97/145)
In Progress  ████░░░░░░░░░░░░░░░░ 20% (29/145)
Pending      ██░░░░░░░░░░░░░░░░░░ 13% (19/145)
```

**Risk and Debt Visualizations:**
```
Technical Debt Trend:
Week 1: ████████████████ High
Week 2: ████████████░░░░ Medium
Week 3: ████████░░░░░░░░ Low
Week 4: ████████░░░░░░░░ Low
```

### 5. Update dashboard template with current data

**Template Variable Replacement:**

**Core Project Variables:**
```yaml
{PROJECT_NAME} → "Simone Framework"
{PROJECT_STATUS} → "Active Development"
{CURRENT_SPRINT} → "S07_M02: Enhancement Sprint"
{LAST_UPDATED_DATE} → "2025-01-11 14:30:00"
{OVERALL_PROGRESS} → "67"
```

**Metrics Variables:**
```yaml
{VELOCITY} → "8.7"
{TEAM_SIZE} → "3"
{ACTIVE_MILESTONES} → "2"
{DOC_COVERAGE} → "85"
{QUALITY_LEVEL} → "Good"
{DEBT_LEVEL} → "Low"
```

**Dynamic Content Generation:**

**Sprint History Table:**
```markdown
| Sprint | Period | Focus | Completed | Velocity |
|--------|--------|-------|-----------|----------|
| S05_M01 | Dec 1-15 | Core Setup | 8/10 | 8.0 |
| S06_M02 | Dec 16-31 | Documentation | 6/8 | 6.0 |
| S07_M02 | Jan 1-15 | Enhancement | 8/12 | 12.0 |
```

**Current Sprint Tasks:**
```markdown
#### Active Tasks
- **T07_01**: ✅ Update dashboard system (Completed)
- **T07_02**: 🔄 Enhance command validation (In Progress)
- **T07_03**: ⏳ Add automation triggers (Pending)
```

**Milestone Timeline:**
```
Milestone Progress:
M01: ████████████████████ (100%) ✅ Completed
M02: ████████████░░░░░░░░ (65%)  🔄 In Progress  
M03: ░░░░░░░░░░░░░░░░░░░░ (0%)   ⏳ Planning
```

### 6. Validate dashboard completeness and accuracy

**Validation Checklist:**

**Data Completeness:**
- [ ] All `{PLACEHOLDER}` variables replaced with actual values
- [ ] No template variables remaining in final output
- [ ] All calculated percentages are realistic (0-100%)
- [ ] Dates are current and properly formatted

**Content Accuracy:**
- [ ] Task counts match actual task file counts
- [ ] Sprint progress reflects current task statuses
- [ ] Milestone progress aligns with component completion
- [ ] Team structure reflects current project participants

**Structural Integrity:**
- [ ] All markdown syntax is valid
- [ ] Tables are properly formatted with consistent columns
- [ ] ASCII charts render correctly in monospace
- [ ] Links to other project files are functional

**Cross-Reference Validation:**
```bash
# Verify task ID references exist
grep -r "T[0-9][0-9]_[0-9][0-9]" .simone/DASHBOARD.md | while read ref; do
    find .simone/ -name "*${ref}*" || echo "Missing: $ref"
done

# Check milestone and sprint references
grep -r "M[0-9][0-9]" .simone/DASHBOARD.md
grep -r "S[0-9][0-9]_M[0-9][0-9]" .simone/DASHBOARD.md
```

**Quality Gates:**
- **Accuracy**: All metrics reflect current project state
- **Completeness**: No {PLACEHOLDER} values in published dashboard
- **Consistency**: Status values match source documents
- **Timeliness**: Updated within 24 hours of major events

### 7. Set next update schedule and automation triggers

**Update Frequency Calculation:**

**Project Velocity-Based Scheduling:**
```
if project_velocity > 10_tasks_per_week:
    next_update = current_date + 2_days
elif project_velocity > 5_tasks_per_week:
    next_update = current_date + 3_days
else:
    next_update = current_date + 7_days
```

**Trigger-Based Updates:**

**Automatic Update Triggers:**
- **Task Completion**: When any task status changes to `completed`
- **Sprint Completion**: When all sprint tasks are completed
- **Milestone Progress**: When milestone completion changes by ≥10%
- **Risk Changes**: When any risk level changes (low→medium→high)

**Integration with Existing Commands:**
```yaml
# Commands that should auto-trigger dashboard updates:
update_task_status: "if task_completed or milestone_progress_changed"
do_task: "if task_completed"
create_milestone: "always"
create_sprint_tasks: "always"
project_review: "always"
```

**Next Update Metadata:**
```yaml
{NEXT_UPDATE_DATE} → "2025-01-14"
{UPDATE_FREQUENCY} → "Every 3 days or on task completion"
{AUTOMATION_LEVEL} → "Semi-automated"
{MANUAL_UPDATE_ITEMS} → "Team structure, external dependencies"
```

**Automation Enhancement Pattern:**
```bash
# Add to other commands (pseudo-code):
if command_affects_dashboard_metrics():
    if dashboard_staleness > threshold:
        auto_trigger_dashboard_update()
        log_dashboard_update_in_command_output()
```

## Command Integration Examples

**Enhanced Task Management:**
```bash
# After task completion
/project:simone:update_task_status T07_02 completed
# → Auto-triggers dashboard update if criteria met

# After milestone creation  
/project:simone:create_milestone "Authentication System"
# → Always triggers dashboard update
```

**Git Integration:**
```bash
# Pre-commit hook integration
git commit -m "feat: implement dashboard updates"
# → Check if dashboard needs updating based on changes
```

**CI/CD Integration:**
```bash
# Deployment pipeline
deploy_to_staging:
  - run: /project:simone:update_dashboard --metrics-only
  - validate: dashboard_staleness < 24_hours
```

## Error Handling and Recovery

**Common Error Scenarios:**

**Missing Data Sources:**
- Gracefully handle missing project manifest
- Use defaults for unavailable metrics
- Log warnings for incomplete data collection

**Template Issues:**
- Validate template structure before processing
- Handle missing placeholder variables
- Recover from corrupted dashboard files

**Calculation Errors:**
- Validate numeric ranges (percentages 0-100%)
- Handle division by zero in velocity calculations
- Provide fallbacks for missing historical data

**Recovery Procedures:**
```bash
# Data corruption recovery
cp .simone/99_TEMPLATES/dashboard_template.md .simone/DASHBOARD.md
/project:simone:update_dashboard --force

# Missing template recovery
curl -o .simone/99_TEMPLATES/dashboard_template.md \
  https://raw.githubusercontent.com/simone-framework/templates/main/dashboard_template.md
```

## Output Examples

**Success Output:**
```
✅ Dashboard Update Complete

📊 Project Overview:
   Progress: 67% (97/145 tasks completed)
   Current Sprint: S07_M02 (8/12 tasks, 67% complete)
   Velocity: 8.7 tasks/week (trending up)

📈 Key Changes:
   • Milestone M02 progress: 60% → 65% (+5%)
   • Technical debt level: Medium → Low (improved)
   • Documentation coverage: 82% → 85% (+3%)

📅 Next Update: January 14, 2025 (3 days)
   Auto-trigger: On task completion or sprint change

📄 Dashboard: .simone/DASHBOARD.md
   Last Updated: 2025-01-11 14:30:00
   Data Sources: 145 tasks, 7 sprints, 30-day git history
```

**Validation Warnings:**
```
⚠️  Dashboard Update Warning

🔍 Validation Issues Found:
   • Sprint S06_M02 has inconsistent task count (expected 8, found 6)
   • Milestone M03 missing progress metadata
   • 2 task references point to non-existent files

✅ Update Completed with Warnings
   Manual review recommended for accuracy
   
📋 Action Items:
   • Verify S06_M02 task completion status
   • Update M03 milestone metadata
   • Clean up orphaned task references
```

## Performance Considerations

**Optimization Strategies:**
- Cache calculated metrics between runs
- Incremental updates for large projects
- Parallel data collection from multiple sources
- Smart scheduling based on project activity

**Scalability Features:**
- Support for multi-milestone projects
- Cross-team coordination indicators
- Portfolio-level metrics aggregation
- Historical trend analysis and forecasting

---

## Quick Reference

**Basic Usage:**
```bash
/project:simone:update_dashboard
```

**Advanced Options:**
```bash
/project:simone:update_dashboard --force --detailed
/project:simone:update_dashboard metrics --dry-run
```

**Automation Integration:**
```bash
# Add to other commands for auto-updates
if [ "$TASK_STATUS" = "completed" ]; then
    /project:simone:update_dashboard --silent
fi
```

---

*Update Dashboard v1.0 | Simone Framework | Automated metrics and comprehensive project tracking*