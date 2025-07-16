# Investigate - Targeted Bug and Issue Investigation

**COGNITIVE PERSONAS INTEGRATION:** This command supports domain expertise enhancement.

**AVAILABLE PERSONAS** (reference: `.claude/commands/shared/persona-flags.yml`):
- `--persona-analyzer`: Code analysis and debugging expertise
- `--persona-qa`: Testing and quality assurance investigation
- `--persona-security`: Security incident investigation
- `--persona-performance`: Performance issue investigation
- `--persona-devops`: Infrastructure and deployment investigation

**ADVANCED FLAGS:**
- `--introspect`: Show transparent investigation reasoning process
- `--think-deep`: Extended investigation with comprehensive analysis
- `--compressed`: Output concise investigation summary only

**INVESTIGATION TYPES:**
- `--type-bug`: Investigate specific bug reports or issues
- `--type-performance`: Investigate performance degradation or bottlenecks
- `--type-security`: Investigate security incidents or vulnerabilities
- `--type-failure`: Investigate system failures or outages
- `--type-anomaly`: Investigate unusual behavior or patterns

## Create a TODO with EXACTLY these 11 Items

1. Parse investigation request and define investigation scope
2. Gather initial evidence and reproduce issue if possible
3. Analyze logs, error messages, and system state
4. Trace code execution paths and identify potential causes
5. Examine recent changes and deployment history
6. Investigate environmental factors and dependencies
7. Analyze similar historical issues and patterns
8. Test hypotheses and validate root cause theories
9. Determine impact scope and affected components
10. Document findings and root cause analysis
11. Suggest remediation plan and prevention strategies

## DETAILS on every TODO item

### 1. Parse investigation request and define investigation scope

**MCP INTEGRATION:** Sequential Thinking for systematic investigation approach

Check: <$ARGUMENTS>

**Investigation Scoping:**
- EXTRACT issue description and symptoms from request
- DEFINE investigation boundaries and focus areas
- IDENTIFY critical information needed for investigation
- ESTABLISH investigation timeline and urgency level

### 2. Gather initial evidence and reproduce issue if possible

**MCP INTEGRATION:** Sequential Thinking for evidence collection

**Evidence Gathering:**
- COLLECT error messages, stack traces, and log entries
- DOCUMENT steps to reproduce the issue
- CAPTURE system state and configuration information
- IDENTIFY affected users, components, or environments

### 3. Analyze logs, error messages, and system state

**MCP INTEGRATION:** Sequential Thinking + GitHub for pattern recognition

**Log Analysis:**
- EXAMINE application logs for relevant error patterns
- ANALYZE system logs for infrastructure issues
- REVIEW deployment logs for recent changes
- IDENTIFY correlation between events and issue occurrence

### 4. Trace code execution paths and identify potential causes

**MCP INTEGRATION:** Context7 for code flow understanding

**Code Tracing:**
- TRACE execution path leading to the issue
- IDENTIFY critical code sections and decision points
- ANALYZE conditional logic and edge case handling
- EXAMINE exception handling and error propagation

### 5. Examine recent changes and deployment history

**MCP INTEGRATION:** GitHub for change correlation analysis

**Change Analysis:**
- REVIEW recent code commits and their impact
- ANALYZE deployment timeline and configuration changes
- IDENTIFY dependency updates or environment modifications
- CORRELATE changes with issue occurrence timeline

### 6. Investigate environmental factors and dependencies

**MCP INTEGRATION:** Sequential Thinking for environmental analysis

**Environmental Investigation:**
- EXAMINE system resource utilization and constraints
- ANALYZE network connectivity and external service dependencies
- REVIEW configuration differences between environments
- IDENTIFY infrastructure changes or limitations

### 7. Analyze similar historical issues and patterns

**MCP INTEGRATION:** GitHub for historical pattern analysis

**Historical Analysis:**
- SEARCH for similar issues in project history
- ANALYZE resolution patterns and successful fixes
- IDENTIFY recurring issue patterns or root causes
- LEARN from previous investigation approaches

### 8. Test hypotheses and validate root cause theories

**MCP INTEGRATION:** Sequential Thinking for hypothesis validation

**Hypothesis Testing:**
- FORMULATE potential root cause theories
- DESIGN tests to validate or eliminate theories
- EXECUTE controlled tests in safe environments
- GATHER evidence supporting or refuting hypotheses

### 9. Determine impact scope and affected components

**MCP INTEGRATION:** Context7 for impact analysis

**Impact Assessment:**
- IDENTIFY all components affected by the issue
- ASSESS user impact and business consequences
- DETERMINE data integrity and security implications
- EVALUATE performance and availability impact

### 10. Document findings and root cause analysis

**MCP INTEGRATION:** Serena for comprehensive documentation

**Documentation Requirements:**
- DOCUMENT complete investigation timeline and findings
- RECORD root cause analysis with supporting evidence
- CAPTURE lessons learned and investigation insights
- PROVIDE detailed technical explanation of the issue

### 11. Suggest remediation plan and prevention strategies

**CRITICAL:** Provide actionable solutions and prevention measures

**Remediation Planning:**
- RECOMMEND immediate fixes for critical issues
- SUGGEST long-term solutions and improvements
- PROPOSE monitoring and detection enhancements
- RECOMMEND testing and validation procedures

**Report Structure:**
```
# INVESTIGATION REPORT
Investigation ID: [Unique identifier]
Issue Description: [Brief issue summary]
Investigation Date: [Timestamp]
Investigator: [Claude + User]

## ISSUE SUMMARY
- Symptoms: [What was observed]
- Impact: [Who/what was affected]
- Timeline: [When issue occurred]

## INVESTIGATION FINDINGS
### Evidence Collected
### Root Cause Analysis
### Contributing Factors

## REMEDIATION PLAN
### Immediate Actions
### Long-term Solutions
### Prevention Strategies

## LESSONS LEARNED
### Investigation Insights
### Process Improvements
### Monitoring Enhancements
```

**Output Location:**
- SAVE investigation report to `.simone/10_STATE_OF_PROJECT/investigation_[issue]_[timestamp].md`
- CREATE bug report using `bug_report_template.md` if not already exists
- GENERATE remediation tasks in `.simone/04_TASKS/` for identified fixes

**Integration with Existing Processes:**
- LINK findings to existing bug tracking workflows
- COORDINATE with quality assurance and testing processes
- ALIGN with deployment and change management procedures

**Suggested Follow-up Commands:**
- `create_bug` for formal bug tracking
- `fix_bug` to implement remediation
- `create_general_task` for prevention improvements
- `safety_check` to validate system health after fixes