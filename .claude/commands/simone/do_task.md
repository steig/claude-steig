# Process Simone Task based on $Argument

**COGNITIVE PERSONAS INTEGRATION:** This command supports domain expertise enhancement through persona flags.

**AVAILABLE PERSONAS** (reference: `.claude/commands/shared/persona-flags.yml`):
- `--persona-architect`: System design and architecture expertise
- `--persona-security`: Security analysis and OWASP compliance  
- `--persona-frontend`: Frontend development and UX optimization
- `--persona-backend`: Backend systems and API development
- `--persona-analyzer`: Code analysis and metrics evaluation
- `--persona-mentor`: Guidance and best practices coaching
- `--persona-refactorer`: Code optimization and maintainability
- `--persona-performance`: Performance optimization and scalability
- `--persona-qa`: Quality assurance and testing strategies

**ADVANCED FLAGS:**
- `--introspect`: Show transparent AI reasoning with 🤔 Thinking and 🎯 Decision indicators
- `--uc`: Use UltraCompressed mode for 70% token reduction (auto-triggers for large projects)
- `--consensus`: Multi-model consensus gathering for critical decisions
- `--think-deep`: Extended reasoning for complex problems

**USAGE EXAMPLES:**
- `/project:simone:do_task T001 --persona-security` (Security-focused task execution)
- `/project:simone:do_task T001 --persona-security --persona-backend --introspect` (Multi-domain with transparency)
- `/project:simone:do_task T001 --persona-architect --consensus --think-deep` (Comprehensive analysis for complex tasks)

**IMPORTANT:** Follow from Top to Bottom - don't skip anything!

**CREATE A TODO LIST** with exactly these 9 items

1. Analyse scope from argument
2. Identify task file
3. Analyse the task
4. Create and switch to task branch
5. Set status to in_progress
6. Execute task work
7. Technical debt assessment
8. Execute Code review
9. Finalize Task status

## 1 · Analyse scope from argument

<$ARGUMENTS> ⇒ Task ID, Sprint ID, or empty (select next open task in current sprint).

## 2 · Identify task file

Search .simone/03_SPRINTS/ and .simone/04_GENERAL_TASKS/.
If no open task matches, pause and ask the user how to proceed.

## 3 · Analyse the task

Read the task description. If anything is unclear, ask clarifying questions before continuing.

**PERSONA ACTIVATION:** Analyze task content for automatic persona activation:

1. **Scan task description** for domain-specific keywords:
   - Security: authentication, authorization, encryption, validation, privacy, OWASP
   - Architecture: system design, scalability, patterns, integration, structure
   - Frontend: UI, UX, component, interface, accessibility, user experience
   - Backend: API, database, server, microservices, performance
   - QA: testing, quality, validation, verification, coverage

2. **Apply relevant personas automatically** or honor explicit persona flags from user
3. **If `--introspect` flag present**: Show 🤔 Thinking process for persona selection
4. **If multiple personas activated**: Plan multi-domain analysis approach

**MCP INTEGRATION:** Use available MCP servers to enhance task analysis:
- **Sequential Thinking**: Use `/mcp__serena__think_about_collected_information` and `/mcp__serena__think_about_task_adherence` for structured analysis
- **Serena**: Use `/mcp__serena__get_symbols_overview`, `/mcp__serena__find_symbol`, and `/mcp__serena__find_referencing_symbols` for enhanced code analysis and project understanding  
- **Context7**: Maintain context about project state and requirements
- **GitHub**: Use GitHub MCP for repository insights and issue/PR management when relevant
- **Fetch**: Use Fetch MCP to retrieve external documentation and resources when needed

**CRITICAL CONTEXT VALIDATION:** Before executing any task spin up Parallel Subagents for these tasks:

1. **Sprint Context:** Confirm task belongs to current sprint scope
2. **Dependencies:** Check if any dependent tasks need to be completed first
3. **Requirements:** Read relevant requirements docs in `.simone/02_REQUIREMENTS/`
4. **Scope Verification:** Ensure task aligns with current sprint objectives

