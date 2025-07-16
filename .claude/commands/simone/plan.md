# Plan - Strategic Feature and Implementation Planning

**COGNITIVE PERSONAS INTEGRATION:** This command supports domain expertise enhancement.

**AVAILABLE PERSONAS** (reference: `.claude/commands/shared/persona-flags.yml`):
- `--persona-architect`: System architecture and design planning
- `--persona-pm`: Project management and milestone planning
- `--persona-qa`: Quality assurance and testing strategy planning
- `--persona-security`: Security implementation planning
- `--persona-performance`: Performance optimization planning

**ADVANCED FLAGS:**
- `--introspect`: Show transparent planning reasoning process
- `--consensus`: Multi-model consensus on planning approach
- `--think-deep`: Extended planning with comprehensive analysis

**PLANNING TYPES:**
- `--type-feature`: Plan new feature implementation
- `--type-refactor`: Plan refactoring and improvement initiatives
- `--type-migration`: Plan technology or architecture migration
- `--type-integration`: Plan system integration or API development

## Create a TODO with EXACTLY these 10 Items

1. Parse planning requirements and define project scope
2. Analyze existing codebase and architectural constraints
3. Research technical requirements and implementation approaches
4. Design high-level architecture and component structure
5. Break down implementation into manageable milestones
6. Identify dependencies, risks, and potential blockers
7. Estimate effort and timeline for each milestone
8. Create detailed task breakdown with acceptance criteria
9. Generate comprehensive implementation plan
10. Output structured milestones and tasks using templates

## DETAILS on every TODO item

### 1. Parse planning requirements and define project scope

**MCP INTEGRATION:** Sequential Thinking for systematic planning approach

Check: <$ARGUMENTS>

**Scope Definition:**
- EXTRACT feature or project requirements from user input
- DEFINE clear success criteria and acceptance criteria
- IDENTIFY stakeholders and user impact
- ESTABLISH project boundaries and constraints

### 2. Analyze existing codebase and architectural constraints

**MCP INTEGRATION:** Serena + Context7 for comprehensive codebase analysis

**Serena MCP Usage:**
- Use `/mcp__serena__get_symbols_overview` to understand current architecture
- Use `/mcp__serena__find_symbol` to locate existing components
- Use `/mcp__serena__find_referencing_symbols` to analyze dependencies

**MCP INTEGRATION:** Context7 for understanding current system state

**Codebase Analysis:**
- EXAMINE existing architecture and design patterns
- IDENTIFY integration points and extension opportunities
- ASSESS current technology stack and compatibility
- EVALUATE existing code quality and technical debt impact

### 3. Research technical requirements and implementation approaches

**MCP INTEGRATION:** Sequential Thinking + Context7 + Fetch for comprehensive research

**Fetch MCP Usage:**
- Use `WebFetch` to gather external documentation and best practices
- Research library documentation and API references
- Gather industry standards and implementation examples

**Technical Research:**
- INVESTIGATE implementation options and trade-offs using external resources
- RESEARCH required libraries, frameworks, or tools via Fetch MCP
- ANALYZE security, performance, and scalability requirements
- EVALUATE best practices for proposed implementation using fetched resources

### 4. Design high-level architecture and component structure

**MCP INTEGRATION:** Sequential Thinking for systematic design

**Architecture Design:**
- CREATE modular component breakdown
- DESIGN data flow and API interfaces
- PLAN database schema changes if required
- ESTABLISH security and error handling patterns

### 5. Break down implementation into manageable milestones

**MCP INTEGRATION:** Sequential Thinking for structured breakdown

**Milestone Planning:**
- GROUP related functionality into logical milestones
- ENSURE each milestone delivers valuable functionality
- PLAN incremental delivery and testing approach
- BALANCE milestone size for manageable implementation

### 6. Identify dependencies, risks, and potential blockers

**MCP INTEGRATION:** Sequential Thinking for risk analysis

**Risk Assessment:**
- IDENTIFY external dependencies and integration points
- ASSESS technical risks and mitigation strategies
- EVALUATE resource availability and skill requirements
- PLAN contingency approaches for major risks

### 7. Estimate effort and timeline for each milestone

**MCP INTEGRATION:** GitHub for historical estimation patterns

**Effort Estimation:**
- ESTIMATE development time for each milestone
- INCLUDE testing, review, and documentation time
- ACCOUNT for integration and deployment complexity
- PROVIDE confidence intervals for estimates

### 8. Create detailed task breakdown with acceptance criteria

**MCP INTEGRATION:** Sequential Thinking for systematic task creation

**Task Planning:**
- BREAK each milestone into specific, actionable tasks
- DEFINE clear acceptance criteria for each task
- ESTABLISH testing requirements and quality gates
- PLAN review and approval processes

### 9. Generate comprehensive implementation plan

**MCP INTEGRATION:** Serena for enhanced planning synthesis

**Plan Documentation:**
- SYNTHESIZE all planning elements into coherent plan
- PRIORITIZE implementation order and dependencies
- RECOMMEND team assignments and skill requirements
- SUGGEST monitoring and progress tracking approaches

### 10. Output structured milestones and tasks using templates

**CRITICAL:** Use established milestone and task templates

**Template Integration:**
- USE `milestone_meta_template.md` for each planned milestone
- APPLY `task_template.md` for individual implementation tasks
- GENERATE files in appropriate `.simone/` directories
- INTEGRATE with existing project management workflows

**Output Structure:**
```
Planning Results:
- Milestones created: N milestones in .simone/02_MILESTONES/
- Tasks created: N tasks in .simone/04_TASKS/
- Planning document: .simone/10_STATE_OF_PROJECT/implementation_plan_[feature]_[timestamp].md
```

**Suggested Follow-up Commands:**
- `create_milestone` for immediate milestone creation
- `create_general_task` for urgent preliminary tasks
- `do_task` or `do_task_auto` to begin implementation
- `status` to track planning progress