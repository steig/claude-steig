# Project Review - Execute top to bottom

Perform a comprehensive project-level review focusing on architecture, progress, and technical decisions.

**IMPORTANT:**

- This is a high-level review of overall project state, not recent changes.
- Unless clearly mentioned in project documents, there is no timeline and schedule is irrelevant

## Create a TODO with EXACTLY these 8 Items

1. Analyze review scope and timing
2. Assess project documentation alignment
3. Review milestone and sprint progress
4. Analyze codebase architecture and structure
5. Audit file organization and workflow compliance
6. Evaluate technical decisions and complexity
7. Critique implementation quality (John Carmack perspective)
8. Provide comprehensive assessment with recommendations

Follow step by step and adhere closely to the following instructions for each step.

## DETAILS on every TODO item

### 1. Analyze review scope and timing

Check: <$ARGUMENTS>

If empty, perform full project review. Otherwise interpret <$ARGUMENTS> to identify specific focus areas (milestone, sprint, architecture component, etc.). Unless stated in Argument do not compare to previews project reviews in `.simone/10_STATE_OF_PROJECT`.

**IMPORTANT:** This review looks at overall project state, not just recent changes.

**CRITICAL:** Read `.simone/00_PROJECT_MANIFEST.md` FIRST to understand:

- Current milestone and sprint status
- What work is complete vs in-progress vs planned
- Active sprint objectives and deliverables

**CONTEXT CHECK:** Before evaluating functionality:

- Navigate to `.simone/03_SPRINTS/` to find the current sprint
- Read the sprint meta file to understand what's in scope
- Check completed vs planned tasks within the sprint
- Understand what future sprints will deliver

**REVIEW PRINCIPLE:** Evaluate against CURRENT SPRINT deliverables, not full milestone scope.

### 2. Assess project documentation alignment

- READ all core documents in `.simone/01_PROJECT_DOCS/` especially ARCHITECTURE.md
- READ current milestone requirements in `.simone/02_REQUIREMENTS/`
- IDENTIFY any gaps between documentation and current implementation
- CHECK if the project is still following the documented architecture vision
- VERIFY that current code structure matches documented patterns

**IMPORTANT:** Documentation is our source of truth. Any deviation needs justification.

### 3. Review milestone and sprint progress

- READ `.simone/00_PROJECT_MANIFEST.md` for current status
- ANALYZE completed sprints in `.simone/03_SPRINTS/`
- COMPARE actual progress against CURRENT SPRINT deliverables (not full milestone)
- DISTINGUISH between sprint-level tasks vs milestone-level features
- ASSESS if current sprint focus aligns with milestone goals

**CRITICAL SPRINT-BASED EVALUATION:**

- Compare against CURRENT SPRINT deliverables ONLY
- Identify what's intentionally deferred to future sprints
- DO NOT criticize missing functionality planned for later sprints
- Distinguish "sprint incomplete" from "milestone incomplete"
- Focus on sprint deliverable quality, not missing future features

**INFRASTRUCTURE-FIRST CONTEXT:** Missing AI features during S01 infrastructure phase is expected and appropriate.

### 4. Analyze codebase architecture and structure

- EXAMINE overall project structure and organization
- ANALYZE import patterns and dependency relationships
- REVIEW database models and API structure for consistency
- CHECK for architectural patterns: are we following DDD, clean architecture, etc.?
- IDENTIFY any architectural debt or inconsistencies

**Focus areas:**

- **Directory structure** — logical organization, separation of concerns
- **Dependencies** — are we over-engineering? unnecessary libraries?
- **Models/Schemas** — consistency, proper relationships, normalization
- **APIs** — RESTful design, proper HTTP methods, consistent patterns
- **Configuration** — environment management, secrets handling

### 5. Audit file organization and workflow compliance

**IMPORTANT:** Check for workflow discipline and architectural boundary violations.

- **Root directory audit** — identify files that don't belong in project root
- **Development scripts** — verify all dev scripts follow `run_dev.py` pattern
- **Test file organization** — check tests are in `tests/` directory, not scattered
- **Documentation placement** — verify docs are in proper locations
- **Temporary/experimental files** — flag any `.py` files that look ad-hoc or experimental

