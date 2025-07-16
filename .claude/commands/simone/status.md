# Status - Project and Workflow Status Dashboard

Provides comprehensive status overview of project health, task progress, deployment state, and workflow metrics.

## Create a TODO with EXACTLY these 8 Items

1. Parse status arguments and determine scope
2. Gather project health and milestone metrics
3. Analyze task and sprint progress status
4. Review deployment and environment status
5. Assess code quality and technical health
6. Generate workflow and team productivity metrics
7. Create comprehensive status dashboard
8. Provide actionable insights and recommendations

## DETAILS on every TODO item

### 1. Parse status arguments and determine scope

**Arguments Format:** `[scope] [detail_level] [format]`

**Examples:**
- `/project:simone:status` (full project overview)
- `/project:simone:status tasks` (task-focused view)
- `/project:simone:status sprint current` (current sprint status)
- `/project:simone:status deployment --detailed`

**Status Scopes:**
- **project**: Overall project health and metrics
- **tasks**: Task and bug status across all sprints
- **sprint**: Current or specific sprint status
- **deployment**: Environment and deployment status
- **quality**: Code quality and technical metrics
- **team**: Team productivity and capacity metrics

**Detail Levels:**
- **summary**: High-level overview with key metrics
- **detailed**: Comprehensive status with all metrics
- **executive**: Executive summary for stakeholders
- **operational**: Operational details for team leads

### 2. Gather project health and milestone metrics

**MCP INTEGRATION:** Use MCP servers for enhanced status reporting:
- **Sequential Thinking**: Structure status analysis systematically
- **GitHub**: Track progress patterns and trend analysis
- **Context7**: Maintain context about project evolution
- **Serena**: Enhance project analysis and health assessment

**Project Overview:**
```markdown
## 📊 Project Health Overview

### Current State
- **Project**: {project_name}
- **Current Milestone**: {current_milestone} ({completion_percentage}%)
- **Current Sprint**: {current_sprint} ({sprint_progress}%)
- **Project Status**: {project_status}
- **Last Updated**: {last_update_timestamp}

### Milestone Progress
- **Total Milestones**: {total_milestones}
- **Completed**: {completed_milestones}
- **In Progress**: {in_progress_milestones}
- **Planned**: {planned_milestones}
- **On Track**: {on_track_status} ✅/⚠️/🚨
```

**Health Metrics Collection:**
- **Completion Rates**: Milestone and sprint completion percentages
- **Velocity Tracking**: Historical task completion velocity
- **Quality Metrics**: Bug rates, technical debt, code coverage
- **Risk Assessment**: Project risks and mitigation status
- **Resource Utilization**: Team capacity and allocation

### 3. Analyze task and sprint progress status

**Task Status Analysis:**
```markdown
## 📋 Task & Sprint Analysis

### Current Sprint: {sprint_id}
- **Duration**: {sprint_duration} ({days_remaining} days remaining)
- **Capacity**: {planned_capacity}h / {actual_capacity}h
- **Velocity**: {current_velocity} vs {target_velocity}
- **Burndown**: {burndown_status}

### Task Distribution
- **Total Tasks**: {total_tasks}
  - ✅ **Completed**: {completed_tasks} ({completion_percentage}%)
  - 🚧 **In Progress**: {in_progress_tasks}
  - 📋 **Pending**: {pending_tasks}
  - 🚫 **Blocked**: {blocked_tasks}

### Bug Status
- **Open Bugs**: {open_bugs}
  - 🚨 **Critical**: {critical_bugs}
  - ⚠️ **High**: {high_bugs}
  - 📝 **Medium**: {medium_bugs}
  - 💭 **Low**: {low_bugs}
```

**Sprint Health Indicators:**
- **Burndown Trajectory**: On track / Behind / Ahead
- **Scope Changes**: Added/removed tasks during sprint
- **Blocked Tasks**: Number and duration of blocked items
- **Team Capacity**: Planned vs actual availability

**Task Metrics:**
- **Cycle Time**: Average time from start to completion
- **Lead Time**: Average time from creation to completion
- **Effort Accuracy**: Estimated vs actual effort tracking
- **Completion Rate**: Percentage of tasks completed on time

