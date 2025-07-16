---
# Bug Template Metadata
template_version: "3.0.0"
template_type: "bug_report"
framework_version: "3.0.0"
created_date: "2025-01-14"
last_updated: "2025-01-14"

# Bug Identification
bug_id: "{BUG_ID}"
bug_title: "{BUG_TITLE}"
bug_type: "bug" # bug, critical, security, performance, usability
status: "reported" # reported, triaged, in_progress, testing, resolved, closed, wont_fix
created_date: "{CREATED_DATE}"
updated_date: "{UPDATED_DATE}"

# Priority and Severity
priority: "medium" # low, medium, high, critical
severity: "minor" # trivial, minor, major, critical, blocker

# Responsibility and Timeline
reporter: "{REPORTER_NAME}"
assignee: "{ASSIGNEE}"
reported_date: "{CREATED_DATE}"
due_date: "{DUE_DATE}"
resolved_date: "{RESOLVED_DATE}"

# Environment and Context
environment: "development" # development, staging, production, all
browser: "{BROWSER}" # if applicable
device: "{DEVICE}" # if applicable
os: "{OS}" # if applicable
version: "{VERSION}" # product version where bug was found
affected_version: "{AFFECTED_VERSION}"
target_version: "{TARGET_VERSION}"

# Project Context
milestone_id: "{MILESTONE_ID}"
sprint_id: "{SPRINT_ID}"
component: "{COMPONENT}" # frontend, backend, database, api, infrastructure
feature_area: "{FEATURE_AREA}" # authentication, user-management, reporting, etc.
impact_area: ["{IMPACT_1}", "{IMPACT_2}"] # user-experience, performance, security, data-integrity

# Relationships
related_tasks: ["{TASK_1}", "{TASK_2}"]
related_bugs: ["{RELATED_BUG_1}", "{RELATED_BUG_2}"]
duplicate_of: "{DUPLICATE_BUG_ID}" # if this is a duplicate
blocks: ["{BLOCKED_ITEM_1}", "{BLOCKED_ITEM_2}"]
blocked_by: ["{BLOCKING_ITEM_1}", "{BLOCKING_ITEM_2}"]

# Effort Tracking
estimated_effort: "{ESTIMATED_EFFORT}" # hours to fix
actual_effort: "{ACTUAL_EFFORT}" # hours spent fixing
complexity: "medium" # simple, medium, complex, very_complex

# Tags and Classification
tags: ["{TAG_1}", "{TAG_2}", "{TAG_3}"]
labels: ["{LABEL_1}", "{LABEL_2}"] # team-specific labels

# Quality and Testing
test_case_id: "{TEST_CASE_ID}" # if related to specific test
regression_risk: "low" # low, medium, high - risk of introducing new bugs
verification_steps: [] # steps to verify the fix

# External References
github_issue: "{GITHUB_ISSUE_URL}"
external_refs: ["{URL_1}", "{URL_2}"]
customer_reported: false # true if reported by customer
---

# {BUG_ID}: {BUG_TITLE}

**Type**: {BUG_TYPE} | **Status**: {STATUS} | **Priority**: {PRIORITY} | **Severity**: {SEVERITY}
**Component**: {COMPONENT} | **Environment**: {ENVIRONMENT} | **Assignee**: {ASSIGNEE}

## Quick Start Section

> ⚡ **Quick Report**: For simple bugs, fill out only the essential fields below and submit. Advanced sections can be completed during triage.

### Essential Information
- **Bug Title**: [One line description of the issue]
- **Environment**: development | staging | production | all
- **Component**: frontend | backend | database | api | infrastructure
- **Priority**: low | medium | high | critical
- **Severity**: trivial | minor | major | critical | blocker

## Detailed Bug Report

### Summary
Brief description of the bug and its impact.

### Environment Details
- **Operating System**: {OS}
- **Browser/Client**: {BROWSER} {VERSION}
- **Device**: {DEVICE} (if mobile/tablet)
- **Application Version**: {VERSION}
- **Environment**: {ENVIRONMENT}

### Steps to Reproduce
1. [First step]
2. [Second step]
3. [Additional steps...]

### Expected Behavior
[What should have happened]

### Actual Behavior
[What actually happened]

### Screenshots/Videos
[Attach any visual evidence]

### Error Messages/Logs
```
[Paste any error messages or relevant log entries]
```

### Impact Assessment

#### User Impact
- **Affected Users**: [Who is affected - all users, specific roles, etc.]
- **Frequency**: [How often does this occur - always, sometimes, rarely]
- **Workaround Available**: [Yes/No - describe if yes]

#### Business Impact
- **Revenue Impact**: [None/Low/Medium/High]
- **Customer Support Impact**: [None/Low/Medium/High]
- **Reputation Risk**: [None/Low/Medium/High]

### Technical Analysis

