---
milestone_id: "{MILESTONE_ID}"
milestone_name: "{MILESTONE_NAME}"
milestone_version: "{MILESTONE_VERSION}"
created_date: "{CREATED_DATE}"
updated_date: "{UPDATED_DATE}"
start_date: "{START_DATE}"
target_date: "{TARGET_DATE}"
actual_completion_date: "{ACTUAL_COMPLETION_DATE}"
status: "{STATUS}" # planning, active, testing, review, completed, cancelled, on_hold
priority: "{PRIORITY}" # low, medium, high, critical
business_value: "{BUSINESS_VALUE}" # low, medium, high, critical
technical_complexity: "{TECHNICAL_COMPLEXITY}" # simple, medium, complex, very_complex
estimated_effort: {ESTIMATED_EFFORT} # person-weeks
actual_effort: {ACTUAL_EFFORT} # person-weeks
team_size: {TEAM_SIZE}
milestone_lead: "{MILESTONE_LEAD}"
product_owner: "{PRODUCT_OWNER}"
technical_lead: "{TECHNICAL_LEAD}"
stakeholders: ["{STAKEHOLDER_1}", "{STAKEHOLDER_2}"]
completion_percentage: {COMPLETION_PERCENTAGE}
quality_score: {QUALITY_SCORE} # 1-10
risk_level: "{RISK_LEVEL}" # low, medium, high, critical
dependencies: ["{DEPENDENCY_1}", "{DEPENDENCY_2}"]
blockers: ["{BLOCKER_1}", "{BLOCKER_2}"]
success_metrics:
  primary_metric: "{PRIMARY_METRIC}"
  secondary_metrics: ["{SECONDARY_METRIC_1}", "{SECONDARY_METRIC_2}"]
  target_values: ["{TARGET_VALUE_1}", "{TARGET_VALUE_2}"]
architecture_impact: "{ARCHITECTURE_IMPACT}" # none, minor, moderate, major
---

# {MILESTONE_ID}: {MILESTONE_NAME}

**Status**: {STATUS} | **Priority**: {PRIORITY} | **Completion**: {COMPLETION_PERCENTAGE}%
**Target Date**: {TARGET_DATE} | **Business Value**: {BUSINESS_VALUE} | **Risk**: {RISK_LEVEL}

## Executive Summary

### Milestone Vision
{MILESTONE_VISION}

### Business Objectives
1. {BUSINESS_OBJECTIVE_1}
2. {BUSINESS_OBJECTIVE_2}
3. {BUSINESS_OBJECTIVE_3}

### Technical Objectives
1. {TECHNICAL_OBJECTIVE_1}
2. {TECHNICAL_OBJECTIVE_2}
3. {TECHNICAL_OBJECTIVE_3}

### Success Criteria
- [ ] {SUCCESS_CRITERIA_1}
- [ ] {SUCCESS_CRITERIA_2}
- [ ] {SUCCESS_CRITERIA_3}
- [ ] {SUCCESS_CRITERIA_4}

## Strategic Context

### Business Context
{BUSINESS_CONTEXT}

### Market Context
{MARKET_CONTEXT}

### Technical Context
{TECHNICAL_CONTEXT}

### User Impact
{USER_IMPACT}

### Competitive Advantage
{COMPETITIVE_ADVANTAGE}

## Milestone Scope

### Included Features
#### Core Features (Must Have)
1. **{CORE_FEATURE_1}** (Priority: Critical, Effort: {CORE_FEATURE_1_EFFORT}w)
   - **Description**: {CORE_FEATURE_1_DESCRIPTION}
   - **Business Value**: {CORE_FEATURE_1_VALUE}
   - **Acceptance Criteria**: {CORE_FEATURE_1_AC}