**IMPORTANT:** If task references functionality from future sprints or has unmet dependencies, pause and ask for clarification.

## 4 · Create and switch to task branch

**Git Branch Management:**

**Branch Creation Process:**
1. **Check Current Git Status:**
   - Run `git status` to check for uncommitted changes
   - If uncommitted changes exist, pause and ask user how to proceed
   - Options: commit changes, stash changes, or abort task start

2. **Ensure Clean Working Directory:**
   - If on feature branch, check if it should be merged first
   - Switch to main/master branch as starting point
   - Pull latest changes: `git pull origin main`

3. **Generate Branch Name:**
   - **For Sprint Tasks**: `task/t##-s##`
   - **For General Tasks**: `task/t###`
   - **Examples**: 
     - `task/t01-s02`
     - `task/t003`
   - Use task ID and milestone ID only (no title or description)

4. **Create and Switch Branch:**
   - Create branch: `git checkout -b <branch_name>`
   - Verify branch creation: `git branch --show-current`
   - **CRITICAL**: If branch already exists, append timestamp: `-YYYYMMDD-HHMM`

5. **Update Task Metadata:**
   - Add `git_branch: "<branch_name>"` to task YAML frontmatter
   - Log branch creation in Output Log: `[YYYY-MM-DD HH:MM] Created and switched to branch: <branch_name>`

**Error Handling:**
- If git commands fail, provide clear error messages
- If repository is not clean, guide user through resolution
- If branch creation fails, fall back to working on current branch but warn user

## 5 · Set status to in_progress

**Metadata Update:**
- Find out the current local timestamp (YYYY-MM-DD HH:MM)
- Update YAML frontmatter with comprehensive status change:
  - **status**: "in_progress"
  - **updated_date**: Current timestamp
  - **assignee**: "Claude" (if not already set)
  - Initialize **actual_effort**: "0" (if not already tracking)
- Update header status line: **Status**: in_progress
- Update ./simone/00_PROJECT_MANIFEST.md to set task in progress, updated time and current Sprint Status
- Log status change in Output Log: `[YYYY-MM-DD HH:MM] Task started - status changed to in_progress`

## 6 · Execute task work

**PERSONA-DRIVEN IMPLEMENTATION:** Apply domain expertise throughout task execution:

**For each activated persona, provide specialized guidance:**
- **🏗️ Architecture Persona**: Validate system design patterns, ensure scalability considerations
- **🔒 Security Persona**: Enforce OWASP compliance, identify security vulnerabilities  
- **🎨 Frontend Persona**: Optimize user experience, ensure accessibility compliance
- **⚙️ Backend Persona**: Optimize API design, database performance, server efficiency
- **📊 Analyzer Persona**: Track code quality metrics, identify technical debt
- **🎓 Mentor Persona**: Provide educational guidance and best practices
- **🔧 Refactorer Persona**: Identify optimization opportunities, improve maintainability
- **⚡ Performance Persona**: Analyze bottlenecks, recommend optimizations
- **✅ QA Persona**: Ensure testing coverage, define quality gates

**INTROSPECTION MODE** (if `--introspect` flag present):
- Show 🤔 Thinking process for each major implementation decision
- Display 🎯 Decision rationale with persona-specific reasoning
- Provide 🔍 Analysis of trade-offs and alternatives considered
- Conclude with ✅ Final recommendation and next steps

**MCP INTEGRATION:** Leverage MCP servers during task execution:
- **Sequential Thinking**: Structure implementation approach step-by-step
- **Serena**: Get enhanced code analysis and suggestions
- **GitHub**: Log all task execution details and outcomes
- **Context7**: Maintain context about implementation decisions

