# Sprint Health - Comprehensive Sprint Progress and Team Health Assessment

Provides real-time analysis of sprint progress, team velocity, burndown trends, risk factors, and overall sprint health to enable proactive sprint management and team optimization.

## Create a TODO with EXACTLY these 6 Items

1. Parse sprint health arguments and determine target sprint
2. Analyze sprint progress metrics and burndown trends
3. Assess team capacity utilization and velocity patterns
4. Evaluate sprint scope and commitment health
5. Identify risks, blockers, and improvement opportunities
6. Generate actionable sprint health dashboard and recommendations

## DETAILS on every TODO item

### 1. Parse sprint health arguments and determine target sprint

**Arguments Format:** `[sprint_id] [focus_area] [detail_level] [--flags]`

**Examples:**
- `/project:simone:sprint_health` (current sprint analysis)
- `/project:simone:sprint_health S03_M02` (specific sprint)
- `/project:simone:sprint_health current velocity` (velocity focus)
- `/project:simone:sprint_health --predictive` (include predictions)

**Sprint Selection:**
- **current**: Currently active sprint (default)
- **S##_M##**: Specific sprint identifier
- **last**: Most recently completed sprint
- **next**: Upcoming planned sprint
- **all**: Multi-sprint trend analysis

**Focus Areas:**
- **overview**: Comprehensive sprint health summary
- **velocity**: Team velocity and productivity analysis
- **burndown**: Burndown chart and trend analysis
- **capacity**: Team capacity and utilization assessment
- **scope**: Sprint scope and commitment analysis
- **risks**: Risk identification and mitigation analysis

**Detail Levels:**
- **summary**: High-level health indicators
- **detailed**: Comprehensive metrics and analysis
- **diagnostic**: Deep-dive problem identification
- **predictive**: Forward-looking projections

### 2. Analyze sprint progress metrics and burndown trends

**MCP INTEGRATION:** Use MCP servers for enhanced sprint analysis:
- **Sequential Thinking**: Structure sprint health analysis systematically
- **GitHub**: Track sprint patterns and historical performance
- **Serena**: Enhance data analysis and trend identification

**Sprint Progress Analysis:**
```markdown
## 📊 Sprint Progress Overview

### Sprint Identification
- **Sprint**: {sprint_id} ({sprint_name})
- **Duration**: {sprint_duration} days ({days_elapsed}/{total_days} completed)
- **Start Date**: {start_date} | **End Date**: {end_date}
- **Days Remaining**: {days_remaining}

### Progress Metrics
- **Overall Progress**: {overall_progress}% complete
- **Story Points**: {completed_points}/{committed_points} ({points_percentage}%)
- **Task Completion**: {completed_tasks}/{total_tasks} ({task_percentage}%)
- **Sprint Goal Progress**: {goal_progress}% toward sprint goal

### Burndown Analysis
- **Ideal Burndown**: {ideal_remaining} points remaining
- **Actual Burndown**: {actual_remaining} points remaining
- **Burndown Trend**: {burndown_trend} (Ahead/On Track/Behind)
- **Velocity Indicator**: {velocity_indicator} (Accelerating/Stable/Slowing)

### Daily Progress Tracking
- **Average Daily Burndown**: {avg_daily_burndown} points/day
- **Target Daily Burndown**: {target_daily_burndown} points/day
- **Completion Projection**: Sprint completion at {projected_completion}%
- **Risk Level**: {risk_level} (Low/Medium/High/Critical)
```

**Burndown Trend Analysis:**
- **Trajectory Assessment**: Mathematical analysis of burndown curve
- **Completion Probability**: Statistical likelihood of sprint success
- **Scope Creep Detection**: Changes in total committed work
- **Work Pattern Analysis**: Daily/weekly work completion patterns

### 3. Assess team capacity utilization and velocity patterns

**Team Capacity Analysis:**
```markdown
## 👥 Team Capacity & Velocity Assessment

### Team Composition
- **Team Size**: {team_size} active members
- **Available Capacity**: {available_capacity}h total
- **Planned Capacity**: {planned_capacity}h allocated
- **Capacity Utilization**: {capacity_utilization}% ({capacity_status})

### Individual Capacity
{individual_capacity_breakdown}

### Velocity Metrics
- **Current Sprint Velocity**: {current_velocity} points
- **Historical Average**: {avg_velocity} points (last {velocity_periods} sprints)
- **Velocity Trend**: {velocity_trend} ({velocity_change}% vs average)
- **Velocity Consistency**: {velocity_consistency}% (standard deviation)

### Productivity Indicators
- **Story Points per Hour**: {points_per_hour}
- **Task Completion Rate**: {task_completion_rate} tasks/day
- **Focus Time**: {focus_time}% of capacity on sprint work
- **Context Switching**: {context_switching} interruptions/day

### Capacity Challenges
- **Over-allocation**: {over_allocated_members} team members
- **Under-utilization**: {under_utilized_capacity}h unused
- **Vacation/PTO**: {pto_impact}h capacity impact
- **Unplanned Work**: {unplanned_work}% of capacity
```

