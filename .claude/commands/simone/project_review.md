# Project Review - Execute top to bottom

Perform a comprehensive project-level review focusing on architecture, progress, and technical decisions.

**IMPORTANT:**

- This is a high-level review of overall project state, not recent changes.
- Unless clearly mentioned in project documents, there is no timeline and schedule is irrelevant

## Create a TODO with EXACTLY these 10 Items

1. Analyze review scope and timing
2. Execute and assess test infrastructure health
3. Assess project documentation alignment
4. Review milestone and sprint progress
5. Analyze codebase architecture and structure
6. Audit file organization and workflow compliance
7. Evaluate technical decisions and complexity
8. Assess technical debt accumulation and management
9. Critique implementation quality (John Carmack perspective)
10. Create comprehensive project review file with metadata

Follow step by step and adhere closely to the following instructions for each step.

## DETAILS on every TODO item

### 1. Analyze review scope and timing

**MCP INTEGRATION:** Use MCP servers to enhance project review:
- **Sequential Thinking**: Structure comprehensive project analysis systematically
- **Context7**: Maintain context about project evolution and architectural decisions
- **Work History**: Track review outcomes and recommendations over time
- **Serena**: Enhance project analysis and architecture assessment

Check: <$ARGUMENTS>

If empty, perform full project review. Otherwise interpret <$ARGUMENTS> to identify specific focus areas (milestone, sprint, architecture component, etc.). Unless stated in Argument do not compare to previews project reviews in `.simone/10_STATE_OF_PROJECT`.

**IMPORTANT:** This review looks at overall project state in context of recent changes.

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

### 2. Execute and assess test infrastructure health

**CRITICAL:** Test infrastructure health is a BLOCKING criteria for sprint/milestone progression.

- USE test.md command to execute full test suite (@.claude/commands/simone/test.md)
- ANALYZE test results: passed/failed/skipped counts and failure categories
- CALCULATE test health score (0-10 scale):
  - 10: 100% pass rate, no infrastructure issues
  - 8-9: >95% pass rate, minor issues only
  - 6-7: 80-95% pass rate, some non-critical failures
  - 4-5: 60-80% pass rate, significant issues
  - 0-3: <60% pass rate, critical infrastructure problems
- CATEGORIZE failures:
  - Infrastructure: Import errors, missing modules
  - Configuration: Environment variables, database connections
  - Logic: Assertion failures, actual bugs
  - Flaky: Intermittent failures
- DETERMINE blocking status:
  - Score < 6: BLOCKS sprint progression
  - Score < 8: BLOCKS milestone completion
  - Score < 4: TRIGGERS emergency escalation
- IDENTIFY root causes of any infrastructure failures
- TRACK trend vs previous review (improvement/degradation)
- ASSESS test strategy validity for scope of the project. Tests should be pragmatic and help assuring functionality but not get in the way of development progress too much.

### 3. Assess project documentation alignment

**USE PARALLEL AGENTS** to follow these steps:

- READ all core documents in `.simone/01_PROJECT_DOCS/` especially ARCHITECTURE.md
- READ current milestone requirements in `.simone/02_REQUIREMENTS/`
- READ architecture decisions in `.simone/05_ARCHITECTURE_DECISIONS` as they might extend/contradict other documents
- IDENTIFY any gaps between documentation and current implementation
- CHECK if the project is still following the documented architecture vision
- VERIFY that current code structure matches documented patterns

**IMPORTANT:** Documentation is our source of truth. Any deviation needs justification.

### 4. Review milestone and sprint progress

**USE PARALLEL AGENTS** to follow these steps:

- READ `.simone/00_PROJECT_MANIFEST.md` for current status
- ANALYZE completed sprints in `.simone/03_SPRINTS/`
- COMPARE actual progress against CURRENT SPRINT deliverables (not full milestone)
- DISTINGUISH between sprint-level tasks vs milestone-level features
- ASSESS if current sprint focus aligns with milestone goals

### 5. Analyze codebase architecture and structure
#
**USE PARALLEL AGENTS** to follow these steps:

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

### 6. Audit file organization and workflow compliance

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

### 7. Evaluate technical decisions and complexity

- ASSESS complexity vs. business value ratio
- REVIEW choice of frameworks, libraries, and tools
- ANALYZE if current patterns will scale with project growth
- IDENTIFY areas where we might be over-complicating simple problems
- CHECK for premature optimization or under-optimization

**IMPORTANT:** Think like an experienced developer. Are we solving the right problems the right way?

### 8. Assess technical debt accumulation and management

**COMPREHENSIVE TECHNICAL DEBT ANALYSIS:**

