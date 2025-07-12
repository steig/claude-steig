# Close Sprint - Sprint Completion and Transition Management

Facilitates systematic sprint closure with completion analysis, carryover management, retrospective preparation, and smooth transition to the next sprint while maintaining project continuity.

## Create a TODO with EXACTLY these 6 Items

1. Validate sprint closure prerequisites and readiness
2. Analyze sprint completion metrics and performance
3. Manage incomplete tasks and carryover planning
4. Generate sprint retrospective analysis and insights
5. Archive sprint artifacts and update project status
6. Prepare and initialize next sprint transition

## DETAILS on every TODO item

### 1. Validate sprint closure prerequisites and readiness

**Arguments Format:** `[sprint_id] [--force] [--archive-mode] [--next-sprint]`

**Examples:**
- `/project:simone:close_sprint` (close current sprint)
- `/project:simone:close_sprint S03_M02` (close specific sprint)
- `/project:simone:close_sprint --force` (force close with incomplete tasks)
- `/project:simone:close_sprint --next-sprint=S04_M02` (specify next sprint)

**Prerequisites Validation:**
```markdown
## ✅ Sprint Closure Readiness Check

### Completion Status
- **Sprint Goal Achievement**: {goal_achievement}% ({goal_status})
- **Story Completion**: {story_completion}% ({stories_done}/{total_stories})
- **Task Completion**: {task_completion}% ({tasks_done}/{total_tasks})
- **Acceptance Criteria**: {acceptance_criteria}% met

### Quality Gates
- **Definition of Done**: {dod_compliance}% compliance
- **Code Review**: {code_review_completion}% complete
- **Testing**: {testing_completion}% complete
- **Documentation**: {documentation_completion}% complete

### Outstanding Items
- **Incomplete Stories**: {incomplete_stories} requiring decision
- **Active Blockers**: {active_blockers} need resolution
- **Pending Reviews**: {pending_reviews} awaiting approval
- **Critical Issues**: {critical_issues} must be addressed

### Team Readiness
- **Team Availability**: {team_availability} for closure activities
- **Retrospective Scheduled**: {retro_scheduled} (Yes/No)
- **Next Sprint Prepared**: {next_sprint_ready} (Yes/No)
```

### 2. Analyze sprint completion metrics and performance

**Sprint Performance Analysis:**
```markdown
## 📊 Sprint Performance Summary

### Key Metrics
- **Velocity Achieved**: {actual_velocity} points (Target: {target_velocity})
- **Velocity Variance**: {velocity_variance}% vs historical average
- **Completion Rate**: {completion_rate}% (Target: 85%+)
- **Cycle Time**: {avg_cycle_time} days (Target: <{target_cycle_time})

### Sprint Goals Assessment
- **Primary Goal**: {primary_goal_status} ({primary_goal_completion}%)
- **Secondary Goals**: {secondary_goals_completion}% average completion
- **Goal Achievement Rating**: {goal_rating}/5 ⭐

### Quality Metrics
- **Bug Introduction**: {bugs_introduced} new bugs
- **Technical Debt**: {tech_debt_added}h added, {tech_debt_resolved}h resolved
- **Code Coverage**: {code_coverage}% (Target: {coverage_target}%)
- **Review Cycle Time**: {review_cycle_time} hours average

### Team Performance
- **Individual Completion Rates**: {individual_performance_summary}
- **Collaboration Index**: {collaboration_score}/100
- **Focus Time**: {focus_time_percentage}% of capacity
- **Unplanned Work**: {unplanned_work_percentage}% of capacity

### Comparison to Previous Sprints
- **Velocity Trend**: {velocity_trend} ({velocity_change}% change)
- **Quality Trend**: {quality_trend} 
- **Team Satisfaction**: {satisfaction_trend}
```

### 3. Manage incomplete tasks and carryover planning

**Carryover Management:**
```markdown
## 🔄 Incomplete Work Management

### Incomplete Items Analysis
- **Total Incomplete**: {incomplete_count} items ({incomplete_percentage}%)
- **Story Points Remaining**: {remaining_points} points
- **Estimated Completion**: {completion_estimate} days

### Categorization of Incomplete Work
- **Near Completion** (>80% done): {near_complete_items}
- **In Progress** (20-80% done): {in_progress_items}  
- **Not Started** (<20% done): {not_started_items}
- **Blocked**: {blocked_items}

### Carryover Decisions
{carryover_decision_matrix}

### Next Sprint Allocation
- **Automatic Carryover**: {auto_carryover_items}
- **Re-prioritization Required**: {reprioritization_items}
- **Scope Reduction**: {scope_reduction_items}
- **Backlog Return**: {backlog_return_items}

### Dependencies Impact
- **Blocks Next Sprint**: {blocking_dependencies}
- **Affects Milestone**: {milestone_impact}
- **External Dependencies**: {external_dependencies}
```

### 4. Generate sprint retrospective analysis and insights