- Follow Description, Goal and Acceptance Criteria.
- Consult supporting docs in .simone/01_PROJECT_DOCS/ and .simone/02_REQUIREMENTS/.
- **Progress Tracking**: Iterate over subtasks with comprehensive metadata updates:
  1. Pick the next incomplete subtask.
  2. Implement the required changes, consulting docs as needed.
  3. Mark the subtask done with [x].
  4. Update **actual_effort** in YAML frontmatter (estimate time spent).
  5. Update **updated_date** in YAML frontmatter with current timestamp.
  6. Append detailed log entry to **## Output Log**: `[YYYY-MM-DD HH:MM]: <subtask_completed> - <implementation_notes>`
  7. If issues encountered, update **blocked_by** field if applicable.
  8. Use **GitHub** to track implementation progress and decisions.
  9. **Update progress percentage** based on completed subtasks vs total.
  10. Repeat until all subtasks are complete.

## 7 · Technical Debt Assessment

**COMPREHENSIVE DEBT TRACKING:** Document any technical debt discovered or created during task implementation:

**MCP INTEGRATION:** Use available MCP servers for enhanced debt analysis:
- **Sequential Thinking**: Structure debt analysis systematically
- **Serena**: Enhance debt pattern recognition and categorization
- **GitHub**: Track debt accumulation patterns and resolution outcomes

### 7.1 · Debt Discovery Analysis

**Scan Implementation for Debt Items:**

1. **Code Quality Debt:**
   - **Duplicated Logic**: Look for copy-paste code that should be abstracted
   - **Complex Functions**: Functions exceeding reasonable complexity thresholds
   - **Poor Naming**: Variables, functions, or classes with unclear names
   - **Missing Error Handling**: Inadequate exception handling or validation
   - **Code Smells**: Anti-patterns that reduce maintainability

2. **Architecture Debt:**
   - **Design Violations**: Code that breaks established architectural patterns
   - **Tight Coupling**: Components with excessive interdependencies
   - **Missing Abstractions**: Repeated patterns that should be generalized
   - **Scalability Issues**: Designs that won't scale with growth

3. **Security Debt:**
   - **Input Validation**: Missing or insufficient input sanitization
   - **Authentication Gaps**: Weak authentication mechanisms
   - **Authorization Flaws**: Inadequate permission controls
   - **Data Exposure**: Sensitive data handling issues

4. **Performance Debt:**
   - **Inefficient Algorithms**: Suboptimal algorithm choices
   - **Database Issues**: Poor query performance or schema design
   - **Resource Leaks**: Memory, connection, or file handle leaks
   - **Missing Caching**: Areas where caching would be beneficial

5. **Documentation Debt:**
   - **Missing Documentation**: Undocumented code or systems
   - **Outdated Documentation**: Documentation that doesn't match implementation
   - **Missing Comments**: Complex logic without explanatory comments

6. **Testing Debt:**
   - **Test Coverage Gaps**: Missing unit, integration, or e2e tests
   - **Flaky Tests**: Tests that pass/fail inconsistently
   - **Missing Test Data**: Inadequate test scenarios or edge cases

### 7.2 · Debt Categorization and Impact Analysis

**For Each Identified Debt Item:**

1. **Assess Severity:**
   - **Critical**: Security vulnerabilities, production blockers, data corruption risks
   - **High**: Performance degradation, significant maintenance burden
   - **Medium**: Code maintainability issues, future scalability concerns
   - **Low**: Code clarity improvements, minor convention violations

2. **Evaluate Impact:**
   - **Development Velocity**: How this debt affects current and future development speed
   - **Maintenance Cost**: Additional time required for related changes
   - **Business Risk**: Potential business consequences if unaddressed
   - **Technical Risk**: Probability and impact of technical failures

3. **Calculate Risk Score:** (Likelihood × Impact, scale 1-25)

### 7.3 · Debt Logging Process

**If Debt Items Discovered:**

1. **Create Debt Items:**
   - Use `technical_debt_template.md` from `.simone/99_TEMPLATES/`
   - Generate unique TD_### ID (check existing items in `07_TECHNICAL_DEBT/ACTIVE/`)
   - Place in `.simone/07_TECHNICAL_DEBT/ACTIVE/`
   - Link to source task in debt metadata

