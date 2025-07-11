---
debt_id: "TD_{DEBT_ID}"
title: "{DEBT_TITLE}"
category: "{CATEGORY}" # code_quality, architecture, security, performance, documentation, testing
severity: "{SEVERITY}" # critical, high, medium, low
created_date: "{CREATED_DATE}"
discovered_by: "{DISCOVERER_NAME}"
discovered_in: "{SOURCE_CONTEXT}" # TASK_ID, code_review, bug_investigation, etc.
status: "{STATUS}" # active, planned, in_progress, resolved, wont_fix
resolution_target: "{TARGET_DATE}" # YYYY-MM-DD when resolution is planned
estimated_effort: "{EFFORT_HOURS}" # hours
actual_effort: "{ACTUAL_HOURS}" # hours (filled when resolved)
business_impact: "{BUSINESS_IMPACT_DESCRIPTION}"
technical_impact: "{TECHNICAL_IMPACT_DESCRIPTION}"
affected_components: ["{COMPONENT_1}", "{COMPONENT_2}"]
related_debt: ["{RELATED_DEBT_ID_1}", "{RELATED_DEBT_ID_2}"]
blocking_tasks: ["{BLOCKED_TASK_ID_1}", "{BLOCKED_TASK_ID_2}"]
dependencies: ["{DEPENDENCY_1}", "{DEPENDENCY_2}"]
tags: ["{TAG_1}", "{TAG_2}", "{TAG_3}"]

# Risk Assessment
likelihood: "{LIKELIHOOD}" # very_low, low, medium, high, very_high
impact_if_unaddressed: "{IMPACT_LEVEL}" # minimal, low, medium, high, severe
risk_score: "{CALCULATED_RISK}" # likelihood × impact (1-25)

# Resolution Tracking
resolution_approach: "{PLANNED_APPROACH}"
resolution_assignee: "{ASSIGNEE_NAME}"
resolution_sprint: "{SPRINT_ID}"
resolution_milestone: "{MILESTONE_ID}"
---

# TD_{DEBT_ID}: {DEBT_TITLE}

**Category**: {CATEGORY} | **Severity**: {SEVERITY} | **Status**: {STATUS}
**Effort**: {ESTIMATED_EFFORT}h | **Target**: {RESOLUTION_TARGET} | **Risk**: {RISK_SCORE}

## Problem Description

### Issue Summary
{DETAILED_DESCRIPTION_OF_THE_DEBT_ISSUE}

### Context and Discovery
- **Discovered During**: {DISCOVERY_CONTEXT}
- **Location**: {FILE_PATHS_OR_COMPONENTS_AFFECTED}
- **Root Cause**: {WHY_THIS_DEBT_EXISTS}
- **Current Workarounds**: {EXISTING_MITIGATION_STRATEGIES}

### Evidence
{SPECIFIC_EXAMPLES_OR_CODE_SNIPPETS_DEMONSTRATING_THE_ISSUE}

```{LANGUAGE}
{CODE_EXAMPLE_SHOWING_THE_PROBLEM}
```

## Impact Analysis

### Development Velocity Impact
- **Immediate Effect**: {HOW_THIS_AFFECTS_CURRENT_WORK}
- **Short-term (1-3 sprints)**: {PROJECTED_IMPACT_OVER_NEXT_FEW_SPRINTS}
- **Long-term (6+ months)**: {CUMULATIVE_EFFECT_IF_UNADDRESSED}
- **Scaling Factor**: {HOW_IMPACT_CHANGES_WITH_GROWTH}

### Maintenance Cost Analysis
- **Time Overhead**: {ADDITIONAL_TIME_FOR_RELATED_CHANGES}
- **Cognitive Load**: {MENTAL_EFFORT_TO_WORK_AROUND_DEBT}
- **Error Probability**: {INCREASED_LIKELIHOOD_OF_BUGS}
- **Knowledge Dependency**: {IMPACT_ON_TEAM_ONBOARDING}

### Business Impact
- **User Experience**: {EFFECT_ON_END_USERS}
- **Performance**: {IMPACT_ON_SYSTEM_PERFORMANCE}
- **Security**: {SECURITY_IMPLICATIONS}
- **Compliance**: {REGULATORY_OR_POLICY_IMPLICATIONS}
- **Competitive Position**: {EFFECT_ON_BUSINESS_COMPETITIVENESS}

### Technical Impact
- **Code Quality**: {EFFECT_ON_CODEBASE_MAINTAINABILITY}
- **Architecture**: {IMPACT_ON_SYSTEM_DESIGN}
- **Testing**: {EFFECT_ON_TEST_COVERAGE_OR_RELIABILITY}
- **Deployment**: {IMPACT_ON_DEPLOYMENT_PROCESS}
- **Monitoring**: {EFFECT_ON_OBSERVABILITY}