**MCP INTEGRATION:** Leverage MCP servers for debt analysis:
- **Sequential Thinking**: Structure debt assessment systematically
- **Serena**: Enhance debt pattern recognition and impact analysis
- **Work History**: Track debt accumulation trends over time

#### 8.1 · Technical Debt Inventory

**Analyze Current Debt Status:**

1. **Review Debt Registry:**
   - Read `.simone/07_TECHNICAL_DEBT/DEBT_REGISTRY.md` if exists
   - Count active debt items by category and severity
   - Assess debt resolution velocity vs. creation rate

2. **Scan Active Debt Items:**
   - Review all files in `.simone/07_TECHNICAL_DEBT/ACTIVE/`
   - Categorize by type: code quality, architecture, security, performance, documentation, testing
   - Assess severity distribution: critical, high, medium, low

3. **Review Resolved Debt:**
   - Check `.simone/07_TECHNICAL_DEBT/RESOLVED/` for resolution patterns
   - Calculate average resolution time by category
   - Identify most effective resolution strategies

#### 8.2 · Debt Impact Assessment

**Evaluate Business and Technical Impact:**

1. **Development Velocity Impact:**
   - Quantify how debt is affecting sprint completion rates
   - Identify debt items blocking specific features or improvements
   - Assess cumulative effect on team productivity

2. **Maintenance Cost Analysis:**
   - Calculate time overhead for working around debt items
   - Identify areas requiring disproportionate maintenance effort
   - Assess cognitive load impact on team members

3. **Risk Assessment:**
   - Identify critical debt items posing security or stability risks
   - Assess probability of debt-related failures or incidents
   - Evaluate technical risk exposure across system components

#### 8.3 · Debt Trend Analysis

**Track Debt Accumulation Patterns:**

1. **Creation vs Resolution Rate:**
   - Compare new debt items created vs. resolved over time
   - Identify sprints or milestones with highest debt accumulation
   - Track debt "interest" - compound effects of unaddressed debt

2. **Category Distribution:**
   - Analyze which debt categories are growing fastest
   - Identify recurring debt patterns (architectural, security, etc.)
   - Assess team strengths/weaknesses based on debt types

3. **Sprint Integration:**
   - Review how well debt resolution is integrated into sprint planning
   - Assess balance between feature development and debt resolution
   - Identify opportunities for preventive debt management

#### 8.4 · Strategic Debt Management

**Evaluate Debt Management Strategy:**

1. **Prioritization Effectiveness:**
   - Review criteria used for debt prioritization
   - Assess alignment between debt severity and resolution order
   - Identify high-impact, low-effort debt resolution opportunities

2. **Team Awareness:**
   - Evaluate team understanding of debt impact and cost
   - Assess debt visibility in project planning and decision-making
   - Review debt communication and documentation quality

3. **Prevention Measures:**
   - Identify root causes of debt creation
   - Assess effectiveness of code review in preventing debt
   - Evaluate tooling and processes for debt detection

#### 8.5 · Debt Metrics and Scoring

**Calculate Technical Debt Health Score (1-10):**

- **10**: Minimal debt, excellent management, proactive prevention
- **8-9**: Low debt load, good resolution velocity, minor issues
- **6-7**: Moderate debt, balanced creation/resolution, manageable impact
- **4-5**: High debt load, resolution lagging, noticeable impact
- **1-3**: Critical debt accumulation, system health at risk

**Key Metrics to Track:**
- Active debt count by severity
- Average age of debt items
- Resolution velocity (items/sprint)
- Debt-to-feature ratio in sprints
- Team effort spent on debt vs. features

### 9. Critique implementation quality (John Carmack perspective)

Think as John Carmack would: focus on simplicity, performance, and maintainability, but keep the projects goal in mind. Especially long term vision as well. Don't over simplify.

- **Simplicity:** Are we solving problems in the most straightforward way?
- **Performance:** Are there obvious performance issues or bottlenecks?
- **Maintainability:** Will a new developer understand this code in 6 months?
- **Robustness:** How does the system handle edge cases and failures?
- **Technical debt:** What shortcuts are we taking that will hurt us later?

Be **brutally honest**. Carmack-level critique means no sugar-coating but still staying true to the project's reality.
Be thorough and **go above and beyond** in your analysis - leave no stone unturned.

### 10. Provide comprehensive assessment with recommendations

**IMPORTANT:** Get current timestamp and create output file

- Get current timestamp using system date command
- Create filename: `YYYY-MM-DD-HH-MM-<judgment-slug>.md` in `.simone/10_STATE_OF_PROJECT/`
- Judgment slug should be 2-3 words describing overall project health (e.g., "solid-progress", "needs-focus", "critical-issues", "doing-great", "on-track")

