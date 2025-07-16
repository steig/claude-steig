# Pull Request Template

## PR Title Format
```
{type}({scope}): {description} ({TASK_ID/BUG_ID})
```

## Description Template

```markdown
## Summary
{AI-generated summary of changes based on task/bug context and code analysis}

## Related Work
- **Task/Bug**: [{TASK_ID/BUG_ID}]({link_to_task_or_bug_file})
- **Type**: {task_type} | **Priority**: {priority} | **Complexity**: {complexity}
- **Estimated Effort**: {estimated_effort}h | **Actual Effort**: {actual_effort}h
- **Sprint**: {sprint_id} | **Milestone**: {milestone_id}

## Changes Made
{AI-generated detailed list of changes based on git diff analysis}

### Files Modified
{List of modified files with brief description of changes}

### New Features
{List of new functionality added}

### Bug Fixes
{List of bugs fixed with reference to symptoms}

### Refactoring
{List of code improvements and optimizations}

## Acceptance Criteria
{Converted from task/bug acceptance criteria - each item becomes a checkbox}

## Testing
### Test Coverage
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] End-to-end tests added/updated
- [ ] Manual testing completed

### Test Results
{Summary of test execution and results}

### Regression Testing
- [ ] Existing functionality verified
- [ ] No new issues introduced
- [ ] Performance impact assessed

## Code Quality
### Standards Compliance
- [ ] Code follows project style guidelines
- [ ] Documentation updated/added
- [ ] Comments added for complex logic
- [ ] Error handling implemented
- [ ] Security considerations addressed

### Technical Debt
{Any technical debt added or resolved}

## Breaking Changes
{Description of any breaking changes, migration steps, and impact assessment}

## Deployment
### Deployment Notes
{Special considerations for deployment}

### Environment Impact
- [ ] Database migrations required
- [ ] Configuration changes needed
- [ ] Infrastructure updates required
- [ ] Third-party service changes

### Rollback Plan
{Plan for rolling back if issues arise}

## Performance Impact
{Analysis of performance implications}

## Security Review
- [ ] Security implications assessed
- [ ] Authentication/authorization checked
- [ ] Input validation implemented
- [ ] Data privacy considerations addressed
- [ ] Vulnerability scan completed (if applicable)

## Documentation
- [ ] API documentation updated
- [ ] User documentation updated
- [ ] README updated
- [ ] Changelog updated
- [ ] Architecture docs updated (if applicable)

## Screenshots/Evidence
{Visual evidence of changes for UI modifications}

## Additional Context
{Any additional context, considerations, or notes for reviewers}

---

## Review Checklist (For Reviewers)
### Code Review
- [ ] Code is readable and well-structured
- [ ] Logic is correct and efficient
- [ ] Error handling is appropriate
- [ ] Security best practices followed
- [ ] Performance considerations addressed

### Testing Review
- [ ] Test coverage is adequate
- [ ] Tests are meaningful and well-written
- [ ] Edge cases are covered
- [ ] Tests pass consistently

### Documentation Review
- [ ] Documentation is accurate and complete
- [ ] API changes are documented
- [ ] Code comments are helpful
- [ ] User-facing changes documented

### Architecture Review
- [ ] Changes align with system architecture
- [ ] Design patterns are appropriate
- [ ] Coupling and cohesion are good
- [ ] Scalability considerations addressed

### Final Approval
- [ ] All acceptance criteria met
- [ ] All quality gates passed
- [ ] Ready for deployment
- [ ] Approved by required reviewers
```

## Template Variations

### Feature PR Template
```markdown
## 🚀 Feature: {feature_name} ({TASK_ID})

### What's New
{Description of new functionality}

### User Impact
{How this affects end users}

### Technical Implementation
{High-level technical approach}

### Demo/Examples
{Usage examples or demo links}
```

### Bug Fix PR Template
```markdown
## 🐛 Bug Fix: {bug_description} ({BUG_ID})

### Problem
{Description of the bug and its impact}

### Root Cause
{What caused the issue}

### Solution
{How the fix addresses the root cause}

### Verification
{How to verify the fix works}
```

### Hotfix PR Template
```markdown
## 🚨 Hotfix: {critical_issue} ({BUG_ID})

### Critical Issue
{Description of the critical problem}

### Impact
{User/business impact if not fixed immediately}

### Emergency Solution
{Quick fix implementation}

### Post-Deployment Plan
{Follow-up actions after hotfix deployment}
```

### Refactoring PR Template
```markdown
## ♻️ Refactor: {area_refactored} ({TASK_ID})

### Motivation
{Why this refactoring was needed}

### Changes Made
{Technical changes without functional impact}

### Benefits
{Performance, maintainability, or other improvements}

### Risk Assessment
{Potential risks and mitigation strategies}
```

## Automated Sections

### AI-Generated Content
These sections are automatically populated by the `create_pr` command:

1. **Summary**: Generated from task description and code diff analysis
2. **Changes Made**: Extracted from git diff with intelligent categorization
3. **Files Modified**: List with change summaries
4. **Acceptance Criteria**: Converted from task/bug criteria
5. **Related Work**: Links and metadata from task/bug files

### Dynamic Checklists
Checklists adapt based on:
- **Task Type**: Different items for features vs bugs vs refactoring
- **Files Changed**: Additional checks for specific file types
- **Scope**: Security, performance, or accessibility checks as needed
- **Project Config**: Custom checklist items from project settings

## Integration Features

### Task/Bug Linking
- Automatic links to task/bug files in `.simone/` directory
- Status synchronization between PR and task/bug
- Cross-references in both directions
- Progress tracking integration

### Metadata Extraction
- Sprint and milestone information
- Effort tracking (estimated vs actual)
- Priority and complexity assessment
- Assignee and reviewer suggestions

### Code Analysis Integration
- Automatic categorization of changes
- Breaking change detection
- Security impact assessment
- Performance impact analysis
- Test coverage analysis

## Quality Gates

### Required Checks
- [ ] All acceptance criteria checkbox items checked
- [ ] Code quality checklist completed
- [ ] Testing requirements met
- [ ] Documentation updated
- [ ] Security review completed (for sensitive changes)

### Automated Validation
- Commit message format validation
- Branch naming convention compliance
- Required file updates (changelog, docs)
- Test coverage thresholds
- Code quality metrics

## Reviewer Guidelines

### Assignment Rules
- **Feature PRs**: Lead developer + domain expert
- **Bug Fix PRs**: Senior developer + QA reviewer
- **Hotfix PRs**: Technical lead + stakeholder approval
- **Refactoring PRs**: Architecture reviewer + affected team members

### Review Criteria
- **Functionality**: Does it work as intended?
- **Quality**: Is the code well-written and maintainable?
- **Testing**: Is it adequately tested?
- **Documentation**: Are changes properly documented?
- **Security**: Are there any security implications?
- **Performance**: Does it meet performance requirements?

This template ensures comprehensive, consistent, and traceable pull requests that integrate seamlessly with the Simone task management system while supporting thorough code review and quality assurance processes.