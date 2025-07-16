---
# DEPRECATED: This template has been superseded by unified_bug_template.md
# Migration: Use unified_bug_template.md which provides comprehensive bug reporting
# This file will be removed in v3.0.0

bug_id: "BUG{BUG_NUMBER}"
bug_title: "{BUG_TITLE}"
bug_type: "bug"  # bug, critical, security, performance, usability
status: "reported"  # reported, triaged, in_progress, testing, resolved
priority: "medium"  # low, medium, high, critical
severity: "minor"  # trivial, minor, major, critical, blocker
reporter: "{REPORTER_NAME}"
assignee: ""
reported_date: "{CREATED_DATE}"
due_date: ""
resolved_date: ""
affected_version: ""
target_version: ""
environment: "development"  # development, staging, production, all
browser: ""  # if applicable
device: ""   # if applicable

# Related Items
milestone_id: ""
sprint_id: ""
related_tasks: []
related_bugs: []
duplicate_of: ""

# Classification
component: ""  # backend, frontend, database, api, infrastructure
feature_area: ""  # authentication, user-management, reporting, etc.
impact_area: []  # user-experience, performance, security, data-integrity

# Tracking
effort_estimate: ""  # hours or story points
actual_effort: ""
resolution_type: ""  # fixed, duplicate, wont-fix, works-as-designed, needs-info
verification_status: ""  # pending, verified, failed

# Quality Assurance
test_cases_affected: []
regression_risk: "low"  # low, medium, high
hotfix_required: false

# Communication
stakeholders_notified: []
customer_impact: "none"  # none, low, medium, high, critical
escalation_needed: false

# Metrics
discovery_phase: "development"  # requirements, development, testing, production
root_cause_category: ""  # logic-error, integration, configuration, design, requirements
prevention_category: ""  # code-review, automated-testing, design-review, requirements-review

# Tags
tags: []
labels: []
---

# {BUG_TITLE}

## Bug Description

**Summary**: Brief, clear description of the bug

**Expected Behavior**: What should happen

**Actual Behavior**: What actually happens

**Impact**: Who/what is affected and how

## Reproduction Steps

1. 
2. 
3. 

**Reproducibility**: Always / Sometimes / Rarely / Unable to reproduce

## Environment Details

- **Version**: 
- **Platform**: 
- **Browser/Device**: 
- **Configuration**: 

## Evidence

### Screenshots/Videos
<!-- Add screenshots, videos, or other visual evidence -->

### Error Messages
```
<!-- Paste error messages, stack traces, logs -->
```

### Additional Context
<!-- Any other relevant information -->

## Technical Analysis

### Root Cause Analysis
<!-- Technical investigation of why the bug occurred -->

### Affected Code Areas
<!-- List files, functions, or components involved -->

### Dependencies
<!-- Other systems, services, or components affected -->

## Resolution Plan

### Proposed Solution
<!-- How this bug will be fixed -->

### Alternative Approaches
<!-- Other ways this could be addressed -->

### Risk Assessment
<!-- Potential risks of the fix -->

## Testing Strategy

### Test Cases
<!-- Specific tests to verify the fix -->

### Regression Testing
<!-- Areas to test to ensure no new issues -->

### Acceptance Criteria
- [ ] Bug no longer reproduces
- [ ] Original functionality works correctly
- [ ] No regression issues introduced
- [ ] Performance impact acceptable
- [ ] Documentation updated (if needed)

## Implementation Notes

### Code Changes
<!-- Summary of code changes made -->

### Configuration Changes
<!-- Any configuration or environment changes -->

### Database Changes
<!-- Any schema or data changes -->

## Verification

### Verification Steps
1. 
2. 
3. 

### Verification Environment
<!-- Where the fix was tested -->

### Verification Results
<!-- Results of testing the fix -->

## Post-Resolution

### Lessons Learned
<!-- What can be learned from this bug -->

### Prevention Measures
<!-- How to prevent similar bugs -->

### Documentation Updates
<!-- Any documentation that needs updating -->

## Communication Log

| Date | Type | Audience | Message |
|------|------|----------|---------|
|      |      |          |         |

## Related Information

### References
- Issue tracker links
- Documentation links
- Related bugs/tasks
- External resources

### Attachments
<!-- List any attached files -->

---

**Resolution Summary**: <!-- Final summary when bug is resolved -->

**Verification**: <!-- Confirmation that fix works and testing is complete -->

**Sign-off**: <!-- Approval that bug is fully resolved -->