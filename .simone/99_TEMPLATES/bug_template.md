---
bug_id: "{BUG_ID}"
bug_title: "{BUG_TITLE}"
bug_type: "bug" # Always "bug"
severity: "{SEVERITY}" # critical, high, medium, low
priority: "{PRIORITY}" # critical, high, medium, low
status: "{STATUS}" # open, in_progress, testing, closed, wont_fix
created_date: "{CREATED_DATE}"
updated_date: "{UPDATED_DATE}"
reporter: "{REPORTER}"
assignee: "{ASSIGNEE}"
milestone_id: "{MILESTONE_ID}"
sprint_id: "{SPRINT_ID}"
component: "{COMPONENT}" # frontend, backend, database, api, infrastructure
environment: "{ENVIRONMENT}" # production, staging, development, local
browser: "{BROWSER}" # if applicable
os: "{OS}" # if applicable
version: "{VERSION}" # product version where bug was found
tags: ["{TAG_1}", "{TAG_2}", "{TAG_3}"]
duplicate_of: "{DUPLICATE_BUG_ID}" # if this is a duplicate
related_bugs: ["{RELATED_BUG_1}", "{RELATED_BUG_2}"]
estimated_effort: "{ESTIMATED_EFFORT}" # hours to fix
actual_effort: "{ACTUAL_EFFORT}" # hours spent fixing
---

# {BUG_ID}: {BUG_TITLE}

**Type**: Bug | **Status**: {STATUS} | **Priority**: {PRIORITY} | **Severity**: {SEVERITY}
**Component**: {COMPONENT} | **Environment**: {ENVIRONMENT} | **Assignee**: {ASSIGNEE}

## Bug Summary

### Description
{BUG_DESCRIPTION}

### Expected Behavior
{EXPECTED_BEHAVIOR}

### Actual Behavior
{ACTUAL_BEHAVIOR}

### Impact Assessment
- **User Impact**: {USER_IMPACT}
- **Business Impact**: {BUSINESS_IMPACT}
- **Technical Impact**: {TECHNICAL_IMPACT}

## Reproduction Details

### Steps to Reproduce
1. {STEP_1}
2. {STEP_2}
3. {STEP_3}
4. {STEP_4}

### Prerequisites
{PREREQUISITES}

### Test Data Required
{TEST_DATA}

### Reproduction Rate
{REPRODUCTION_RATE} (e.g., "100% - Always", "50% - Sometimes", "Rare - <10%")

## Environment Information

### System Details
- **Operating System**: {OS}
- **Browser**: {BROWSER}
- **Version**: {VERSION}
- **Environment**: {ENVIRONMENT}
- **URL**: {URL_IF_APPLICABLE}

### Configuration
{CONFIGURATION_DETAILS}

### Related Components
- **Frontend**: {FRONTEND_COMPONENTS}
- **Backend**: {BACKEND_COMPONENTS}
- **Database**: {DATABASE_COMPONENTS}
- **External Services**: {EXTERNAL_SERVICES}

## Evidence & Documentation

### Screenshots
{SCREENSHOT_DESCRIPTIONS}

### Error Messages
```
{ERROR_MESSAGES}
```

### Log Entries
```
{RELEVANT_LOG_ENTRIES}
```

### Console Output
```
{CONSOLE_OUTPUT}
```

### Network Requests
{NETWORK_REQUEST_DETAILS}

## Analysis & Investigation

### Root Cause Analysis
{ROOT_CAUSE_ANALYSIS}

### Affected Code Areas
- **File**: {AFFECTED_FILE_1}
  - **Function/Method**: {AFFECTED_FUNCTION_1}
  - **Lines**: {LINE_NUMBERS_1}
  
- **File**: {AFFECTED_FILE_2}
  - **Function/Method**: {AFFECTED_FUNCTION_2}
  - **Lines**: {LINE_NUMBERS_2}

### Related Architecture
{ARCHITECTURE_CONSIDERATIONS}

