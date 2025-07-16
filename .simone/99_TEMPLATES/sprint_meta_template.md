---
sprint_id: "{SPRINT_ID}"
sprint_name: "{SPRINT_NAME}"
milestone_id: "{MILESTONE_ID}"
milestone_name: "{MILESTONE_NAME}"
sprint_number: {SPRINT_NUMBER}
created_date: "{CREATED_DATE}"
updated_date: "{UPDATED_DATE}"
start_date: "{START_DATE}"
end_date: "{END_DATE}"
status: "{STATUS}" # planning, active, review, completed, cancelled
team_capacity: {TEAM_CAPACITY} # person-hours
estimated_effort: {ESTIMATED_EFFORT} # hours
actual_effort: {ACTUAL_EFFORT} # hours
team_size: {TEAM_SIZE}
sprint_lead: "{SPRINT_LEAD}"
product_owner: "{PRODUCT_OWNER}"
stakeholders: ["{STAKEHOLDER_1}", "{STAKEHOLDER_2}"]
priority: "{PRIORITY}" # low, medium, high, critical
risk_level: "{RISK_LEVEL}" # low, medium, high
business_value: "{BUSINESS_VALUE}" # low, medium, high, critical
completion_percentage: {COMPLETION_PERCENTAGE}
velocity_target: {VELOCITY_TARGET} # tasks
actual_velocity: {ACTUAL_VELOCITY} # tasks
quality_gates:
  code_review_required: true
  testing_required: true
  documentation_required: true
  performance_testing_required: {PERFORMANCE_TESTING_REQUIRED}
  security_review_required: {SECURITY_REVIEW_REQUIRED}
dependencies: ["{DEPENDENCY_1}", "{DEPENDENCY_2}"]
blockers: ["{BLOCKER_1}", "{BLOCKER_2}"]
---

# {SPRINT_ID}: {SPRINT_NAME}

**Milestone**: {MILESTONE_ID} ({MILESTONE_NAME}) | **Status**: {STATUS}
**Duration**: {START_DATE} to {END_DATE} | **Team**: {TEAM_SIZE} developers
**Progress**: {COMPLETION_PERCENTAGE}% | **Velocity**: {ACTUAL_VELOCITY}/{VELOCITY_TARGET} tasks

## Sprint Overview

### Sprint Goals
{SPRINT_GOALS}

### Business Objectives
1. {BUSINESS_OBJECTIVE_1}
2. {BUSINESS_OBJECTIVE_2}
3. {BUSINESS_OBJECTIVE_3}

### Sprint Timeline
```mermaid
gantt
    title Sprint Timeline
    dateFormat  YYYY-MM-DD
    section Planning
    Sprint Planning     :done, planning, {START_DATE_MINUS_2}, 1d
    Task Assignment     :done, assign, after planning, 1d
    section Development
    Implementation      :active, dev, {START_DATE}, {DEVELOPMENT_DAYS}d
    Code Reviews        :active, review, after dev, {REVIEW_DAYS}d
    section Testing
    QA Testing          :test, after review, {TESTING_DAYS}d
    Bug Fixes           :fixes, after test, {BUGFIX-DAYS}d
    section Completion
    Sprint Review       :retro, after fixes, 1d
```

### Technical Objectives
1. {TECHNICAL_OBJECTIVE_1}
2. {TECHNICAL_OBJECTIVE_2}
3. {TECHNICAL_OBJECTIVE_3}

### Success Criteria
- [ ] {SUCCESS_CRITERIA_1}
- [ ] {SUCCESS_CRITERIA_2}
- [ ] {SUCCESS_CRITERIA_3}

## Sprint Context

### Milestone Context
- **Milestone**: {MILESTONE_ID} - {MILESTONE_NAME}
- **Milestone Progress**: {MILESTONE_PROGRESS}%
- **Milestone Target**: {MILESTONE_TARGET_DATE}
- **Sprint Contribution**: {MILESTONE_CONTRIBUTION}% of milestone scope

### Previous Sprint Context
- **Previous Sprint**: {PREVIOUS_SPRINT_ID}
- **Previous Velocity**: {PREVIOUS_VELOCITY} tasks
- **Lessons Learned**: {PREVIOUS_LESSONS_LEARNED}
- **Carried Over**: {CARRYOVER_ITEMS}

