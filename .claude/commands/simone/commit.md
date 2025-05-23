# Analyze changes and create logical git commits with user confirmation

Follow these instructions from top to bottom.

## Create a TODO with EXACTLY these 6 items

1. Parse arguments and analyze git status
2. Review changes and group by logical commits
3. Propose commit structure and messages
4. Get user confirmation for each commit
5. Execute approved commits
6. Report commit results

---

## 1 · Analyze git status and parse arguments

- Run these commands in parallel for maximum efficiency: `git status`, `git diff --staged`, `git diff`
- List all changed files with their folder structure to understand the scope
- If arguments are provided in <$ARGUMENTS>, **think carefully** about what the user means:
  - Look at the changed files list and think about which ones match the argument
  - Consider the semantic meaning - what would this argument mean for this project?
  - Be SPECIFIC about which files you believe the argument refers to
- If arguments specify a focus, confirm: "I interpreted '$ARGUMENTS' as referring to these files: [list files]. Is this correct?"
- If no clear matches found, ask: "I couldn't find specific files matching '$ARGUMENTS'. Could you clarify which files you want to commit?"
- If arguments specify a focus, ONLY analyze changes related to that focus
- If no arguments provided, analyze all changes

## 2 · Review changes and group by logical commits

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

For the next commit to create:

- **Files**: List the specific files to be included
- **Commit message**: Use conventional commit format, be clear and concise
  - **CRITICAL:** Must not contain any attribution to Claude, Anthropic, or AI assistance
- **Reasoning**: Brief explanation of why these changes belong together

## 4 · Get user confirmation for FIRST commit only

For the first/next proposed commit:

- Show the complete commit plan including files and message
- Wait for explicit user confirmation before proceeding
- If user says no, ask what should be changed
- If user wants to modify the commit message or scope, make adjustments

## 5 · Execute approved commit and continue

For the approved commit:

- Stage the specified files with `git add`
- Create the commit with the approved message
- Verify commit was created successfully
- **IMPORTANT:** If there are more commits remaining, return to step 3 for the next commit
- Only proceed to step 6 when all commits are completed

## 6 · Report commit results

Provide summary:

- **Commits Created**: List each commit with SHA and message
- **Files Committed**: Total count of files committed
- **Remaining Changes**: Any uncommitted changes still pending
- **Repository Status**: Current git status after commits
