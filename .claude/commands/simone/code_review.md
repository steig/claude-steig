# Code Review - Execute top to bottom

**COGNITIVE PERSONAS INTEGRATION:** This command supports multi-domain code review through persona flags.

**AVAILABLE PERSONAS** (reference: `.claude/commands/shared/persona-flags.yml`):
- `--persona-architect`: System design and architecture review
- `--persona-security`: Security vulnerabilities and OWASP compliance
- `--persona-frontend`: UI/UX and frontend code quality  
- `--persona-backend`: API design and backend performance
- `--persona-analyzer`: Code metrics and quality analysis
- `--persona-mentor`: Educational feedback and best practices
- `--persona-refactorer`: Code optimization opportunities
- `--persona-performance`: Performance bottlenecks and optimization
- `--persona-qa`: Testing coverage and quality assurance

**ADVANCED FLAGS:**
- `--introspect`: Show transparent reasoning with 🤔 Thinking and 🎯 Decision indicators
- `--consensus`: Multi-model consensus for critical review decisions
- `--think-deep`: Extended analysis for complex code changes

**USAGE EXAMPLES:**
- `/project:simone:code_review --persona-security --persona-analyzer` (Security-focused review)
- `/project:simone:code_review --persona-architect --persona-performance --introspect` (Architecture review with transparency)
- `/project:simone:code_review --persona-security --consensus --think-deep` (Comprehensive security analysis)

Use the following instructions from top to bottom to execute a Code Review.

## Create a TODO with EXACTLY these 6 Items

1. Analyze the Scope given
2. Find code changes within Scope
3. Find relevant Specification and Documentation
4. Compare code changes against Documentation and Requirements
5. Analyze possible differences
6. Provide PASS/FAIL verdict with details

Follow step by step and adhere closely to the following instructions for each step.

## DETAILS on every TODO item

### 1. Analyze the Scope given

**MCP INTEGRATION:** Use MCP servers to enhance code review process:
- **Serena**: Get enhanced code analysis and quality insights
- **Sequential Thinking**: Structure the review process systematically
- **Work History**: Reference previous code reviews and their outcomes

check: <$ARGUMENTS>

If empty, use default, otherwise interpret <$ARGUMENTS> to identify the scope of the Review. Only continue if you can find meaningful changes to review.

**CONTEXT:** Before reviewing code changes:

- Read `.simone/00_PROJECT_MANIFEST.md` to understand current sprint and milestone context
- Use the manifest to identify which sprint is active and what work is in scope
- Only evaluate against requirements appropriate for the current sprint's deliverables

### 2. Find code changes within Scope

With the identified Scope use `git diff` (on default: `git diff HEAD~1`) to find code changes.

### 3. Find relevant Specifications and Documentation

- FIND the Task, Sprint and Milestone involved in the work that was done and output your findings
- Navigate to `.simone/03_SPRINTS/` to find the current sprint directory
- READ the sprint meta file to understand sprint objectives and deliverables
- If a specific task is in scope, find and READ the task file in the sprint directory
- IDENTIFY related requirements in `.simone/02_REQUIREMENTS/` for the current milestone
- READ involved Documents especially in `.simone/01_PROJECT_DOCS/` and `.simone/02_REQUIREMENTS/`
- **IMPORTANT:** Focus on current sprint deliverables, not future milestone features

### 4. Compare code changes against Documentation and Requirements

**PERSONA-DRIVEN ANALYSIS:** Apply domain-specific review criteria based on activated personas:

**🏗️ Architecture Persona (if activated):**
- **System Design**: Validate design patterns, SOLID principles, dependency management
- **Scalability**: Assess performance under load, resource usage, bottleneck potential
- **Integration**: Check service boundaries, API contracts, data flow consistency
- **Technical Debt**: Identify architectural anti-patterns, coupling issues

**🔒 Security Persona (if activated):**
- **OWASP Top 10**: Check for injection, broken auth, sensitive data exposure
- **Input Validation**: Verify sanitization, validation, escape mechanisms
- **Access Control**: Review authorization logic, privilege escalation risks
- **Cryptography**: Validate encryption usage, key management, secure protocols