2. **{CORE_FEATURE_2}** (Priority: Critical, Effort: {CORE_FEATURE_2_EFFORT}w)
   - **Description**: {CORE_FEATURE_2_DESCRIPTION}
   - **Business Value**: {CORE_FEATURE_2_VALUE}
   - **Acceptance Criteria**: {CORE_FEATURE_2_AC}

#### Important Features (Should Have)
1. **{IMPORTANT_FEATURE_1}** (Priority: High, Effort: {IMPORTANT_FEATURE_1_EFFORT}w)
   - **Description**: {IMPORTANT_FEATURE_1_DESCRIPTION}
   - **Business Value**: {IMPORTANT_FEATURE_1_VALUE}

2. **{IMPORTANT_FEATURE_2}** (Priority: High, Effort: {IMPORTANT_FEATURE_2_EFFORT}w)
   - **Description**: {IMPORTANT_FEATURE_2_DESCRIPTION}
   - **Business Value**: {IMPORTANT_FEATURE_2_VALUE}

#### Nice-to-Have Features (Could Have)
1. **{NICE_FEATURE_1}** (Priority: Medium, Effort: {NICE_FEATURE_1_EFFORT}w)
   - **Description**: {NICE_FEATURE_1_DESCRIPTION}
   - **Business Value**: {NICE_FEATURE_1_VALUE}

### Excluded from Milestone
- **{EXCLUDED_FEATURE_1}** - {EXCLUSION_REASON_1}
- **{EXCLUDED_FEATURE_2}** - {EXCLUSION_REASON_2}
- **{EXCLUDED_FEATURE_3}** - {EXCLUSION_REASON_3}

### Scope Rationale
{SCOPE_RATIONALE}

## Sprint Breakdown

### Sprint Planning Overview
- **Total Sprints**: {TOTAL_SPRINTS}
- **Sprint Duration**: {SPRINT_DURATION} weeks
- **Total Duration**: {TOTAL_DURATION} weeks

### Sprint Breakdown
#### Sprint 1: {SPRINT_1_NAME}
- **Duration**: {SPRINT_1_DURATION}
- **Focus**: {SPRINT_1_FOCUS}
- **Key Deliverables**: {SPRINT_1_DELIVERABLES}
- **Success Criteria**: {SPRINT_1_SUCCESS_CRITERIA}

#### Sprint 2: {SPRINT_2_NAME}
- **Duration**: {SPRINT_2_DURATION}
- **Focus**: {SPRINT_2_FOCUS}
- **Key Deliverables**: {SPRINT_2_DELIVERABLES}
- **Success Criteria**: {SPRINT_2_SUCCESS_CRITERIA}

#### Sprint 3: {SPRINT_3_NAME}
- **Duration**: {SPRINT_3_DURATION}
- **Focus**: {SPRINT_3_FOCUS}
- **Key Deliverables**: {SPRINT_3_DELIVERABLES}
- **Success Criteria**: {SPRINT_3_SUCCESS_CRITERIA}

### Sprint Dependencies
{SPRINT_DEPENDENCIES}

## Technical Architecture

### Architecture Impact: {ARCHITECTURE_IMPACT}

### System Changes
- **New Components**: {NEW_COMPONENTS}
- **Modified Components**: {MODIFIED_COMPONENTS}
- **Deprecated Components**: {DEPRECATED_COMPONENTS}
- **Infrastructure Changes**: {INFRASTRUCTURE_CHANGES}

### Technology Decisions
{TECHNOLOGY_DECISIONS}

### Performance Impact
- **Performance Requirements**: {PERFORMANCE_REQUIREMENTS}
- **Scalability Considerations**: {SCALABILITY_CONSIDERATIONS}
- **Resource Requirements**: {RESOURCE_REQUIREMENTS}

### Security Considerations
{SECURITY_CONSIDERATIONS}

### Integration Points
{INTEGRATION_POINTS}

## Team & Resources