### Strategic Alignment
{STRATEGIC_ALIGNMENT}

## Team & Capacity

### Team Composition
- **Sprint Lead**: {SPRINT_LEAD}
- **Product Owner**: {PRODUCT_OWNER}
- **Developers**: {DEVELOPER_LIST}
- **Reviewers**: {REVIEWER_LIST}
- **Stakeholders**: {STAKEHOLDER_LIST}

### Capacity Planning
- **Total Team Capacity**: {TEAM_CAPACITY} person-hours
- **Available Capacity**: {AVAILABLE_CAPACITY} person-hours (accounting for meetings, holidays, etc.)
- **Sprint Commitment**: {ESTIMATED_EFFORT} hours ({CAPACITY_UTILIZATION}% utilization)
- **Buffer**: {CAPACITY_BUFFER} hours ({BUFFER_PERCENTAGE}%)

### Availability Notes
{AVAILABILITY_NOTES}

## Sprint Scope

### Included Features
1. **{FEATURE_1_NAME}** (Priority: {FEATURE_1_PRIORITY}, Effort: {FEATURE_1_EFFORT}h)
   - {FEATURE_1_DESCRIPTION}
   - **Business Value**: {FEATURE_1_BUSINESS_VALUE}
   - **Dependencies**: {FEATURE_1_DEPENDENCIES}

2. **{FEATURE_2_NAME}** (Priority: {FEATURE_2_PRIORITY}, Effort: {FEATURE_2_EFFORT}h)
   - {FEATURE_2_DESCRIPTION}
   - **Business Value**: {FEATURE_2_BUSINESS_VALUE}
   - **Dependencies**: {FEATURE_2_DEPENDENCIES}

### Excluded from Sprint
- {EXCLUDED_ITEM_1} - {EXCLUSION_REASON_1}
- {EXCLUDED_ITEM_2} - {EXCLUSION_REASON_2}
- {EXCLUDED_ITEM_3} - {EXCLUSION_REASON_3}

### Sprint Scope Rationale
{SCOPE_RATIONALE}

## Task Breakdown

### High Priority Tasks
- [ ] **{HIGH_TASK_1}** (Est: {HIGH_TASK_1_EFFORT}h) - {HIGH_TASK_1_ASSIGNEE}
- [ ] **{HIGH_TASK_2}** (Est: {HIGH_TASK_2_EFFORT}h) - {HIGH_TASK_2_ASSIGNEE}
- [ ] **{HIGH_TASK_3}** (Est: {HIGH_TASK_3_EFFORT}h) - {HIGH_TASK_3_ASSIGNEE}

### Medium Priority Tasks
- [ ] **{MEDIUM_TASK_1}** (Est: {MEDIUM_TASK_1_EFFORT}h) - {MEDIUM_TASK_1_ASSIGNEE}
- [ ] **{MEDIUM_TASK_2}** (Est: {MEDIUM_TASK_2_EFFORT}h) - {MEDIUM_TASK_2_ASSIGNEE}

### Low Priority Tasks (Stretch Goals)
- [ ] **{LOW_TASK_1}** (Est: {LOW_TASK_1_EFFORT}h) - {LOW_TASK_1_ASSIGNEE}
- [ ] **{LOW_TASK_2}** (Est: {LOW_TASK_2_EFFORT}h) - {LOW_TASK_2_ASSIGNEE}

### Task Summary
- **Total Tasks**: {TOTAL_TASKS}
- **High Priority**: {HIGH_PRIORITY_TASKS} tasks ({HIGH_PRIORITY_EFFORT}h)
- **Medium Priority**: {MEDIUM_PRIORITY_TASKS} tasks ({MEDIUM_PRIORITY_EFFORT}h)
- **Low Priority**: {LOW_PRIORITY_TASKS} tasks ({LOW_PRIORITY_EFFORT}h)

## Technical Considerations

### Architecture Impact
{ARCHITECTURE_IMPACT}