### 4. Review deployment and environment status

**Environment Status:**
```markdown
## 🚀 Deployment & Environment Status

### Environment Health
- **Development**: {dev_status} | **Version**: {dev_version}
- **Staging**: {staging_status} | **Version**: {staging_version}
- **Production**: {prod_status} | **Version**: {prod_version}

### Recent Deployments
- **Last Production Deploy**: {last_prod_deploy} ({prod_version})
- **Last Staging Deploy**: {last_staging_deploy} ({staging_version})
- **Deployment Success Rate**: {deployment_success_rate}%

### Pending Releases
- **Ready for Staging**: {staging_ready_count} features
- **Ready for Production**: {production_ready_count} features
- **Next Release**: {next_release_version} (ETA: {release_eta})
```

**Infrastructure Metrics:**
- **System Health**: Response times, error rates, availability
- **Performance**: Current vs baseline performance metrics
- **Security**: Security scan results, vulnerability status
- **Monitoring**: Alert status and system monitoring health

### 5. Assess code quality and technical health

**Code Quality Metrics:**
```markdown
## 🔧 Code Quality & Technical Health

### Quality Metrics
- **Test Coverage**: {test_coverage}% (Target: {coverage_target}%)
- **Code Quality Score**: {quality_score}/100
- **Technical Debt**: {tech_debt_hours}h estimated
- **Security Score**: {security_score}/100

### Code Analysis
- **Lines of Code**: {total_loc} (+{loc_change} this sprint)
- **Complexity**: {avg_complexity} (Target: <{complexity_target})
- **Duplication**: {duplication_percentage}% (Target: <{duplication_target}%)
- **Maintainability Index**: {maintainability_score}/100

### Technical Debt
- **Critical Issues**: {critical_debt_issues}
- **High Priority**: {high_debt_issues}
- **Medium Priority**: {medium_debt_issues}
- **Estimated Resolution**: {debt_resolution_time}
```

**Quality Trends:**
- **Coverage Trend**: Improving / Stable / Declining
- **Complexity Trend**: Increasing / Stable / Decreasing
- **Bug Introduction Rate**: New bugs per sprint
- **Fix Rate**: Bug resolution velocity

### 6. Generate workflow and team productivity metrics

**Team Productivity:**
```markdown
## 👥 Team & Workflow Metrics

### Team Performance
- **Active Contributors**: {active_contributors}
- **Avg Tasks per Person**: {tasks_per_person}
- **Collaboration Index**: {collaboration_score}/100
- **Knowledge Distribution**: {knowledge_distribution}

### Workflow Efficiency
- **Cycle Time**: {avg_cycle_time} days
- **Lead Time**: {avg_lead_time} days
- **Throughput**: {tasks_per_week} tasks/week
- **Flow Efficiency**: {flow_efficiency}%

### Process Metrics
- **Code Review Time**: {avg_review_time} hours
- **Deployment Frequency**: {deployment_frequency}
- **Change Failure Rate**: {change_failure_rate}%
- **Mean Time to Recovery**: {mttr} hours
```

**Productivity Indicators:**
- **Velocity Consistency**: Sprint-to-sprint velocity variance
- **Predictability**: Estimation accuracy trends
- **Bottlenecks**: Workflow bottleneck identification
- **Capacity Utilization**: Team capacity vs actual utilization

### 7. Create comprehensive status dashboard

**Executive Dashboard:**
```markdown
# 📊 Project Status Dashboard

## Executive Summary
**Project Health**: {overall_health_indicator} | **On Track**: {on_track_status} | **Risk Level**: {risk_level}

### Key Metrics
| Metric | Current | Target | Trend |
|--------|---------|--------|-------|
| Milestone Progress | {milestone_progress}% | {milestone_target}% | {milestone_trend} |
| Sprint Velocity | {current_velocity} | {target_velocity} | {velocity_trend} |
| Quality Score | {quality_score} | {quality_target} | {quality_trend} |
| Deployment Success | {deploy_success}% | 95% | {deploy_trend} |

### Status Indicators
- 🎯 **Scope**: {scope_status}
- 📅 **Schedule**: {schedule_status}
- 👥 **Resources**: {resource_status}
- 🔧 **Quality**: {quality_status}
- 🚀 **Delivery**: {delivery_status}

## Current Focus
### This Sprint ({sprint_id})
- **Goal**: {sprint_goal}
- **Progress**: {sprint_progress}% complete
- **Risk**: {sprint_risk_level}
- **Key Deliverables**: {key_deliverables}

### Next Milestone ({next_milestone})
- **Target Date**: {milestone_target_date}
- **Confidence**: {delivery_confidence}%
- **Dependencies**: {milestone_dependencies}
- **Risks**: {milestone_risks}
```