### Team Composition
- **Milestone Lead**: {MILESTONE_LEAD}
- **Product Owner**: {PRODUCT_OWNER}
- **Technical Lead**: {TECHNICAL_LEAD}
- **Development Team**: {DEVELOPMENT_TEAM}
- **QA Team**: {QA_TEAM}
- **DevOps**: {DEVOPS_TEAM}
- **Stakeholders**: {STAKEHOLDER_LIST}

### Resource Planning
- **Total Effort**: {ESTIMATED_EFFORT} person-weeks
- **Team Capacity**: {TEAM_CAPACITY} person-weeks
- **Capacity Utilization**: {CAPACITY_UTILIZATION}%
- **Buffer**: {BUFFER_PERCENTAGE}%

### Skill Requirements
- **Required Skills**: {REQUIRED_SKILLS}
- **Skill Gaps**: {SKILL_GAPS}
- **Training Needs**: {TRAINING_NEEDS}

### External Dependencies
{EXTERNAL_DEPENDENCIES}

## Quality Standards

### Definition of Done
- [ ] All features implemented according to specifications
- [ ] Comprehensive test coverage (min {MIN_TEST_COVERAGE}%)
- [ ] Performance requirements met
- [ ] Security requirements verified
- [ ] Documentation completed
- [ ] Code reviewed and approved
- [ ] User acceptance testing passed
- [ ] Deployment scripts validated

### Quality Gates
- **Code Quality**: {CODE_QUALITY_THRESHOLD}
- **Test Coverage**: Minimum {MIN_TEST_COVERAGE}%
- **Performance**: No regression beyond {PERFORMANCE_THRESHOLD}
- **Security**: Security audit completed
- **Documentation**: All features documented

### Testing Strategy
- **Unit Testing**: {UNIT_TESTING_STRATEGY}
- **Integration Testing**: {INTEGRATION_TESTING_STRATEGY}
- **E2E Testing**: {E2E_TESTING_STRATEGY}
- **Performance Testing**: {PERFORMANCE_TESTING_STRATEGY}
- **Security Testing**: {SECURITY_TESTING_STRATEGY}
- **User Acceptance Testing**: {UAT_STRATEGY}

## Risk Management

### Risk Assessment: {RISK_LEVEL}

#### High Risks
1. **{HIGH_RISK_1}** (Probability: {RISK_1_PROBABILITY}, Impact: {RISK_1_IMPACT})
   - **Description**: {RISK_1_DESCRIPTION}
   - **Mitigation Strategy**: {RISK_1_MITIGATION}
   - **Contingency Plan**: {RISK_1_CONTINGENCY}
   - **Owner**: {RISK_1_OWNER}

2. **{HIGH_RISK_2}** (Probability: {RISK_2_PROBABILITY}, Impact: {RISK_2_IMPACT})
   - **Description**: {RISK_2_DESCRIPTION}
   - **Mitigation Strategy**: {RISK_2_MITIGATION}
   - **Contingency Plan**: {RISK_2_CONTINGENCY}
   - **Owner**: {RISK_2_OWNER}

#### Medium Risks
1. **{MEDIUM_RISK_1}** (Probability: {RISK_3_PROBABILITY}, Impact: {RISK_3_IMPACT})
   - **Description**: {RISK_3_DESCRIPTION}
   - **Mitigation Strategy**: {RISK_3_MITIGATION}
   - **Owner**: {RISK_3_OWNER}

### Risk Monitoring
{RISK_MONITORING_PLAN}

### Escalation Procedures
{ESCALATION_PROCEDURES}

## Dependencies & Constraints

### Internal Dependencies
- **{INTERNAL_DEPENDENCY_1}**: {INTERNAL_DEPENDENCY_1_DESCRIPTION}
- **{INTERNAL_DEPENDENCY_2}**: {INTERNAL_DEPENDENCY_2_DESCRIPTION}

### External Dependencies
- **{EXTERNAL_DEPENDENCY_1}**: {EXTERNAL_DEPENDENCY_1_DESCRIPTION}
- **{EXTERNAL_DEPENDENCY_2}**: {EXTERNAL_DEPENDENCY_2_DESCRIPTION}

