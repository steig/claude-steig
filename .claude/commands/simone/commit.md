# Analyze changes and create logical git commits with user confirmation

**COGNITIVE PERSONAS INTEGRATION:** This command supports domain expertise for intelligent commit analysis and organization.

**Inspired by [SuperClaude](https://github.com/NomenAK/SuperClaude)** persona patterns for specialized AI assistance.

**AVAILABLE PERSONAS** (reference: `.claude/commands/shared/persona-flags.yml`):
- `--persona-architect`: Architecture-focused commit grouping and technical design changes
- `--persona-security`: Security-aware commit analysis and sensitive change detection
- `--persona-frontend`: Frontend-specific commit organization and UI/UX change grouping
- `--persona-backend`: Backend system commit structure and API change analysis
- `--persona-analyzer`: Code quality metrics and change impact analysis
- `--persona-mentor`: Educational commit messages and best practices enforcement
- `--persona-refactorer`: Refactoring-focused commit organization and cleanup grouping
- `--persona-performance`: Performance-impact commit analysis and optimization tracking
- `--persona-qa`: Testing-focused commit organization and quality assurance validation

**ADVANCED FLAGS:**
- `--introspect`: Show transparent reasoning for commit organization decisions
- `--consensus`: Multi-model consensus for complex commit organization
- `--think-deep`: Extended analysis for complex change sets

**USAGE EXAMPLES:**
- `/project:simone:commit T001 --persona-security` (Security-aware commit organization)
- `/project:simone:commit T001 --persona-architect --introspect` (Architecture changes with transparency)
- `/project:simone:commit BUG123 --persona-analyzer --persona-qa` (Bug fix with quality focus)

Follow these instructions from top to bottom.

## Create a TODO with EXACTLY these 6 items

1. Parse arguments and analyze git status
2. Review changes and group by logical commits
3. Propose commit structure and messages
4. Check if user approval is necessary
5. Execute approved commits
6. Report commit results

---

## 1 · Analyze git status and parse arguments

**MCP INTEGRATION:** Use MCP servers to enhance commit analysis:
- **Work History**: Track commit patterns and document commit reasoning
- **Sequential Thinking**: Structure logical commit grouping systematically
- **Serena**: Enhance code change analysis and commit message quality

- Run these commands in parallel for maximum efficiency: `git status`, `git diff --staged`, `git diff`, `git branch --show-current`
- List all changed files with their folder structure to understand the scope
- **Branch Context Analysis**: Check current branch name for automatic context detection:
  - If on `task/T##-S##-*` branch, automatically detect task context from branch name
  - If on `bug/BUG###-*` or `hotfix/BUG###-*` branch, automatically detect bug context
  - If context argument provided, verify it matches current branch context
  - If mismatch detected, warn user and ask how to proceed

**PERSONA ACTIVATION:** Analyze changes for automatic persona activation:

1. **Scan modified files and changes** for domain-specific patterns:
   - **Security**: Authentication, authorization, validation, encryption, access control
   - **Frontend**: UI components, styles, templates, user interfaces, accessibility
   - **Backend**: APIs, databases, services, middleware, server configuration
   - **Architecture**: Core system changes, design patterns, structural modifications
   - **Performance**: Optimization, caching, database queries, resource usage

2. **Apply relevant personas automatically** or honor explicit persona flags from user
3. **If `--introspect` flag present**: Show 🤔 Thinking process for persona selection and commit organization reasoning
4. **If multiple personas activated**: Plan multi-domain commit organization approach

### CRITICAL: Argument Interpretation Rules

**Context Provided** (when <$ARGUMENTS> contains text):

- If YOLO is part of the <$ARGUMENTS> it is meant to skip user Approval (see Step 4 on your Todo)
- The other text in <$ARGUMENTS> represents a **task ID**, **sprint ID**, or other **contextual identifier** provided by the user
- This is NOT a file path - it's a semantic context for filtering changes
- **PRIMARY FOCUS**: Only commit files directly related to this context
- **SECONDARY CONSIDERATION**: After handling the primary context, ask if user wants to commit other unrelated changes

**Task ID Pattern** (e.g., T01-S02, TX03-S01, T003):

- Sprint Tasks: `T<NN>-S<NN>` format (e.g., T01-S02, T03-S02)
- Completed Sprint Tasks: `TX<NN>-S<NN>` format (e.g., TX01-S02, TX03-S01)
- General Tasks: `T<NNN>` format (e.g., T001, T002)
- Completed General Tasks: `TX<NNN>` format (e.g., TX001, TX002)
- Search for this task ID in:
  - `.simone/03_SPRINTS/` directory (for sprint tasks)
  - `.simone/04_GENERAL_TASKS/` directory (for general tasks)
  - Task metadata in files (look for `task_id: T01-S02` in frontmatter)
  - Git diff content (to see if code comments or commits reference the task)
- Identify ALL files that were modified as part of this task's implementation
- This includes: source code, tests, configuration, and the task documentation file itself

**Bug ID Pattern** (e.g., BUG001, BUGX002):

- Bug Reports: `BUG<NNN>` format (e.g., BUG001, BUG002)
- Resolved Bug Reports: `BUGX<NNN>` format (e.g., BUGX001, BUGX002)
- Search for this bug ID in:
  - `.simone/06_BUGS/` directory (for bug reports)
  - Bug metadata in files (look for `bug_id: BUG001` in frontmatter)
  - Associated task files that reference the bug
  - Git diff content (to see if code comments or commits reference the bug)
- Identify ALL files that were modified as part of this bug fix
- This includes: source code, tests, bug report updates, and associated task files

**Sprint ID Pattern** (e.g., S01, SX02):

- Active Sprints: `S<NN>` format (e.g., S01, S02)
- Completed Sprints: `SX<NN>` format (e.g., SX01, SX02)
- When only sprint ID is provided, commit all changes related to ANY task within that sprint
- Search pattern: `T*-S<NN>` in the sprint directory
- Example: "S02" would include changes for T01-S02, T02-S02, T03-S02, etc.

**No Context Provided** (when <$ARGUMENTS> is empty):

- Analyze all changes and group them logically
- Propose separate commits for different logical units of work

### Implementation Steps

1. First, determine if <$ARGUMENTS> contains any text
2. If yes, explicitly state: "Context provided: '$ARGUMENTS' - I will focus on changes related to this context"
3. If it's a task ID pattern, find the task file and understand what was implemented
4. Filter the changed files to only those related to the identified context
5. If no files match the context, inform the user: "No changes found related to '$ARGUMENTS'"
6. If unrelated changes exist, mention them but DO NOT include in initial commit proposal

## 2 · Review changes and group by logical commits

### PRIORITY: Context Filtering

**If context provided in arguments**:

1. **FILTER FIRST**: Separate changes into two groups:
   - **Related to context**: Files that are part of the task/context implementation
   - **Unrelated to context**: Everything else
2. **FOCUS**: Only analyze the "related to context" group for the first commit
3. **DEFER**: Keep the "unrelated" group for potential later commits (only if user requests)

**Standard grouping logic** (for no-context or within-context grouping):

**PERSONA-DRIVEN COMMIT ORGANIZATION:**

**For each activated persona, apply specialized grouping criteria:**

- **🏗️ Architecture Persona**: Group by system components, architectural layers, and design pattern implementations
- **🔒 Security Persona**: Separate security-critical changes, group authentication/authorization changes together
- **🎨 Frontend Persona**: Group UI components, styles, and user experience changes by feature or component
- **⚙️ Backend Persona**: Group API changes, database modifications, and service updates by domain
- **📊 Analyzer Persona**: Group refactoring, code quality improvements, and metric enhancements
- **🎓 Mentor Persona**: Ensure commit messages are educational and group changes for learning clarity
- **🔧 Refactorer Persona**: Group cleanup, optimization, and maintenance changes separately from features
- **⚡ Performance Persona**: Group performance optimizations and separate from functional changes
- **✅ QA Persona**: Group test additions/changes with related functionality, validate test coverage

**INTROSPECTION MODE** (if `--introspect` flag present):
- Show 🤔 Thinking process for commit organization decisions
- Display 🎯 Decision rationale for each grouping choice
- Provide 🔍 Analysis of dependencies and logical separation
- Conclude with ✅ Final commit structure reasoning

**Standard logic** (always applied):
- **Think about** which changes belong together logically:
  - Task completion (group by task ID when applicable)
  - Feature additions (group by feature scope)
  - Configuration updates (group separately)
  - Documentation updates (group by documentation type)
  - Bug fixes (group by related functionality)
- **Think carefully** to ensure each commit represents one logical change that can be understood and potentially reverted independently
- Avoid mixing unrelated changes in the same commit
- Consider dependencies between changes when ordering commits

## 3 · Propose commit

### Context-Aware Commit Proposal

**When context was provided** (e.g., task ID):

- **FIRST COMMIT**: Must contain ONLY files related to the provided context
- State clearly: "This commit includes changes for $ARGUMENTS"
- After this commit is done, then ask: "There are also unrelated changes in [list files]. Would you like me to create additional commits for these?"

**When no context provided**:

- Propose commits based on logical grouping of all changes

For the next commit to create:

- **Context**: If applicable, which task/context this commit addresses
- **Files**: List the specific files to be included
- **Commit message**: Use conventional commit format, be clear and concise
  - **CRITICAL:** Must not contain any attribution to Claude, Anthropic, or AI assistance
  - **Task-related commits**: Include task ID in message (e.g., "feat(auth): implement t01-s02 user authentication" or "refactor(api): optimize t003 response handling")
  - **Bug fix commits**: Include bug ID in message (e.g., "fix(login): resolve bug001 validation error" or "hotfix(security): patch bug002 authentication bypass")
  - **Branch Context**: Use conventional commit types that match the work being done:
    - `feat:` for new features (task branches)
    - `fix:` for bug fixes (bug branches)
    - `hotfix:` for critical fixes (hotfix branches)
    - `refactor:` for code improvements
    - `docs:` for documentation updates
    - `test:` for test additions/updates
- **Reasoning**: Brief explanation of why these changes belong together

## 4 · Check if user approval is necessary

If YOLO **IS** part of the <$ARGUMENTS> skip this and jump to next step.

Otherwise ask the User for approval.

- Show the complete commit plan including files and message
- Wait for explicit user confirmation before proceeding
- If user says no, ask what should be changed
- If user wants to modify the commit message or scope, make adjustments

## 5 · Execute approved commit and continue

For the approved commit:

- Stage the specified files with `git add`
- **IMPORTANT:** We are using pre-commit hooks that will likely report shortcomings. You need to fix them. Don't skip validation unless there are open tasks adressing especially these problems.
- **Create the commit** with the approved message
- Verify commit was created successfully
- **IMPORTANT:** If there are more commits remaining, return to step 3 for the next commit
- Only proceed to step 6 when all commits are completed

## 6 · Report commit results

Provide summary:

- **Commits Created**: List each commit with SHA and message
- **Files Committed**: Total count of files committed
- **Remaining Changes**: Any uncommitted changes still pending
- **Repository Status**: Current git status after commits

**Next Steps Suggestions:**
- If on feature/task branch: Consider `/project:simone:create_pr [TASK_ID/BUG_ID]` to create pull request (coming soon)
- If task/bug work is complete: Consider updating task/bug status to "completed" 
- If working on multiple commits: Continue with additional commits for remaining changes
- If ready for review: Push branch to remote for code review