**Retrospective Preparation:**
```markdown
## 🔄 Sprint Retrospective Analysis

### What Went Well
- **High Performance Areas**: {high_performance_areas}
- **Successful Practices**: {successful_practices}
- **Team Achievements**: {team_achievements}
- **Process Improvements**: {process_improvements}

### What Didn't Go Well
- **Performance Challenges**: {performance_challenges}
- **Process Bottlenecks**: {process_bottlenecks}
- **Team Obstacles**: {team_obstacles}
- **External Blockers**: {external_blockers}

### Lessons Learned
- **Technical Insights**: {technical_lessons}
- **Process Learnings**: {process_lessons}
- **Team Dynamics**: {team_lessons}
- **Stakeholder Management**: {stakeholder_lessons}

### Action Items for Next Sprint
- **Process Changes**: {process_changes}
- **Tool Improvements**: {tool_improvements}
- **Team Development**: {team_development}
- **Communication Enhancements**: {communication_improvements}

### Metrics for Retrospective Discussion
- **Velocity Consistency**: {velocity_metrics}
- **Quality Trends**: {quality_metrics}
- **Team Satisfaction**: {satisfaction_metrics}
- **Delivery Predictability**: {predictability_metrics}
```

### 5. Archive sprint artifacts and update project status

**Sprint Archival Process:**
```markdown
## 📦 Sprint Archival & Status Updates

### Artifact Archival
- **Sprint Folder**: Moving to completed sprints archive
- **Task Documentation**: {task_docs_archived} files archived
- **Meeting Notes**: {meeting_notes_archived} files archived
- **Sprint Artifacts**: {artifacts_archived} total items

### Status Updates Required
- **Project Manifest**: Update current sprint reference
- **Milestone Progress**: Update completion percentage
- **Task Status**: Mark completed tasks with completion dates
- **Team Metrics**: Update velocity and performance data

### Archive Structure
```
.simone/03_SPRINTS/COMPLETED/
├── {sprint_id}/
│   ├── {sprint_id}_sprint_meta.md (final version)
│   ├── completed_tasks/
│   ├── carryover_analysis.md
│   └── retrospective_summary.md
```

### Documentation Updates
- **Sprint Summary**: Final sprint performance summary
- **Lessons Learned**: Key insights and improvements
- **Metrics Update**: Historical velocity and quality data
- **Knowledge Base**: Process improvements and best practices

### Project Health Update
- **Overall Progress**: {project_progress_update}%
- **Milestone Status**: {milestone_status_update}
- **Risk Assessment**: {risk_assessment_update}
- **Resource Utilization**: {resource_utilization_update}
```

### 6. Prepare and initialize next sprint transition

**Next Sprint Preparation:**
```markdown
## 🚀 Next Sprint Initialization

### Next Sprint Setup
- **Sprint ID**: {next_sprint_id}
- **Sprint Goal**: {next_sprint_goal}
- **Duration**: {next_sprint_duration} days
- **Team Capacity**: {next_sprint_capacity}h available

### Backlog Preparation
- **Carryover Items**: {carryover_items_count} items ({carryover_points} points)
- **New Stories**: {new_stories_ready} stories ready for commitment
- **Refined Backlog**: {refined_backlog_count} items ready
- **Estimated Capacity**: {estimated_capacity} points

### Team Preparation
- **Team Availability**: {team_availability_next}
- **Skill Requirements**: {skill_requirements_analysis}
- **Training Needs**: {training_needs_identified}
- **Resource Allocation**: {resource_allocation_plan}

### Planning Readiness
- **Product Owner Availability**: {po_availability}
- **Stakeholder Engagement**: {stakeholder_readiness}
- **Requirements Clarity**: {requirements_clarity}%
- **Planning Meeting Scheduled**: {planning_meeting_scheduled}

### Automation Setup
- **Next Sprint Folder**: Created and initialized
- **Template Population**: Sprint templates prepared
- **Tool Configuration**: Development tools configured
- **CI/CD Pipeline**: Updated for next sprint branch

### Transition Checklist
- [ ] Sprint closure ceremony completed
- [ ] Retrospective conducted and documented
- [ ] Carryover items properly categorized
- [ ] Next sprint folder structure created
- [ ] Team capacity confirmed for next sprint
- [ ] Sprint planning meeting scheduled
- [ ] Stakeholders notified of sprint transition
- [ ] Metrics updated in project dashboard
```

## Sprint Closure Types

### Normal Sprint Closure
```markdown
## ✅ Standard Sprint Completion
- All sprint goals achieved or acceptably addressed
- Minimal carryover items
- Team satisfaction maintained
- Quality standards met
```

### Early Sprint Closure
```markdown
## ⏩ Early Sprint Completion
- Sprint goals achieved ahead of schedule
- Opportunity for bonus work or early next sprint start
- Capacity reallocation considerations
```

### Extended Sprint Closure
```markdown
## ⏰ Sprint Extension Management
- Critical work requires additional time
- Stakeholder approval for extension
- Impact analysis on subsequent sprints
```

### Emergency Sprint Closure
```markdown
## 🚨 Emergency Sprint Termination
- External factors requiring immediate closure
- Maximum value preservation
- Risk mitigation and damage control
```

## Post-Closure Activities

### Immediate (Day 1)
- Sprint metrics finalization
- Retrospective session
- Quick wins identification
- Next sprint kick-off preparation

### Short-term (Week 1)
- Detailed performance analysis
- Process improvement implementation
- Team development planning
- Stakeholder communication

### Long-term (Month 1)
- Trend analysis and pattern identification
- Strategic adjustments
- Framework optimization
- Knowledge sharing and documentation

This comprehensive sprint closure system ensures systematic completion of sprint cycles while maintaining project momentum and continuously improving team performance and delivery capabilities.