### Technical Constraints
- {TECHNICAL_CONSTRAINT_1}
- {TECHNICAL_CONSTRAINT_2}
- {TECHNICAL_CONSTRAINT_3}

### Business Constraints
- {BUSINESS_CONSTRAINT_1}
- {BUSINESS_CONSTRAINT_2}
- {BUSINESS_CONSTRAINT_3}

### Timeline Constraints
{TIMELINE_CONSTRAINTS}

## Success Metrics & KPIs

### Primary Success Metrics
1. **{PRIMARY_METRIC_1}**: Target {PRIMARY_TARGET_1}
   - **Measurement Method**: {PRIMARY_MEASUREMENT_1}
   - **Baseline**: {PRIMARY_BASELINE_1}

2. **{PRIMARY_METRIC_2}**: Target {PRIMARY_TARGET_2}
   - **Measurement Method**: {PRIMARY_MEASUREMENT_2}
   - **Baseline**: {PRIMARY_BASELINE_2}

### Secondary Success Metrics
1. **{SECONDARY_METRIC_1}**: Target {SECONDARY_TARGET_1}
2. **{SECONDARY_METRIC_2}**: Target {SECONDARY_TARGET_2}
3. **{SECONDARY_METRIC_3}**: Target {SECONDARY_TARGET_3}

### Leading Indicators
- {LEADING_INDICATOR_1}
- {LEADING_INDICATOR_2}
- {LEADING_INDICATOR_3}

### Lagging Indicators
- {LAGGING_INDICATOR_1}
- {LAGGING_INDICATOR_2}
- {LAGGING_INDICATOR_3}

## Communication Plan

### Stakeholder Communication
- **Frequency**: {STAKEHOLDER_UPDATE_FREQUENCY}
- **Format**: {STAKEHOLDER_UPDATE_FORMAT}
- **Content**: {STAKEHOLDER_UPDATE_CONTENT}
- **Recipients**: {STAKEHOLDER_RECIPIENTS}

### Team Communication
- **Daily Standups**: {STANDUP_SCHEDULE}
- **Sprint Reviews**: {SPRINT_REVIEW_SCHEDULE}
- **Milestone Reviews**: {MILESTONE_REVIEW_SCHEDULE}

### Executive Communication
- **Monthly Updates**: {EXECUTIVE_UPDATE_SCHEDULE}
- **Escalation Process**: {EXECUTIVE_ESCALATION}
- **Decision Points**: {DECISION_POINTS}

### External Communication
{EXTERNAL_COMMUNICATION_PLAN}

## Progress Tracking

### Milestone Phases
#### Phase 1: Planning & Setup ({PHASE_1_DURATION})
- [ ] Requirements finalized
- [ ] Architecture approved
- [ ] Team onboarded
- [ ] Infrastructure prepared

#### Phase 2: Core Development ({PHASE_2_DURATION})
- [ ] Core features implemented
- [ ] Integration testing completed
- [ ] Performance benchmarks met

#### Phase 3: Testing & Refinement ({PHASE_3_DURATION})
- [ ] User acceptance testing completed
- [ ] Bug fixes implemented
- [ ] Documentation completed

#### Phase 4: Launch Preparation ({PHASE_4_DURATION})
- [ ] Deployment scripts validated
- [ ] Monitoring configured
- [ ] Launch procedures tested

### Progress Metrics
- **Overall Progress**: {COMPLETION_PERCENTAGE}%
- **Sprint Velocity**: {AVERAGE_VELOCITY} tasks/sprint
- **Quality Score**: {QUALITY_SCORE}/10
- **Risk Score**: {RISK_SCORE}/10