2. **Update Task Documentation:**
   - Add technical debt assessment section to task Output Log
   - Reference created debt items: "Technical debt logged: TD_001, TD_002"
   - Include brief impact summary in task completion notes

3. **Update Debt Registry:**
   - Add new debt items to `.simone/07_TECHNICAL_DEBT/DEBT_REGISTRY.md`
   - Include categorization and priority information
   - Cross-reference with source task

### 7.4 · Conscious Debt Creation

**When Deliberately Creating Technical Debt:**

1. **Document Justification:**
   - Explain why the debt was created (time pressure, MVP scope, etc.)
   - Estimate future cost of resolution
   - Set target resolution timeframe

2. **Create Debt Item:**
   - Mark as "conscious debt" in metadata
   - Include business justification
   - Plan for future resolution

3. **Stakeholder Communication:**
   - Include debt creation in task summary
   - Highlight in PR description
   - Add to project risk tracking

### 7.5 · Debt Resolution Tracking

**If Task Addresses Existing Debt:**

1. **Update Debt Status:**
   - Change status from "active" to "resolved"
   - Move file to `.simone/07_TECHNICAL_DEBT/RESOLVED/`
   - Add resolution details to debt item

2. **Record Resolution Effort:**
   - Compare estimated vs actual resolution effort
   - Document approach taken and effectiveness
   - Note any follow-up work needed

3. **Update Metrics:**
   - Track debt resolution velocity
   - Measure impact improvement
   - Update project health indicators

### 7.6 · Integration with Code Review

**Prepare Debt Information for Review:**

- **Debt Summary**: Brief overview of debt items discovered or resolved
- **Impact Assessment**: Priority and business impact of new debt
- **Resolution Plan**: Timeline and approach for addressing critical/high debt
- **Review Focus**: Alert reviewers to debt-related changes or decisions

**Example Debt Assessment Output:**
```markdown
## Technical Debt Assessment

### Debt Discovered:
- **TD_042** (Medium): Duplicate validation logic in user service - estimated 3h to resolve
- **TD_043** (Low): Missing error handling in payment processor - estimated 1h to resolve

### Conscious Debt Created:
- **TD_044** (High): Simplified authentication for MVP - requires proper OAuth implementation (8h effort)
  - **Justification**: MVP deadline requires basic auth, full OAuth planned for Sprint 3
  - **Risk**: Limited user security, higher support overhead
  - **Target Resolution**: Sprint 3 (2 weeks)

### Debt Resolved:
- **TD_028**: Removed duplicate database queries (was 4h effort, actual 3.5h)

### Impact Summary:
- New debt added: 2 items (12h total effort)
- Debt resolved: 1 item (3.5h effort)
- Net debt change: +8.5h effort
- Critical/High items requiring immediate attention: 1 (TD_044)
```

## 8 · Execute Code Review

Follow these steps for a Code Review (in order)

- include @.claude/commands/simone/code_review.md and use the Task ID as Scope.
- Follow the instructions in the file to run a code review in **PARALLEL SUBAGENTS**
- When done continue acting on the results accordingly
- Understand and think about the results
- on **FAIL**
  - thoroughly understand the problem
  - extend the Current Task with the Subtasks identified by the review
  - go back to "6 · Execute task work"
- on **PASS**
  - move on to next step

## 9 · Guided Task Completion with Approval Gates

**MCP INTEGRATION:** Complete task tracking and logging:
- **GitHub**: Log final task completion and outcomes via commit history and repository tracking
- **Context7**: Store task completion context for future reference
- **Serena**: Use `/mcp__serena__think_about_whether_you_are_done` and `/mcp__serena__summarize_changes` for completion validation
- **Sequential Thinking**: Structure completion validation and ensure all steps completed

**TASK EXECUTION LOGGING:** All logging happens in the task file itself via Output Log sections (Implementation Log, Decision Log, Issue Log) and YAML frontmatter updates managed by update_task_status command.