### 4. Evaluate sprint scope and commitment health

**Sprint Scope Analysis:**
```markdown
## 🎯 Sprint Scope & Commitment Health

### Sprint Goal Assessment
- **Sprint Goal**: {sprint_goal}
- **Goal Clarity**: {goal_clarity_score}/100
- **Goal Progress**: {goal_progress}% complete
- **Goal Achievability**: {goal_achievability} (High/Medium/Low)

### Commitment Analysis
- **Original Commitment**: {original_commitment} points
- **Current Scope**: {current_scope} points
- **Scope Change**: {scope_change} points ({scope_change_percentage}%)
- **Commitment Confidence**: {commitment_confidence}%

### Story Breakdown
- **Epic Progress**: {epic_progress_summary}
- **Story States**: 
  - ✅ **Done**: {done_stories} ({done_percentage}%)
  - 🚧 **In Progress**: {in_progress_stories}
  - 📋 **To Do**: {todo_stories}
  - 🚫 **Blocked**: {blocked_stories}

### Scope Changes Tracking
- **Added During Sprint**: {added_work} points
- **Removed During Sprint**: {removed_work} points
- **Net Scope Change**: {net_scope_change} points
- **Change Reasons**: {change_reasons_summary}

### Definition of Done Compliance
- **DoD Adherence**: {dod_compliance}%
- **Quality Gates Met**: {quality_gates_met}/{total_quality_gates}
- **Technical Debt Created**: {new_tech_debt}h estimated
- **Test Coverage**: {test_coverage}% (Target: {coverage_target}%)
```

### 5. Identify risks, blockers, and improvement opportunities

**Risk Assessment:**
```markdown
## ⚠️ Risk Analysis & Blocker Assessment

### Current Blockers
- **Active Blockers**: {active_blockers_count}
  - 🚨 **Critical**: {critical_blockers} (blocking {critical_blocked_points} points)
  - ⚠️ **High**: {high_blockers} (blocking {high_blocked_points} points)
  - 📝 **Medium**: {medium_blockers} (blocking {medium_blocked_points} points)

### Blocker Analysis
{detailed_blocker_list}

### Risk Factors
- **Schedule Risk**: {schedule_risk} (Low/Medium/High/Critical)
  - Days Behind: {days_behind}
  - Projected Overage: {projected_overage}%
  
- **Scope Risk**: {scope_risk}
  - Scope Creep: {scope_creep}%
  - Unclear Requirements: {unclear_requirements_count}
  
- **Quality Risk**: {quality_risk}
  - Bug Introduction Rate: {bug_rate} bugs/day
  - Technical Debt Accumulation: {debt_accumulation}h
  
- **Team Risk**: {team_risk}
  - Key Person Dependencies: {key_person_deps}
  - Team Availability Issues: {availability_issues}

### Risk Mitigation Status
- **Identified Risks**: {total_risks}
- **Risks with Mitigation Plans**: {mitigated_risks}
- **Unaddressed Risks**: {unaddressed_risks}
- **Risk Mitigation Effectiveness**: {mitigation_effectiveness}%

### Early Warning Indicators
- **Velocity Decline**: {velocity_decline_warning}
- **Burndown Deviation**: {burndown_deviation_warning}
- **Quality Degradation**: {quality_degradation_warning}
- **Team Stress Indicators**: {stress_indicators_warning}
```

### 6. Generate actionable sprint health dashboard and recommendations

