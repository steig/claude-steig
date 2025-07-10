# Run tests and fix common issues

**COGNITIVE PERSONAS INTEGRATION:** This command supports domain expertise for comprehensive testing strategies.

**AVAILABLE PERSONAS** (reference: `.claude/commands/shared/persona-flags.yml`):
- `--persona-qa`: Comprehensive testing strategy and quality assurance validation
- `--persona-security`: Security testing and vulnerability assessment
- `--persona-frontend`: Frontend testing, UI/UX validation, and accessibility testing
- `--persona-backend`: Backend testing, API validation, and performance testing
- `--persona-analyzer`: Test metrics analysis and coverage assessment
- `--persona-mentor`: Educational testing guidance and best practices
- `--persona-performance`: Performance testing and optimization validation
- `--persona-architect`: Integration testing and system validation

**ADVANCED FLAGS:**
- `--introspect`: Show transparent reasoning for test strategy and issue diagnosis
- `--consensus`: Multi-model consensus for complex testing decisions
- `--think-deep`: Extended analysis for complex test failures and edge cases

**USAGE EXAMPLES:**
- `/project:simone:test --persona-qa` (Comprehensive QA-focused testing)
- `/project:simone:test --persona-security --persona-backend` (Security and backend testing)
- `/project:simone:test --persona-frontend --introspect` (Frontend testing with transparency)

Follow these instructions from top to bottom.

## Create a TODO with EXACTLY these 4 items

1. Execute test suite
2. Analyze results and identify issues
3. Fix common problems if found
4. Provide test summary

---

## 1 · Execute test suite

**MCP INTEGRATION:** Use MCP servers to enhance testing:
- **Playwright**: Enable browser automation and E2E testing capabilities
- **Work History**: Track test results and common failure patterns
- **Sequential Thinking**: Structure test execution and debugging process

### First, detect the project's test runner:

1. **Python projects:**
   - If `pyproject.toml` exists with `[tool.poetry]`: Try `poetry run pytest`
   - If `setup.py` or `requirements.txt`: Try `pytest` or `python -m pytest`
   - If custom test script exists (e.g., `run_tests.py`, `run_dev.py`): Use that
   - Add common flags: `--tb=short` for pytest

2. **JavaScript/TypeScript projects:**
   - If `package.json` exists: Check "scripts" section for "test" command
   - Common: `npm test`, `npm run test`, `yarn test`, `pnpm test`
   - Framework specific: `jest`, `vitest`, `mocha`

3. **Other languages:**
   - Rust: `cargo test`
   - Go: `go test ./...`
   - Java: `mvn test` or `gradle test`
   - Ruby: `bundle exec rspec` or `rake test`
   - PHP: `composer test` or `phpunit`

### Execute the detected test command:

- RUN the appropriate test command
- CAPTURE full output including any errors
- NOTE execution time and test counts

**If no test runner is found:** Report this to the user and ask for the correct test command.

## 2 · Analyze results and identify issues

Check for common issues in this order:

### Language-specific issues:

**Python:**
- Missing __init__.py files (import errors, tests not discovered)
- Import path problems
- Fixture issues (pytest)
- Virtual environment problems

**JavaScript/TypeScript:**
- Module resolution errors
- Missing dependencies in node_modules
- Jest/Vitest configuration issues
- TypeScript compilation errors

**Common across languages:**
- Environment variable issues (missing config)
- Database/external service connection errors
- File path problems (absolute vs relative)
- Permission issues

## 3 · Fix common problems if found

**ONLY** fix these specific issues automatically:**

### Python-specific fixes:
- CREATE empty `__init__.py` files where needed
- FIX simple import path issues
- ADD missing test directory to Python path if needed

### JavaScript/TypeScript fixes:
- RUN `npm install` if node_modules missing
- FIX simple module resolution in jest.config.js
- CREATE missing test setup files

### General fixes:
- CREATE missing test directories
- FIX file permissions if possible
- IDENTIFY missing env vars and inform user

**DO NOT** fix:
- Actual test logic failures
- Business logic bugs
- Complex configuration issues
- Database schema problems
- External service dependencies

## 4 · Provide test summary

Create a brief summary:

```
Test Results:
- Total: X tests
- Passed: Y (Z%)
- Failed: A
- Skipped: B
- Time: C seconds

Issues Fixed:
- [List any fixes applied]

Issues Found (requires manual fix):
- [List problems that need attention]

Status: PASSING | FAILING | BLOCKED
```

**IMPORTANT:** Keep it concise. This command should be quick and focused on running tests, not detailed analysis.
EOF < /dev/null