#### Root Cause (if known)
[Technical explanation of what's causing the bug]

#### Affected Code Areas
- [List of files/modules/components affected]

#### Dependencies
- **Blocks**: [What this bug prevents from working]
- **Blocked By**: [What needs to be fixed first]
- **Related Issues**: [Links to related bugs/tasks]

### Fix Strategy

#### Proposed Solution
[How this should be fixed]

#### Alternative Approaches
[Other ways this could be addressed]

#### Risk Assessment
- **Implementation Risk**: [Low/Medium/High]
- **Regression Risk**: [Low/Medium/High]
- **Testing Complexity**: [Simple/Medium/Complex]

### Testing Strategy

#### Test Cases Needed
- [ ] [Unit test for specific function]
- [ ] [Integration test for component interaction]
- [ ] [Manual test for user workflow]

#### Verification Steps
1. [Step to verify the fix works]
2. [Step to ensure no regression]
3. [Additional verification steps]

#### Acceptance Criteria
- [ ] [Bug no longer occurs with original steps]
- [ ] [All existing tests still pass]
- [ ] [New tests cover the bug scenario]
- [ ] [Performance impact assessed]

## Resolution Documentation

### Fix Summary
[Brief description of how the bug was fixed]

### Code Changes
- [List of files modified]
- [Summary of changes made]

### Testing Performed
- [ ] Unit tests added/updated
- [ ] Integration tests verified
- [ ] Manual testing completed
- [ ] Performance impact assessed
- [ ] Security review (if applicable)

### Deployment Notes
[Any special considerations for deployment]

### Post-Fix Monitoring
[What to monitor after the fix is deployed]

## Quality Checklist

### Before Assignment
- [ ] Bug title is clear and descriptive
- [ ] Steps to reproduce are detailed and complete
- [ ] Expected vs actual behavior is clearly defined
- [ ] Environment information is complete
- [ ] Priority and severity are appropriately set
- [ ] Screenshots/logs are attached if helpful

### During Investigation
- [ ] Root cause has been identified
- [ ] Impact assessment is complete
- [ ] Fix strategy has been defined
- [ ] Dependencies and relationships are documented
- [ ] Effort estimation is provided

### Before Resolution
- [ ] Fix has been implemented and tested
- [ ] Verification steps have been completed
- [ ] Regression testing has been performed
- [ ] Documentation has been updated
- [ ] Deployment plan is in place

### After Resolution
- [ ] Bug is marked as resolved with appropriate details
- [ ] Related tasks/bugs are updated
- [ ] Lessons learned are documented
- [ ] Prevention measures are considered

## Project Integration

### Sprint Integration
- **Sprint Assignment**: [Current sprint or backlog]
- **Sprint Impact**: [How this affects sprint goals]
- **Resource Requirements**: [Team members needed]

### Milestone Impact
- **Milestone Risk**: [Does this jeopardize milestone completion]
- **Milestone Dependencies**: [How this relates to milestone deliverables]

### Communication Plan
- **Stakeholder Notification**: [Who needs to be informed]
- **Customer Communication**: [If customer-facing impact]
- **Team Updates**: [Regular progress updates]

## Historical Tracking

### Similar Issues
- [References to similar bugs in the past]
- [Lessons learned from previous fixes]

### Pattern Analysis
- [Is this part of a larger pattern or trend]
- [Preventive measures to avoid similar issues]

## Output Log
[Chronological record of all activities related to this bug]

[YYYY-MM-DD HH:MM]: Bug reported by {REPORTER}
[YYYY-MM-DD HH:MM]: Initial triage completed
[YYYY-MM-DD HH:MM]: Assigned to {ASSIGNEE}
[YYYY-MM-DD HH:MM]: Investigation started
[YYYY-MM-DD HH:MM]: Root cause identified
[YYYY-MM-DD HH:MM]: Fix implemented
[YYYY-MM-DD HH:MM]: Testing completed
[YYYY-MM-DD HH:MM]: Bug resolved and verified

---

## Template Usage Notes

### For Quick Reports
1. Fill out the "Quick Start Section" with essential information
2. Complete "Steps to Reproduce" and "Expected/Actual Behavior"
3. Submit for triage - advanced sections can be completed later

### For Detailed Reports
1. Complete all relevant sections thoroughly
2. Attach screenshots, logs, or other supporting evidence
3. Conduct initial impact assessment
4. Provide technical analysis if known

### For Development Teams
1. Use the technical analysis and fix strategy sections extensively
2. Document all testing performed
3. Update the output log with progress
4. Complete the quality checklist before resolution

### Field Definitions

**Priority vs Severity**:
- **Priority**: How soon this should be fixed (business priority)
- **Severity**: How bad the impact is (technical severity)

**Status Flow**:
reported → triaged → in_progress → testing → resolved → closed

**Component Classification**:
- **Frontend**: UI, client-side logic, user interface
- **Backend**: Server-side logic, business rules, processing
- **Database**: Data storage, queries, schema issues
- **API**: Service interfaces, integration points
- **Infrastructure**: Deployment, configuration, environment issues

---

*Bug Template v2.0.0 | Comprehensive unified template | Supports quick and detailed reporting*