**IMPORTANT:** Write full report to the timestamped file with this format:

```markdown
# Project Review - [YYYY-MM-DD HH:MM]

## 🎭 Review Sentiment

[3 emojis only - no explanations]

## Executive Summary

- **Result:** EXCELLENT | GOOD | NEEDS_WORK | CRITICAL_ISSUES
- **Scope:** What areas were reviewed
- **Overall Judgment:** [2-3 word assessment used in filename]

## Test Infrastructure Assessment

- **Test Suite Status**: [PASSING/FAILING/BLOCKED] (X/Y tests)
- **Test Pass Rate**: X% (Y passed, Z failed)
- **Test Health Score**: X/10
- **Infrastructure Health**: [HEALTHY/DEGRADED/BROKEN]
  - Import errors: [count]
  - Configuration errors: [count]
  - Fixture issues: [count]
- **Test Categories**:
  - Unit Tests: X/Y passing
  - Integration Tests: X/Y passing
  - API Tests: X/Y passing
- **Critical Issues**:
  - [List of blocking test infrastructure problems]
  - [Module import mismatches]
  - [Environment configuration failures]
- **Sprint Coverage**: [% of sprint deliverables with passing tests]
- **Blocking Status**: [CLEAR/BLOCKED - reason]
- **Recommendations**:
  - [Immediate fixes required]
  - [Test infrastructure improvements needed]

## Development Context

- **Current Milestone:** [ID and status from manifest]
- **Current Sprint:** [ID and focus]
- **Expected Completeness:** [what SHOULD be done at this stage]

## Progress Assessment

- **Milestone Progress:** [percentage complete]
- **Sprint Status:** [current sprint assessment]
- **Deliverable Tracking:** [what's done vs planned]

## Architecture & Technical Assessment

- **Architecture Score:** 1-10 rating with explanation
- **Technical Debt Health Score:** 1-10 rating with breakdown by category
- **Technical Debt Level:** LOW | MEDIUM | HIGH | CRITICAL with specific examples
- **Active Debt Items:** [count by severity: critical/high/medium/low]
- **Debt Resolution Velocity:** [items resolved per sprint vs. created]
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

Based on your findings recommend Action items - chose whatever fits your findings

- **Important fixes:** What needs to be fixed immediately?
- **Optional fixes/changes:** What would still be recommended though optional?
- **Next Sprint Focus:** Can the user move to the next sprint?

```

### 9. Create comprehensive project review file

**Review File Creation:**

1. **Use Template:**
   - Copy `.simone/99_TEMPLATES/project_review_template.md`
   - Create timestamped file: `.simone/10_STATE_OF_PROJECT/YYYY-MM-DD_HH-MM_Project_Review.md`

2. **Populate YAML Frontmatter:**
   - **review_id**: "PR_YYYY_MM_DD_HH_MM"
   - **title**: "Project Health Review - {Current_Milestone}"
   - **review_type**: "comprehensive" (or focus area if specified)
   - **date**: Current timestamp (YYYY-MM-DD)
   - **reviewed_by**: "Claude"
   - **milestone_id**: Current milestone from manifest
   - **sprint_id**: Current sprint if applicable
   - **project_health**: "healthy" | "warning" | "critical"
   - **overall_score**: 1-10 rating
   - **technical_debt_health_score**: 1-10 rating
   - **technical_debt_level**: "low" | "medium" | "high" | "critical"
   - **active_debt_count**: Total number of active debt items
   - **debt_by_severity**: {"critical": 0, "high": 0, "medium": 0, "low": 0}
   - **risk_level**: "low" | "medium" | "high" | "critical"
   - **review_scope**: ["architecture", "progress", "quality", "infrastructure"]
   - **next_review_date**: Recommended next review date
   - **action_items_count**: Number of critical action items identified

3. **Populate All Template Sections:**
   - **Executive Summary** with key findings
   - **Technical Assessment** with architecture analysis
   - **Progress Analysis** with milestone/sprint status
   - **Quality Metrics** with specific measurements
   - **Risk Assessment** with identified risks and mitigations
   - **Recommendations** with prioritized action items
   - **Historical Context** comparing to previous reviews if available

4. **Link Integration:**
   - Update `.simone/00_PROJECT_MANIFEST.md` with reference to new review
   - Cross-reference any identified issues with existing tasks or ADRs

**IMPORTANT:** Be specific with file paths and line numbers. This review should be actionable and permanently archived with full metadata tracking.