### Technical Debt
- **Technical Debt Items**: {TECH_DEBT_ITEMS}
- **Debt Reduction Goals**: {DEBT_REDUCTION_GOALS}
- **Technical Debt Budget**: {TECH_DEBT_BUDGET}% of sprint capacity

### Performance Considerations
{PERFORMANCE_CONSIDERATIONS}

### Security Considerations
{SECURITY_CONSIDERATIONS}

### Infrastructure Requirements
{INFRASTRUCTURE_REQUIREMENTS}

## Quality Standards

### Definition of Done
- [ ] Code implemented and tested
- [ ] Unit tests written and passing (min {MIN_UNIT_COVERAGE}% coverage)
- [ ] Integration tests written and passing
- [ ] Code reviewed and approved
- [ ] Documentation updated
- [ ] Performance requirements met
- [ ] Security requirements verified
- [ ] Acceptance criteria validated

### Quality Gates
- **Code Review**: {CODE_REVIEW_THRESHOLD}% of code must be reviewed
- **Test Coverage**: Minimum {MIN_TEST_COVERAGE}% overall coverage
- **Performance**: No regression beyond {PERFORMANCE_THRESHOLD}
- **Security**: Security review for sensitive changes
- **Documentation**: All public APIs documented

### Testing Strategy
- **Unit Testing**: {UNIT_TESTING_APPROACH}
- **Integration Testing**: {INTEGRATION_TESTING_APPROACH}
- **E2E Testing**: {E2E_TESTING_APPROACH}
- **Performance Testing**: {PERFORMANCE_TESTING_APPROACH}

## Dependencies & Risks

### Sprint Dependencies
#### Incoming Dependencies
- **{DEPENDENCY_1}**: {DEPENDENCY_1_DESCRIPTION} (Risk: {DEPENDENCY_1_RISK})
- **{DEPENDENCY_2}**: {DEPENDENCY_2_DESCRIPTION} (Risk: {DEPENDENCY_2_RISK})

#### Outgoing Dependencies
- **{OUTGOING_DEPENDENCY_1}**: {OUTGOING_DEPENDENCY_1_DESCRIPTION}
- **{OUTGOING_DEPENDENCY_2}**: {OUTGOING_DEPENDENCY_2_DESCRIPTION}

### Risk Assessment

#### High Risks
1. **{HIGH_RISK_1}** (Probability: {RISK_1_PROBABILITY}, Impact: {RISK_1_IMPACT})
   - **Description**: {RISK_1_DESCRIPTION}
   - **Mitigation**: {RISK_1_MITIGATION}
   - **Contingency**: {RISK_1_CONTINGENCY}

#### Medium Risks
1. **{MEDIUM_RISK_1}** (Probability: {RISK_2_PROBABILITY}, Impact: {RISK_2_IMPACT})
   - **Description**: {RISK_2_DESCRIPTION}
   - **Mitigation**: {RISK_2_MITIGATION}

### Mitigation Strategies
{MITIGATION_STRATEGIES}

## Sprint Events

### Sprint Planning
- **Date**: {SPRINT_PLANNING_DATE}
- **Duration**: {SPRINT_PLANNING_DURATION}
- **Participants**: {SPRINT_PLANNING_PARTICIPANTS}
- **Outcomes**: {SPRINT_PLANNING_OUTCOMES}

### Daily Standups
- **Schedule**: {STANDUP_SCHEDULE}
- **Format**: {STANDUP_FORMAT}
- **Focus Areas**: {STANDUP_FOCUS_AREAS}

### Sprint Review
- **Date**: {SPRINT_REVIEW_DATE}
- **Duration**: {SPRINT_REVIEW_DURATION}
- **Stakeholders**: {SPRINT_REVIEW_STAKEHOLDERS}
- **Demo Scope**: {DEMO_SCOPE}

### Sprint Retrospective
- **Date**: {RETROSPECTIVE_DATE}
- **Format**: {RETROSPECTIVE_FORMAT}
- **Focus Areas**: {RETROSPECTIVE_FOCUS_AREAS}

## Progress Tracking

### Daily Progress
{DAILY_PROGRESS_PLACEHOLDER}

### Weekly Milestones
- **Week 1**: {WEEK_1_MILESTONE}
- **Week 2**: {WEEK_2_MILESTONE}
- **Week 3**: {WEEK_3_MILESTONE} (if applicable)