### Milestone Checkpoints
- **25% Checkpoint**: {CHECKPOINT_25_DATE} - {CHECKPOINT_25_CRITERIA}
- **50% Checkpoint**: {CHECKPOINT_50_DATE} - {CHECKPOINT_50_CRITERIA}
- **75% Checkpoint**: {CHECKPOINT_75_DATE} - {CHECKPOINT_75_CRITERIA}
- **100% Checkpoint**: {CHECKPOINT_100_DATE} - {CHECKPOINT_100_CRITERIA}

## Deployment Strategy

### Deployment Approach
{DEPLOYMENT_APPROACH}

### Environment Promotion
- **Development**: {DEV_DEPLOYMENT_STRATEGY}
- **Staging**: {STAGING_DEPLOYMENT_STRATEGY}
- **Production**: {PROD_DEPLOYMENT_STRATEGY}

### Rollback Plan
{ROLLBACK_PLAN}

### Monitoring & Alerting
{MONITORING_ALERTING_PLAN}

### Post-Deployment Verification
{POST_DEPLOYMENT_VERIFICATION}

## Post-Milestone Activities

### Launch Activities
- [ ] Production deployment
- [ ] User training
- [ ] Documentation publishing
- [ ] Stakeholder communication

### Success Measurement
- [ ] Metrics collection setup
- [ ] Baseline measurements
- [ ] Success criteria validation
- [ ] User feedback collection

### Knowledge Transfer
- [ ] Technical documentation handover
- [ ] Team knowledge sharing sessions
- [ ] Lessons learned documentation
- [ ] Best practices capture

### Continuous Improvement
{CONTINUOUS_IMPROVEMENT_PLAN}

## Related Documents

### Requirements
- [Milestone PRD]({MILESTONE_ID}_PRD.md)
- [Technical Specifications]({MILESTONE_ID}_SPECS.md)
- [User Stories]({MILESTONE_ID}_USER_STORIES.md)

### Architecture
- [Architecture Documentation](../01_PROJECT_DOCS/ARCHITECTURE.md)
- [System Design]({MILESTONE_ID}_SYSTEM_DESIGN.md)
- [API Documentation]({MILESTONE_ID}_API_DOCS.md)

### Project Management
- [Project Manifest](../00_PROJECT_MANIFEST.md)
- [Sprint Plans](../03_SPRINTS/)
- [Risk Register]({MILESTONE_ID}_RISK_REGISTER.md)

### Quality Assurance
- [Test Plan]({MILESTONE_ID}_TEST_PLAN.md)
- [Quality Checklist]({MILESTONE_ID}_QUALITY_CHECKLIST.md)
- [Performance Requirements]({MILESTONE_ID}_PERFORMANCE.md)

## Milestone Retrospective (Post-Completion)

### Achievements
{ACHIEVEMENTS_PLACEHOLDER}

### Challenges Faced
{CHALLENGES_PLACEHOLDER}

### Lessons Learned
{LESSONS_LEARNED_PLACEHOLDER}

### Process Improvements
{PROCESS_IMPROVEMENTS_PLACEHOLDER}

### Recommendations for Future Milestones
{FUTURE_RECOMMENDATIONS_PLACEHOLDER}

---

## Milestone Metadata

### Creation Info
- **Created**: {CREATED_DATE}
- **Creator**: {CREATOR}
- **Template Version**: {TEMPLATE_VERSION}

### Progress Tracking
- **Last Updated**: {UPDATED_DATE}
- **Days Remaining**: {DAYS_REMAINING}
- **Completion Rate**: {COMPLETION_RATE}%

### Quality Metrics
- **Business Value Score**: {BUSINESS_VALUE_SCORE}
- **Technical Complexity Score**: {COMPLEXITY_SCORE}
- **Risk Score**: {RISK_SCORE}
- **Team Satisfaction Score**: {TEAM_SATISFACTION_SCORE}

---

**Status**: {STATUS} | **Last Updated**: {UPDATED_DATE} | **Next Review**: {NEXT_REVIEW_DATE}