**GUIDED WORKFLOW WITH USER CONTROL:**

### 9.1 · Review Implementation Results

**Display Implementation Summary:**
- **Task Context**: Show task ID, title, and original scope
- **Changed Files**: List all modified/created files with brief descriptions
- **Acceptance Criteria**: Confirm all criteria marked as complete
- **Quality Checklist**: Verify all quality items addressed
- **Time Tracking**: Compare estimated vs actual effort

### 9.2 · Approval Gate: Commit Review

**Present Commit Proposal to User:**

```markdown
## 📋 Ready to Commit Task Implementation

**Task**: {TASK_ID} - {task_title}
**Branch**: {current_branch}
**Status**: Implementation complete, ready for commit

**Files to be committed:**
{list_changed_files_with_descriptions}

**Proposed commit message:**
{conventional_commit_format_with_task_id}

**Quality verification:**
✅ All acceptance criteria met
✅ Code review passed
✅ Documentation updated
✅ Tests passing (if applicable)

**Approve commit? (y/n/modify)**
```

**Handle User Response:**
- **Yes**: Proceed to execute commit
- **No**: Allow user to make additional changes
- **Modify**: Let user adjust commit message or file selection
- **Skip**: Leave changes uncommitted for manual handling

### 9.3 · Execute Approved Commit

**If User Approved:**
1. **Auto-execute**: `/project:simone:commit {TASK_ID} yolo`
2. **Verify Success**: Confirm commit creation with SHA
3. **Update Task Metadata**: Add commit SHA to task YAML frontmatter
4. **Log Entry**: Add commit details to task Output Log

### 9.4 · Approval Gate: PR Creation Review

**Present PR Proposal to User:**

```markdown
## 🔀 Ready to Create Pull Request

**Current Status:**
✅ Changes committed to branch: {branch_name}
✅ Task implementation complete
✅ Ready for team review

**Proposed PR Details:**
**Title**: {pr_title_with_task_id}
**Target Branch**: {target_branch}
**Reviewers**: {auto_assigned_reviewers}
**Labels**: {suggested_labels}

**PR Description Preview:**
{auto_generated_pr_description}

**Create this PR? (y/n/modify/skip)**
```

**Handle User Response:**
- **Yes**: Create PR as proposed
- **No/Skip**: Leave branch ready for manual PR creation
- **Modify**: Adjust title, description, reviewers, or target branch

### 9.5 · Execute Approved PR Creation

**If User Approved:**
1. **Auto-execute**: `/project:simone:create_pr {TASK_ID}`
2. **Link PR**: Add PR URL to task metadata
3. **Update Status**: Change task status from "completed" to "review"
4. **Update Manifest**: Reflect PR creation in project tracking

### 9.6 · Final Workflow Summary

**COMPLETION REPORT:**

```markdown
✅ **Task Workflow Complete**: {TASK_ID}

🔧 **Implementation**: All acceptance criteria met
💾 **Committed**: {commit_sha} - Ready for integration  
🔀 **PR Created**: #{pr_number} - Awaiting team review
📋 **Status**: completed → review

⏭️ **Next Steps**:
- PR will be reviewed by assigned team members
- Address any review feedback if needed
- Use `/project:simone:merge {TASK_ID}` when approved
- Monitor PR for review comments and CI status

🎯 **Success Metrics**:
- Estimated: {estimated_effort}h
- Actual: {actual_effort}h  
- Efficiency: {efficiency_percentage}%

🧹 **Cleanup**: Use `/clear` to clear context before next task
```

**Benefits of This Approach:**
- 🛡️ **User Control**: Developer reviews each step before execution
- 🔍 **Quality Assurance**: Chance to verify implementation quality
- ✏️ **Flexibility**: Can modify commit messages, PR details, or scope
- 🎯 **Transparency**: Clear visibility into what's happening at each step
- 🚫 **Reversibility**: Can abort or modify at any checkpoint