### Velocity Tracking
- **Planned Velocity**: {VELOCITY_TARGET} tasks
- **Current Velocity**: {ACTUAL_VELOCITY} tasks
- **Velocity Trend**: {VELOCITY_TREND}
- **Burn-down Rate**: {BURNDOWN_RATE}

### Key Metrics
- **Story Points Completed**: {STORY_POINTS_COMPLETED}/{STORY_POINTS_PLANNED}
- **Tasks Completed**: {TASKS_COMPLETED}/{TOTAL_TASKS}
- **Effort Spent**: {ACTUAL_EFFORT}h/{ESTIMATED_EFFORT}h
- **Quality Score**: {QUALITY_SCORE}/10

## Communication Plan

### Stakeholder Updates
- **Frequency**: {UPDATE_FREQUENCY}
- **Format**: {UPDATE_FORMAT}
- **Recipients**: {UPDATE_RECIPIENTS}
- **Content**: {UPDATE_CONTENT}

### Team Communication
- **Daily Standups**: {STANDUP_SCHEDULE}
- **Slack Channel**: {SLACK_CHANNEL}
- **Emergency Escalation**: {ESCALATION_PROCESS}

### External Communication
{EXTERNAL_COMMUNICATION_PLAN}

## Success Metrics

### Primary Metrics
- **Velocity Achievement**: Target {VELOCITY_TARGET} tasks
- **Quality**: Maintain {QUALITY_THRESHOLD} quality score
- **Timeline**: Complete by {END_DATE}
- **Scope**: Deliver {SCOPE_PERCENTAGE}% of planned scope

### Secondary Metrics
- **Team Satisfaction**: {TEAM_SATISFACTION_TARGET}/10
- **Stakeholder Satisfaction**: {STAKEHOLDER_SATISFACTION_TARGET}/10
- **Technical Debt**: Reduce by {TECH_DEBT_REDUCTION}%
- **Performance**: Maintain {PERFORMANCE_TARGET}

### Leading Indicators
- Daily task completion rate
- Code review completion time
- Test coverage trend
- Blocker resolution time

## Sprint Retrospective (Post-Sprint)

### What Went Well
{RETROSPECTIVE_WENT_WELL_PLACEHOLDER}

### What Could Be Improved
{RETROSPECTIVE_IMPROVEMENTS_PLACEHOLDER}

### Action Items for Next Sprint
{RETROSPECTIVE_ACTIONS_PLACEHOLDER}

### Lessons Learned
{LESSONS_LEARNED_PLACEHOLDER}

## Related Documents

### Requirements
- [Milestone PRD](../02_REQUIREMENTS/{MILESTONE_ID}/{MILESTONE_ID}_PRD.md)
- [Technical Specs](../02_REQUIREMENTS/{MILESTONE_ID}/{MILESTONE_ID}_SPECS.md)

### Architecture
- [Architecture Documentation](../01_PROJECT_DOCS/ARCHITECTURE.md)
- [Related ADRs](../05_ARCHITECTURAL_DECISIONS/)

### Project Context
- [Project Manifest](../00_PROJECT_MANIFEST.md)
- [Previous Sprint]({PREVIOUS_SPRINT_ID}_sprint_meta.md)
- [Next Sprint]({NEXT_SPRINT_ID}_sprint_meta.md)

### Tasks
{TASK_LIST_LINKS}

---

## Sprint Metadata

### Creation Info
- **Created**: {CREATED_DATE}
- **Creator**: {CREATOR}
- **Template Version**: {TEMPLATE_VERSION}

### Progress Tracking
- **Last Updated**: {UPDATED_DATE}
- **Days Remaining**: {DAYS_REMAINING}
- **Completion Rate**: {COMPLETION_RATE}%

### Quality Metrics
- **Risk Score**: {RISK_SCORE}
- **Complexity Score**: {COMPLEXITY_SCORE}
- **Business Value Score**: {BUSINESS_VALUE_SCORE}

---

**Status**: {STATUS} | **Last Updated**: {UPDATED_DATE} | **Next Review**: {NEXT_REVIEW_DATE}