**Operational Dashboard:**
```markdown
## 🔧 Operational Status

### Active Work Items
- **Tasks in Progress**: {active_tasks_list}
- **Code Reviews Pending**: {pending_reviews}
- **Deployments Ready**: {ready_deployments}
- **Issues Requiring Attention**: {attention_required}

### System Health
- **All Environments**: {env_health_summary}
- **Monitoring Alerts**: {active_alerts}
- **Performance**: {performance_summary}
- **Security**: {security_summary}

### Team Capacity
- **Available Capacity**: {available_capacity}h
- **Committed Work**: {committed_work}h
- **Buffer**: {capacity_buffer}h
- **Overallocation Risk**: {overallocation_risk}
```

### 8. Provide actionable insights and recommendations

**Automated Insights:**
```markdown
## 💡 Insights & Recommendations

### 🎯 Performance Insights
{AI-generated analysis of current performance vs targets}

### ⚠️ Risk Factors
{Identified risks and their potential impact}

### 📈 Opportunities
{Areas for improvement and optimization}

### 🔧 Immediate Actions
{Recommended immediate actions for team}

## Action Items

### High Priority
- [ ] {high_priority_action_1}
- [ ] {high_priority_action_2}
- [ ] {high_priority_action_3}

### Medium Priority
- [ ] {medium_priority_action_1}
- [ ] {medium_priority_action_2}

### Continuous Improvement
- [ ] {improvement_suggestion_1}
- [ ] {improvement_suggestion_2}

## Trend Analysis

### Positive Trends
- ✅ {positive_trend_1}
- ✅ {positive_trend_2}

### Areas of Concern
- ⚠️ {concern_1}
- ⚠️ {concern_2}

### Recommended Focus
Based on current metrics and trends:
1. **{focus_area_1}**: {focus_description_1}
2. **{focus_area_2}**: {focus_description_2}
3. **{focus_area_3}**: {focus_description_3}
```

## Status Report Types

### Daily Standup Status
```markdown
## 🌅 Daily Status Summary

### Yesterday's Accomplishments
- {completed_yesterday}

### Today's Plan
- {planned_today}

### Blockers & Issues
- {current_blockers}

### Team Availability
- {team_availability_summary}
```

### Weekly Status Report
```markdown
## 📅 Weekly Status Report

### Sprint Progress
- {weekly_sprint_summary}

### Completed This Week
- {weekly_accomplishments}

### Planned Next Week
- {next_week_plans}

### Risks & Mitigation
- {weekly_risks_and_mitigation}
```

### Monthly Executive Report
```markdown
## 📊 Monthly Executive Summary

### Milestone Achievement
- {monthly_milestone_progress}

### Key Metrics
- {monthly_key_metrics}

### Resource Utilization
- {monthly_resource_summary}

### Strategic Initiatives
- {strategic_progress}
```

## Advanced Status Features

### Real-time Monitoring
- Live updates from CI/CD pipelines
- Real-time deployment status
- Live team activity tracking
- Automated alert integration

### Predictive Analytics
- Sprint completion probability
- Milestone delivery confidence
- Resource requirement forecasting
- Risk trend analysis

### Customizable Views
- Role-based dashboard customization
- Stakeholder-specific reports
- Team-focused metrics
- Project-specific KPIs

### Integration Capabilities
- Slack/Teams status updates
- Email report generation
- Dashboard API for external tools
- Export capabilities (PDF, CSV, JSON)

This comprehensive status system provides real-time visibility into all aspects of project health while integrating seamlessly with the Simone task management framework and supporting data-driven decision making.