**File Organization Rules to Enforce:**

- **Development scripts** — MUST go through `run_dev.py`, not standalone files
- **Test files** — MUST be in `tests/` directory with proper naming (`test_*.py`)
- **Documentation** — MUST be in `docs/` or `.simone/01_PROJECT_DOCS/`
- **Configuration** — MUST follow established patterns (`.env.example`, `pyproject.toml`)
- **Temporary files** — SHOULD NOT exist in committed code

**Red Flags to Identify:**

- Multiple scripts doing similar things (duplicate functionality)
- Random `.py` files in root directory
- Test files outside `tests/` directory
- Development scripts bypassing `run_dev.py`
- Unclear file purposes or experimental code

**CRITICAL:** File proliferation indicates workflow breakdown. Flag for immediate cleanup task creation.

### 6. Evaluate technical decisions and complexity

- ASSESS complexity vs. business value ratio
- REVIEW choice of frameworks, libraries, and tools
- ANALYZE if current patterns will scale with project growth
- IDENTIFY areas where we might be over-complicating simple problems
- CHECK for premature optimization or under-optimization

**IMPORTANT:** Think like an experienced developer. Are we solving the right problems the right way?

### 7. Critique implementation quality (John Carmack perspective)

Think as John Carmack would: focus on simplicity, performance, and maintainability.

- **Simplicity:** Are we solving problems in the most straightforward way?
- **Performance:** Are there obvious performance issues or bottlenecks?
- **Maintainability:** Will a new developer understand this code in 6 months?
- **Robustness:** How does the system handle edge cases and failures?
- **Technical debt:** What shortcuts are we taking that will hurt us later?

**IMPORTANT:** Be brutally honest. Carmack-level critique means no sugar-coating.

**IMPORTANT:** Be thorough and go above and beyond in your analysis - leave no stone unturned.

### 8. Provide comprehensive assessment with recommendations

**IMPORTANT:** Get current timestamp and create output file

- Get current timestamp using system date command
- Create filename: `YYYY-MM-DD-<judgment-slug>.md` in `.simone/10_STATE_OF_PROJECT/`
- Judgment slug should be 2-3 words describing overall project health (e.g., "solid-progress", "needs-focus", "critical-issues", "doing-great", "on-track")

**IMPORTANT:** Write full report to the timestamped file with this format:

```markdown
# Project Review - [Current Date]

## 🎭 Review Sentiment

[3 emojis only - no explanations]

## Executive Summary

- **Result:** EXCELLENT | GOOD | NEEDS_WORK | CRITICAL_ISSUES
- **Scope:** What areas were reviewed
- **Overall Judgment:** [2-3 word assessment used in filename]

## Development Context

- **Current Milestone:** [ID and status from manifest]
- **Current Sprint:** [ID and focus]
- **Expected Completeness:** [what SHOULD be done at this stage]

## Progress Assessment

- **Milestone Progress:** [percentage complete, timeline status]
- **Sprint Status:** [current sprint assessment]
- **Deliverable Tracking:** [what's done vs planned]

## Architecture & Technical Assessment

- **Architecture Score:** 1-10 rating with explanation
- **Technical Debt Level:** LOW | MEDIUM | HIGH with specific examples
- **Code Quality:** [overall assessment with examples]

## File Organization Audit

- **Workflow Compliance:** GOOD | NEEDS_ATTENTION | CRITICAL_VIOLATIONS
- **File Organization Issues:** [list any misplaced files, duplicate scripts, etc.]
- **Cleanup Tasks Needed:** [specific file moves/deletions/consolidations required]

## Critical Findings
### Critical Issues (Severity 8-10)

[Lists of must-fix problems headed with #### heading, one empty line and then list of details]

### Improvement Opportunities (Severity 4-7)

[List of recommended enhancements headed with #### heading, one empty line and then list of details]

## John Carmack Critique 🔥

[Top 3 brutally honest observations about technical decisions]

## Recommendations

- **Next Sprint Focus:** [what should be prioritized]
- **Timeline Impact:** [will current issues affect milestone delivery?]
- **Action Items:** [specific next steps]
```

**IMPORTANT:** Be specific with file paths and line numbers. This review should be actionable and permanently archived.
