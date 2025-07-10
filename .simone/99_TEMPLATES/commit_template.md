# Commit Message Template

## Standard Format
```
{type}({scope}): {description} ({TASK_ID/BUG_ID})

{optional_body}

{optional_footer}
```

## Commit Types

### Primary Types
- **feat**: New features or enhancements
- **fix**: Bug fixes
- **hotfix**: Critical fixes requiring immediate deployment
- **refactor**: Code improvements without functional changes
- **perf**: Performance improvements
- **docs**: Documentation updates
- **test**: Test additions or modifications
- **chore**: Maintenance tasks, dependency updates

### Secondary Types
- **style**: Code formatting, linting fixes
- **ci**: CI/CD pipeline changes
- **build**: Build system or dependency changes
- **revert**: Reverting previous commits

## Scope Guidelines

### Common Scopes
- **auth**: Authentication and authorization
- **api**: API endpoints and interfaces
- **ui**: User interface components
- **db**: Database related changes
- **config**: Configuration changes
- **deps**: Dependency updates
- **tests**: Test-related changes

### Component-Based Scopes
Use actual component/module names:
- **user-service**: User management service
- **payment**: Payment processing
- **notification**: Notification system
- **admin**: Admin panel functionality

## Task/Bug ID Integration

### Task References
- **Sprint Tasks**: `(T01_S02)`, `(T03_S01)`
- **General Tasks**: `(T001)`, `(T003)`
- **Examples**:
  - `feat(auth): implement user login (T01_S02)`
  - `refactor(api): optimize response handling (T003)`

### Bug References
- **Bug Fixes**: `(BUG001)`, `(BUG002)`
- **Examples**:
  - `fix(login): resolve validation error (BUG001)`
  - `hotfix(security): patch authentication bypass (BUG002)`

## Description Guidelines

### Writing Style
- Use imperative mood ("add", "fix", "update" not "added", "fixed", "updated")
- Keep first line under 72 characters
- Be specific and descriptive
- Avoid vague terms like "fix issue" or "update code"

### Good Examples
```
feat(auth): implement OAuth2 authentication (T01_S02)
fix(api): resolve null pointer in user service (BUG001)
refactor(db): optimize user query performance (T003)
docs(readme): update installation instructions
test(auth): add integration tests for login flow (T01_S02)
```

### Bad Examples
```
fix: bug fix
update: changes
feat: new stuff
refactor: code improvements
```

## Body and Footer (Optional)

### When to Use Body
- Complex changes requiring explanation
- Breaking changes
- Multiple related changes
- Context that's not obvious from diff

### Body Format
```
feat(api): implement user search functionality (T02_S01)

Add comprehensive user search with filters for name, email, and role.
Includes pagination, sorting, and full-text search capabilities.
Integrates with existing authentication and authorization systems.

- Add search endpoint with filtering
- Implement pagination with configurable page size
- Add sorting by multiple fields
- Include full-text search for user profiles
```

### Footer Examples
```
BREAKING CHANGE: User API now requires authentication for all endpoints

Fixes: #123, #456
Refs: T01_S02, BUG001
Co-authored-by: Developer Name <dev@example.com>
```

## Branch-Specific Templates

### Feature Branches (task/*)
```
feat({scope}): {description} ({TASK_ID})

{optional_implementation_details}

- Implements acceptance criteria from {TASK_ID}
- Maintains backward compatibility
- Includes comprehensive tests
```

### Bug Fix Branches (bug/*)
```
fix({scope}): {description} ({BUG_ID})

{optional_root_cause_explanation}

- Fixes issue described in {BUG_ID}
- Includes regression test
- Verified fix resolves reported symptoms
```

### Hotfix Branches (hotfix/*)
```
hotfix({scope}): {critical_description} ({BUG_ID})

{impact_and_urgency_explanation}

BREAKING CHANGE: {if_applicable}

- Addresses critical security/stability issue
- Requires immediate deployment
- Includes rollback plan
```

## Semantic Versioning Impact

### Version Bumps
- **PATCH** (0.0.X): fix, hotfix, docs, style, test, chore
- **MINOR** (0.X.0): feat, perf
- **MAJOR** (X.0.0): Any commit with BREAKING CHANGE footer

### Examples with Version Impact
```
fix(auth): resolve token expiry issue (BUG001)        # PATCH: 1.2.3 → 1.2.4
feat(api): add user preferences endpoint (T01_S02)    # MINOR: 1.2.3 → 1.3.0
feat(auth): redesign authentication flow (T01_S02)    # MAJOR: 1.2.3 → 2.0.0

BREAKING CHANGE: Authentication now requires 2FA for all users
```

## Multi-Commit Guidelines

### Related Commits
When multiple commits are part of the same task:
```
feat(auth): implement OAuth2 base framework (T01_S02)
feat(auth): add Google OAuth provider (T01_S02)
feat(auth): add Microsoft OAuth provider (T01_S02)
test(auth): add OAuth integration tests (T01_S02)
docs(auth): update authentication documentation (T01_S02)
```

### Squashing Guidelines
- Squash trivial commits (typos, linting fixes)
- Keep logical progression of implementation
- Maintain meaningful commit history
- Each commit should be a working state

## Project-Specific Conventions

### Task Status Integration
- First commit for task: mention status change
- Final commit for task: indicate completion
```
feat(auth): start user authentication implementation (T01_S02)

- Set task status to in_progress
- Create basic authentication framework

feat(auth): complete user authentication system (T01_S02)

- Implement all acceptance criteria
- Add comprehensive tests and documentation
- Ready for code review
```

### Code Review Integration
```
feat(auth): implement user login system (T01_S02)

Addresses code review feedback:
- Add input validation for email format
- Improve error messaging for failed logins
- Add rate limiting for login attempts

Co-reviewed-by: Senior Dev <senior@example.com>
```

## Automation Integration

### Template Variables
When using automated commit generation:
- `{TASK_ID}`: Extracted from branch or argument
- `{TASK_TITLE}`: From task file metadata
- `{SCOPE}`: Derived from affected files/components
- `{TYPE}`: Determined by task type or change analysis

### Quality Checks
- Validate commit message format
- Ensure task/bug ID is valid and exists
- Check that type matches change content
- Verify scope is appropriate for changes
- Confirm description is descriptive and specific

This template ensures consistent, traceable, and meaningful commit messages that integrate seamlessly with the Simone project management system and support automated versioning and release management.