## Risk Assessment

### Risk Matrix
```mermaid
graph TD
    A[Risk Assessment] --> B[Likelihood: {LIKELIHOOD}]
    A --> C[Impact: {IMPACT_IF_UNADDRESSED}]
    B --> D[Risk Score: {RISK_SCORE}]
    C --> D
    D --> E{Action Required?}
    E -->|High Risk| F[Immediate Planning]
    E -->|Medium Risk| G[Sprint Planning]
    E -->|Low Risk| H[Backlog]
```

### Specific Risks
1. **{RISK_1_TITLE}** (Probability: {RISK_1_PROBABILITY}, Impact: {RISK_1_IMPACT})
   - **Description**: {RISK_1_DESCRIPTION}
   - **Triggers**: {WHAT_COULD_CAUSE_THIS_RISK}
   - **Mitigation**: {HOW_TO_REDUCE_THIS_RISK}

2. **{RISK_2_TITLE}** (Probability: {RISK_2_PROBABILITY}, Impact: {RISK_2_IMPACT})
   - **Description**: {RISK_2_DESCRIPTION}
   - **Triggers**: {WHAT_COULD_CAUSE_THIS_RISK}
   - **Mitigation**: {HOW_TO_REDUCE_THIS_RISK}

### Escalation Criteria
- **Immediate escalation if**: {CONDITIONS_FOR_URGENT_ACTION}
- **Sprint planning if**: {CONDITIONS_FOR_NEXT_SPRINT_INCLUSION}
- **Milestone planning if**: {CONDITIONS_FOR_LONGER_TERM_PLANNING}

## Resolution Planning

### Proposed Solution
{DETAILED_DESCRIPTION_OF_PROPOSED_RESOLUTION}

### Resolution Approach
- **Strategy**: {OVERALL_APPROACH} # big_bang, incremental, wrapping, documentation
- **Phases**: {BREAKDOWN_OF_RESOLUTION_PHASES}
- **Dependencies**: {WHAT_NEEDS_TO_BE_DONE_FIRST}
- **Risks**: {RISKS_ASSOCIATED_WITH_RESOLUTION}

### Implementation Plan
```mermaid
flowchart TD
    A[Start Resolution] --> B{Dependencies Met?}
    B -->|No| C[Address Dependencies]
    B -->|Yes| D[Phase 1: {PHASE_1_NAME}]
    C --> B
    D --> E[Phase 2: {PHASE_2_NAME}]
    E --> F[Phase 3: {PHASE_3_NAME}]
    F --> G[Validation & Testing]
    G --> H[Resolution Complete]
```

### Resolution Tasks
#### Phase 1: {PHASE_1_NAME}
- [ ] **{TASK_1_1}** (Est: {TASK_1_1_EFFORT}h)
  - **Description**: {TASK_1_1_DESCRIPTION}
  - **Acceptance**: {TASK_1_1_COMPLETION_CRITERIA}
  - **Owner**: {TASK_1_1_ASSIGNEE}

- [ ] **{TASK_1_2}** (Est: {TASK_1_2_EFFORT}h)
  - **Description**: {TASK_1_2_DESCRIPTION}
  - **Acceptance**: {TASK_1_2_COMPLETION_CRITERIA}
  - **Owner**: {TASK_1_2_ASSIGNEE}

#### Phase 2: {PHASE_2_NAME}
- [ ] **{TASK_2_1}** (Est: {TASK_2_1_EFFORT}h)
  - **Description**: {TASK_2_1_DESCRIPTION}
  - **Acceptance**: {TASK_2_1_COMPLETION_CRITERIA}
  - **Owner**: {TASK_2_1_ASSIGNEE}

#### Phase 3: {PHASE_3_NAME}
- [ ] **{TASK_3_1}** (Est: {TASK_3_1_EFFORT}h)
  - **Description**: {TASK_3_1_DESCRIPTION}
  - **Acceptance**: {TASK_3_1_COMPLETION_CRITERIA}
  - **Owner**: {TASK_3_1_ASSIGNEE}

### Effort Estimation
- **Investigation**: {INVESTIGATION_HOURS}h
- **Implementation**: {IMPLEMENTATION_HOURS}h
- **Testing**: {TESTING_HOURS}h
- **Documentation**: {DOCUMENTATION_HOURS}h
- **Review & Integration**: {REVIEW_HOURS}h
- **Buffer (20%)**: {BUFFER_HOURS}h
- **Total Estimated**: {TOTAL_ESTIMATED_HOURS}h