**🎨 Frontend Persona (if activated):**
- **User Experience**: Review UI consistency, accessibility compliance (WCAG)
- **Performance**: Check bundle size, loading times, rendering optimization
- **Browser Compatibility**: Validate cross-browser support, progressive enhancement
- **Component Design**: Assess reusability, maintainability, state management

**⚙️ Backend Persona (if activated):**
- **API Design**: Validate RESTful principles, error handling, status codes
- **Database**: Review queries, indexing, transaction management, data integrity
- **Performance**: Check N+1 queries, caching strategies, resource efficiency
- **Scalability**: Assess horizontal scaling, statelessness, bottleneck identification

**📊 Analyzer Persona (if activated):**
- **Code Metrics**: Complexity analysis, maintainability index, technical debt
- **Quality Gates**: Test coverage, linting compliance, code duplication
- **Performance Metrics**: Memory usage, execution time, resource consumption
- **Maintainability**: Code readability, documentation quality, refactoring needs

**🎓 Mentor Persona (if activated):**
- **Best Practices**: Industry standards, coding conventions, design patterns
- **Educational Value**: Code clarity, documentation, learning opportunities
- **Knowledge Transfer**: Maintainability for team members, onboarding considerations
- **Growth Opportunities**: Skill development recommendations, improvement suggestions

**⚡ Performance Persona (if activated):**
- **Bottlenecks**: CPU, memory, I/O, network performance analysis
- **Optimization**: Algorithm efficiency, data structure choices, caching strategies
- **Monitoring**: Performance metrics, logging, observability implementation
- **Scalability**: Load handling, resource management, optimization opportunities

**✅ QA Persona (if activated):**
- **Test Coverage**: Unit, integration, end-to-end test completeness
- **Quality Assurance**: Bug prevention, edge case handling, error scenarios
- **Validation**: Input validation, output verification, boundary testing
- **Regression Prevention**: Breaking change analysis, backward compatibility

**INTROSPECTION MODE** (if `--introspect` flag present):
- Show 🤔 Thinking process for each persona analysis
- Display 🎯 Decision rationale for each finding
- Provide 🔍 Analysis of severity assessment reasoning
- Conclude with ✅ Summary of multi-domain findings

**STANDARD REVIEW CRITERIA** (always applied):
- **Data models / schemas** — fields, types, constraints, relationships.
- **APIs / interfaces** — endpoints, params, return shapes, status codes, errors.
- **Config / environment** — keys, defaults, required/optional.
- **Behaviour** — business rules, side-effects, error handling.
- **Quality** — naming, formatting, tests, linter status.

**IMPORTANT**:

- Deviations from the Specs is not allowed. Not even small ones. Be very picky here!
- If in doubt call a **FAIL** and ask the User.
- Zero tolerance on not following the Specs and Documentation.

### 5. Analyze the differences

- Analyze any difference found
- Give every issue a Severity Score
- Severity ranges from 1 (low) to 10 (high)
- Remember List of issues and Scores for output

### 6. Provide PASS/FAIL verdict with details

- Call a **FAIL** on any differences found.
  - Zero Tolerance - even on well meant additions.
  - Leave it on the user to decide if small changes are allowed.
- Only **PASS** if no discrepancy appeared.

#### IMPORTANT: Output Format

- Output the results of your review to the task's **## Output Log** section in the task file
- Find the task file in `.simone/03_SPRINTS/` or `.simone/04_GENERAL_TASKS/` based on the scope
- Append the review results to the existing Output Log with timestamp
- Output Format:
  ```
  [YYYY-MM-DD HH:MM]: Code Review - PASS/FAIL
  Result: **FAIL/PASS** Your final decision on if it's a PASS or a FAIL.
  **Scope:** Inform the user about the review scope.
  **Findings:** Detailed list with all Issues found and Severity Score.
  **Summary:** Short summary on what is wrong or not.
  **Recommendation:** Your personal recommendation on further steps.
  ```
- Also output a brief result summary to the console for immediate feedback
