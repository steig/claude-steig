# Analyze - Deep Code and System Analysis

**COGNITIVE PERSONAS INTEGRATION:** This command supports domain expertise enhancement.

**AVAILABLE PERSONAS** (reference: `.claude/commands/shared/persona-flags.yml`):
- `--persona-analyzer`: Code analysis and metrics evaluation expertise
- `--persona-architect`: System architecture analysis
- `--persona-security`: Security analysis and vulnerability assessment
- `--persona-performance`: Performance analysis and optimization
- `--persona-qa`: Quality analysis and testing assessment

**ADVANCED FLAGS:**
- `--introspect`: Show transparent analysis reasoning process
- `--consensus`: Multi-model consensus on analysis findings
- `--think-deep`: Extended analysis with comprehensive investigation

**ANALYSIS TYPES:**
- `--type-code`: Analyze code quality, patterns, and structure
- `--type-performance`: Analyze performance bottlenecks and optimization opportunities
- `--type-security`: Analyze security vulnerabilities and compliance
- `--type-architecture`: Analyze system architecture and design patterns
- `--type-dependencies`: Analyze dependency relationships and management

## Create a TODO with EXACTLY these 9 Items

1. Parse analysis target and define analysis scope
2. Execute comprehensive code scanning and metric collection
3. Analyze code quality, complexity, and maintainability
4. Assess architectural patterns and design quality
5. Evaluate performance characteristics and bottlenecks
6. Conduct security analysis and vulnerability assessment
7. Analyze dependency relationships and technical debt
8. Generate analysis findings with actionable recommendations
9. Create structured analysis report with improvement suggestions

## DETAILS on every TODO item

### 1. Parse analysis target and define analysis scope

**MCP INTEGRATION:** Sequential Thinking for systematic analysis approach

Check: <$ARGUMENTS>

**Scope Definition:**
- IDENTIFY specific files, modules, or system components to analyze
- DEFINE analysis depth and focus areas
- ESTABLISH success criteria for analysis completion
- DETERMINE which analysis types to execute

### 2. Execute comprehensive code scanning and metric collection

**MCP INTEGRATION:** Sequential Thinking for systematic scanning

**Code Scanning:**
- SCAN target codebase for patterns and metrics
- COLLECT complexity metrics (cyclomatic, cognitive)
- GATHER size metrics (lines of code, file counts)
- IDENTIFY code duplication and similarity patterns

### 3. Analyze code quality, complexity, and maintainability

**MCP INTEGRATION:** Sequential Thinking + Context7 for quality assessment

**Quality Analysis:**
- ASSESS code clarity and readability
- EVALUATE naming conventions and documentation quality
- ANALYZE function and class design patterns
- IDENTIFY code smells and anti-patterns
- CALCULATE maintainability indices

### 4. Assess architectural patterns and design quality

**MCP INTEGRATION:** Context7 for architectural understanding

**Architecture Analysis:**
- EVALUATE modular design and separation of concerns
- ASSESS coupling and cohesion levels
- IDENTIFY architectural patterns and their implementation
- ANALYZE abstraction levels and interface design
- EVALUATE adherence to SOLID principles

### 5. Evaluate performance characteristics and bottlenecks

**MCP INTEGRATION:** Sequential Thinking for performance analysis

**Performance Analysis:**
- IDENTIFY potential performance bottlenecks
- ANALYZE algorithmic complexity patterns
- ASSESS resource utilization patterns
- EVALUATE database query efficiency
- IDENTIFY optimization opportunities

### 6. Conduct security analysis and vulnerability assessment

**MCP INTEGRATION:** Sequential Thinking for security assessment

**Security Analysis:**
- SCAN for common security vulnerabilities
- ASSESS input validation and sanitization
- EVALUATE authentication and authorization patterns
- IDENTIFY potential data exposure risks
- ASSESS compliance with security best practices

### 7. Analyze dependency relationships and technical debt

**MCP INTEGRATION:** Work History for debt pattern analysis

**Dependency Analysis:**
- MAP dependency relationships and coupling
- IDENTIFY circular dependencies and tight coupling
- ASSESS dependency version management
- EVALUATE technical debt accumulation patterns
- IDENTIFY refactoring opportunities

### 8. Generate analysis findings with actionable recommendations

**MCP INTEGRATION:** Serena for comprehensive findings synthesis

**Findings Generation:**
- SYNTHESIZE analysis results into prioritized findings
- CATEGORIZE issues by severity and impact
- RECOMMEND specific improvement actions
- ESTIMATE effort required for remediation
- PRIORITIZE recommendations by value and feasibility

### 9. Create structured analysis report with improvement suggestions

**CRITICAL:** Output comprehensive analysis documentation

**Report Structure:**
```
# CODE ANALYSIS REPORT
Generated: [Timestamp]
Analysis Scope: [Target and types analyzed]
Overall Quality Score: [1-10]

## EXECUTIVE SUMMARY
- Critical Issues: [Count and description]
- Quality Metrics: [Key metrics summary]
- Improvement Potential: [High-impact opportunities]

## DETAILED FINDINGS
### Code Quality Analysis
### Architecture Assessment  
### Performance Analysis
### Security Assessment
### Dependency Analysis

## PRIORITIZED RECOMMENDATIONS
### Critical Actions
### High-Impact Improvements
### Long-term Enhancements

## NEXT STEPS
[Suggested follow-up actions and commands]
```

**Output Location:**
- SAVE analysis report to `.simone/10_STATE_OF_PROJECT/analysis_report_[target]_[timestamp].md`
- CREATE improvement tasks in `.simone/04_TASKS/` for critical findings
- SUGGEST milestone creation for major improvement initiatives

**Integration with Templates:**
- USE `technical_debt_template.md` for debt tracking
- APPLY `task_template.md` for improvement tasks
- LEVERAGE `bug_report_template.md` for critical issues

**Suggested Follow-up Commands:**
- `log_technical_debt` for debt management
- `create_general_task` for immediate improvements
- `plan` for major refactoring initiatives
- `troubleshoot` for comprehensive system health check