### Success Criteria
- [ ] **{SUCCESS_CRITERIA_1}**
- [ ] **{SUCCESS_CRITERIA_2}**
- [ ] **{SUCCESS_CRITERIA_3}**
- [ ] **Performance benchmarks maintained or improved**
- [ ] No regression in existing functionality**
- [ ] **Documentation updated to reflect changes**

## Alternative Solutions

### Option A: {ALTERNATIVE_1_NAME}
- **Approach**: {ALTERNATIVE_1_DESCRIPTION}
- **Pros**: {ALTERNATIVE_1_ADVANTAGES}
- **Cons**: {ALTERNATIVE_1_DISADVANTAGES}
- **Effort**: {ALTERNATIVE_1_EFFORT}h
- **Risk**: {ALTERNATIVE_1_RISK_LEVEL}

### Option B: {ALTERNATIVE_2_NAME}
- **Approach**: {ALTERNATIVE_2_DESCRIPTION}
- **Pros**: {ALTERNATIVE_2_ADVANTAGES}
- **Cons**: {ALTERNATIVE_2_DISADVANTAGES}
- **Effort**: {ALTERNATIVE_2_EFFORT}h
- **Risk**: {ALTERNATIVE_2_RISK_LEVEL}

### Do Nothing Option
- **Cost of Inaction**: {CUMULATIVE_COST_IF_NOT_ADDRESSED}
- **Breaking Point**: {WHEN_THIS_BECOMES_CRITICAL}
- **Workaround Viability**: {SUSTAINABILITY_OF_CURRENT_WORKAROUNDS}

## Dependencies and Blockers

### Prerequisites
- **Technical Dependencies**: {TECHNICAL_REQUIREMENTS}
- **Resource Dependencies**: {REQUIRED_TEAM_MEMBERS_OR_SKILLS}
- **External Dependencies**: {THIRD_PARTY_OR_VENDOR_REQUIREMENTS}
- **Business Dependencies**: {BUSINESS_DECISIONS_OR_APPROVALS_NEEDED}

### Blocking Items
- **Blocks Tasks**: {TASKS_THAT_CANNOT_PROCEED}
- **Blocks Features**: {FEATURES_IMPACTED_BY_THIS_DEBT}
- **Blocks Performance**: {PERFORMANCE_GOALS_PREVENTED}
- **Blocks Scaling**: {GROWTH_LIMITATIONS_IMPOSED}

### Related Work
- **Related Debt Items**: {LINKS_TO_RELATED_DEBT}
- **Related ADRs**: {ARCHITECTURAL_DECISIONS_INVOLVED}
- **Related Tasks**: {TASKS_THAT_CONTRIBUTE_TO_OR_DEPEND_ON_THIS}
- **Related Requirements**: {BUSINESS_REQUIREMENTS_AFFECTED}

## Monitoring and Validation

### Detection Methods
- **Automated Detection**: {HOW_TO_AUTOMATICALLY_DETECT_THIS_ISSUE}
- **Manual Indicators**: {SYMPTOMS_THAT_INDICATE_THE_PROBLEM}
- **Metrics to Track**: {QUANTITATIVE_MEASURES_OF_THE_ISSUE}
- **Performance Benchmarks**: {BASELINE_MEASUREMENTS}

### Validation Approach
- **Pre-Resolution Baseline**: {MEASUREMENTS_BEFORE_FIXING}
- **Resolution Verification**: {HOW_TO_VERIFY_FIX_WORKS}
- **Regression Detection**: {HOW_TO_DETECT_IF_ISSUE_RETURNS}
- **Long-term Monitoring**: {ONGOING_MONITORING_STRATEGY}

### Testing Strategy
- **Unit Tests**: {UNIT_TESTS_TO_VERIFY_RESOLUTION}
- **Integration Tests**: {INTEGRATION_TESTS_REQUIRED}
- **Performance Tests**: {PERFORMANCE_VALIDATION_NEEDED}
- **Manual Testing**: {MANUAL_VERIFICATION_STEPS}

## Communication Plan

### Stakeholder Notification
- **Technical Team**: {WHEN_AND_HOW_TO_NOTIFY_DEVELOPERS}
- **Product Management**: {BUSINESS_IMPACT_COMMUNICATION}
- **Operations**: {OPERATIONAL_IMPACT_COMMUNICATION}
- **End Users**: {USER_FACING_CHANGES_IF_ANY}

### Progress Reporting
- **Weekly Updates**: {WEEKLY_PROGRESS_REPORTING_PLAN}
- **Sprint Reviews**: {SPRINT_DEMO_OR_REVIEW_CONTENT}
- **Milestone Gates**: {MILESTONE_REVIEW_CRITERIA}
- **Completion Announcement**: {HOW_TO_ANNOUNCE_RESOLUTION}