**Sprint Health Dashboard:**
```markdown
# 📊 Sprint Health Dashboard

## Overall Sprint Health: {overall_health_grade}

### Health Scorecard
| Metric | Score | Target | Status | Trend |
|--------|-------|--------|--------|-------|
| Progress | {progress_score}/100 | 85+ | {progress_status} | {progress_trend} |
| Velocity | {velocity_score}/100 | 90+ | {velocity_status} | {velocity_trend} |
| Capacity | {capacity_score}/100 | 80+ | {capacity_status} | {capacity_trend} |
| Quality | {quality_score}/100 | 85+ | {quality_status} | {quality_trend} |
| Team Health | {team_score}/100 | 80+ | {team_status} | {team_trend} |
| Risk Level | {risk_score}/100 | 70+ | {risk_status} | {risk_trend} |

## 🎯 Sprint Success Probability
**Completion Likelihood**: {completion_probability}%
**On-Time Delivery**: {ontime_probability}%  
**Quality Standards**: {quality_probability}%

## 🚨 Immediate Attention Required
{immediate_actions_list}

## 📈 Key Performance Indicators
- **Sprint Burndown**: {burndown_kpi}
- **Team Velocity**: {velocity_kpi}
- **Story Completion**: {story_completion_kpi}
- **Blocker Resolution**: {blocker_resolution_kpi}

---

## 💡 Actionable Recommendations

### 🚨 Critical Actions (Today)
- [ ] **{critical_action_1}**: {critical_description_1}
- [ ] **{critical_action_2}**: {critical_description_2}

### ⚠️ High Priority (This Week)
- [ ] **{high_action_1}**: {high_description_1}
- [ ] **{high_action_2}**: {high_description_2}
- [ ] **{high_action_3}**: {high_description_3}

### 📝 Process Improvements (Next Sprint)
- [ ] **{improvement_1}**: {improvement_description_1}
- [ ] **{improvement_2}**: {improvement_description_2}

## 🔧 Sprint Adjustment Recommendations

### Scope Adjustments
- **Consider Removing**: {scope_removal_candidates}
- **Priority Re-ranking**: {priority_adjustments}
- **Definition of Done**: {dod_adjustments}

### Team Optimization
- **Capacity Reallocation**: {capacity_recommendations}
- **Skill Gap Mitigation**: {skill_gap_solutions}
- **Collaboration Enhancement**: {collaboration_improvements}

### Process Improvements
- **Daily Standup Focus**: {standup_improvements}
- **Review Process**: {review_process_improvements}
- **Quality Gates**: {quality_gate_adjustments}

## 📊 Trend Analysis & Predictions

### Historical Performance
- **3-Sprint Velocity Trend**: {three_sprint_trend}
- **Completion Rate Trend**: {completion_rate_trend}
- **Quality Metrics Trend**: {quality_metrics_trend}

### Predictions
- **Sprint Completion**: {sprint_completion_prediction}
- **Milestone Impact**: {milestone_impact_prediction}
- **Team Performance**: {team_performance_prediction}

## 🎯 Sprint Success Strategies

### To Improve Completion Probability:
{completion_strategies}

### To Maintain Quality Standards:
{quality_strategies}

### To Optimize Team Performance:
{team_optimization_strategies}

## 📅 Daily Health Monitoring

### Today's Focus
- **Priority Tasks**: {today_priority_tasks}
- **Blocker Resolution**: {today_blocker_focus}
- **Capacity Check**: {today_capacity_status}

### Tomorrow's Planning
- **Predicted Completion**: {tomorrow_predicted_completion}
- **Capacity Allocation**: {tomorrow_capacity_plan}
- **Risk Mitigation**: {tomorrow_risk_actions}

## 🔄 Continuous Monitoring

### Real-time Metrics to Track
- Sprint burndown progress
- Daily task completion rate
- Blocker resolution time
- Team capacity utilization

### Intervention Triggers
- Burndown deviation >20%
- Velocity drop >15%
- Critical blockers >24h
- Quality metrics below threshold

### Success Indicators
- Sprint goal achievement
- Team satisfaction scores
- Delivery predictability
- Technical debt management
```

## Sprint Health Types

### Daily Sprint Health Check
```markdown
## 🌅 Daily Sprint Pulse
- Quick 5-minute health assessment
- Focus on immediate blockers and progress
- Trend indicators and early warnings
```

### Mid-Sprint Deep Dive
```markdown
## 🔍 Mid-Sprint Health Assessment
- Comprehensive sprint analysis
- Scope adjustment recommendations
- Team performance optimization
```

### Sprint Retrospective Health Review
```markdown
## 🔄 Sprint Health Retrospective
- Complete sprint performance analysis
- Lessons learned and improvements
- Next sprint planning recommendations
```

This comprehensive sprint health system provides real-time visibility into sprint performance while enabling proactive management and continuous improvement of team delivery capabilities.