### Dependencies Impact
{DEPENDENCY_IMPACT}

## Fix Strategy

### Proposed Solution
{PROPOSED_SOLUTION}

### Alternative Solutions
1. **{ALTERNATIVE_1_TITLE}**
   - **Description**: {ALTERNATIVE_1_DESCRIPTION}
   - **Pros**: {ALTERNATIVE_1_PROS}
   - **Cons**: {ALTERNATIVE_1_CONS}

2. **{ALTERNATIVE_2_TITLE}**
   - **Description**: {ALTERNATIVE_2_DESCRIPTION}
   - **Pros**: {ALTERNATIVE_2_PROS}
   - **Cons**: {ALTERNATIVE_2_CONS}

### Risk Assessment
- **Fix Risk**: {FIX_RISK} (low, medium, high)
- **Regression Risk**: {REGRESSION_RISK}
- **Performance Impact**: {PERFORMANCE_IMPACT}
- **Security Considerations**: {SECURITY_CONSIDERATIONS}

### Breaking Changes
{BREAKING_CHANGES}

## Implementation Plan

### Fix Tasks
- [ ] {FIX_TASK_1}
- [ ] {FIX_TASK_2}
- [ ] {FIX_TASK_3}
- [ ] {FIX_TASK_4}
- [ ] {FIX_TASK_5}

### Testing Requirements
- [ ] **Unit Tests**: {UNIT_TEST_REQUIREMENTS}
- [ ] **Integration Tests**: {INTEGRATION_TEST_REQUIREMENTS}
- [ ] **Regression Tests**: {REGRESSION_TEST_REQUIREMENTS}
- [ ] **Manual Testing**: {MANUAL_TEST_REQUIREMENTS}

### Verification Criteria
- [ ] {VERIFICATION_CRITERIA_1}
- [ ] {VERIFICATION_CRITERIA_2}
- [ ] {VERIFICATION_CRITERIA_3}

## Progress Tracking

### Status Log
| Date | Status | Update | Hours |
|------|--------|--------|-------|
| {CREATED_DATE} | open | Bug reported | 0 |

### Work Notes
{WORK_NOTES}

### Blockers
{CURRENT_BLOCKERS}

## Relationships

### Related Bugs
- **{RELATED_BUG_1}**: {RELATIONSHIP_DESCRIPTION_1}
- **{RELATED_BUG_2}**: {RELATIONSHIP_DESCRIPTION_2}

### Related Features
- **{RELATED_FEATURE_1}**: {FEATURE_RELATIONSHIP_1}
- **{RELATED_FEATURE_2}**: {FEATURE_RELATIONSHIP_2}

### Dependencies
- **Depends On**: {DEPENDENCY_BUGS}
- **Blocks**: {BLOCKED_BUGS}

## Communication

### Stakeholder Updates
{STAKEHOLDER_COMMUNICATION}

### User Communication
{USER_COMMUNICATION}

### Technical Discussion
{TECHNICAL_DISCUSSION}

## Resolution

### Final Solution
{FINAL_SOLUTION}

### Code Changes
{CODE_CHANGES_SUMMARY}

### Testing Results
{TESTING_RESULTS}

### Deployment Notes
{DEPLOYMENT_NOTES}

### Lessons Learned
{LESSONS_LEARNED}

## Quality Checklist

### Bug Analysis
- [ ] Root cause identified and documented
- [ ] Impact assessment completed
- [ ] Reproduction steps verified
- [ ] Evidence collected and documented

### Solution Design
- [ ] Solution approach validated
- [ ] Risk assessment completed
- [ ] Breaking changes identified
- [ ] Alternative solutions considered

### Implementation
- [ ] Code changes implemented
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] Documentation updated

### Verification
- [ ] Bug fix verified in development
- [ ] Regression testing completed
- [ ] Performance impact assessed
- [ ] Security review completed (if applicable)

### Closure
- [ ] Stakeholders notified
- [ ] Documentation updated
- [ ] Lessons learned documented
- [ ] Related bugs updated