## Historical Context

### Creation Context
- **Why Created**: {CIRCUMSTANCES_THAT_LED_TO_THIS_DEBT}
- **Conscious vs Inadvertent**: {WHETHER_DEBT_WAS_INTENTIONAL}
- **Original Timeline Pressure**: {TIME_CONSTRAINTS_THAT_INFLUENCED_DECISION}
- **Available Alternatives**: {OPTIONS_CONSIDERED_AT_TIME_OF_CREATION}

### Evolution
- **How It Spread**: {HOW_THE_DEBT_ISSUE_HAS_GROWN}
- **Previous Mitigation Attempts**: {EARLIER_ATTEMPTS_TO_ADDRESS}
- **Lessons Learned**: {INSIGHTS_FROM_LIVING_WITH_THIS_DEBT}
- **Pattern Recognition**: {SIMILAR_ISSUES_IN_OTHER_AREAS}

## Resolution Log

### Investigation Notes
{PLACEHOLDER_FOR_INVESTIGATION_FINDINGS}

### Implementation Progress
{PLACEHOLDER_FOR_IMPLEMENTATION_UPDATES}

### Testing Results
{PLACEHOLDER_FOR_TEST_RESULTS}

### Review Feedback
{PLACEHOLDER_FOR_CODE_REVIEW_FEEDBACK}

## Post-Resolution

### Verification Checklist
- [ ] **All success criteria met**
- [ ] **No performance regression**
- [ ] **Documentation updated**
- [ ] **Team informed of changes**
- [ ] **Monitoring in place**
- [ ] **Related debt items updated**

### Lessons Learned
{PLACEHOLDER_FOR_RETROSPECTIVE_INSIGHTS}

### Prevention Strategies
- **Process Improvements**: {HOW_TO_PREVENT_SIMILAR_DEBT}
- **Tool Enhancements**: {AUTOMATED_PREVENTION_MEASURES}
- **Training Needs**: {TEAM_EDUCATION_TO_PREVENT_RECURRENCE}
- **Documentation**: {DOCUMENTATION_TO_GUIDE_FUTURE_DECISIONS}

## Related Documents

### Source References
- **Original Task**: [{SOURCE_TASK_ID}](../04_GENERAL_TASKS/{SOURCE_TASK_ID}.md)
- **Related Requirements**: [{REQUIREMENT_REF}](../02_REQUIREMENTS/{MILESTONE_ID}/)
- **Architecture Context**: [Architecture Documentation](../01_PROJECT_DOCS/ARCHITECTURE.md)
- **Related ADRs**: [{ADR_REF}](../05_ARCHITECTURAL_DECISIONS/{ADR_REF}.md)

### Resolution References
- **Resolution Tasks**: [{RESOLUTION_TASK_ID}](../04_GENERAL_TASKS/{RESOLUTION_TASK_ID}.md)
- **Code Changes**: [{PR_REFERENCE}]({PR_URL})
- **Test Results**: [{TEST_REPORT}]({TEST_REPORT_URL})
- **Performance Analysis**: [{PERFORMANCE_REPORT}]({PERFORMANCE_REPORT_URL})

### Cross-References
- **Blocking This**: [{BLOCKED_ITEM_1}]({BLOCKED_ITEM_1_URL})
- **Related Debt**: [{RELATED_DEBT_1}](TD_{RELATED_DEBT_1}.md)
- **Similar Patterns**: [{SIMILAR_DEBT_1}](TD_{SIMILAR_DEBT_1}.md)

---

## Metadata Summary

### Creation Information
- **Created**: {CREATED_DATE}
- **Creator**: {DISCOVERER_NAME}
- **Source**: {DISCOVERY_CONTEXT}
- **Template Version**: 1.0

### Current Status
- **Status**: {STATUS}
- **Last Updated**: {UPDATED_DATE}
- **Next Review**: {NEXT_REVIEW_DATE}
- **Assigned To**: {RESOLUTION_ASSIGNEE}

### Effort Tracking
- **Estimated Effort**: {ESTIMATED_EFFORT}h
- **Actual Effort**: {ACTUAL_EFFORT}h
- **Progress**: {PROGRESS_PERCENTAGE}%

### Impact Scores
- **Risk Score**: {RISK_SCORE}/25
- **Business Impact**: {BUSINESS_IMPACT_SCORE}/10
- **Technical Impact**: {TECHNICAL_IMPACT_SCORE}/10
- **Urgency Score**: {URGENCY_SCORE}/10

---

**Status**: {STATUS} | **Priority**: {SEVERITY} | **Target**: {RESOLUTION_TARGET} | **Owner**: {RESOLUTION_ASSIGNEE}