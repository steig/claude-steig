# Execute all open tasks in YOLO mode

This mode is meant to be run without user interaction.
You **DO NOT** ask the user any questions or ask for confirmation
If in doubt you **RESEARCH** and **ULTRATHINK** about the best solution.

**IMPORTANT** you try not to stop at any certain point but do so if you need after thoughtful consideration.

Priority is to get the work completed.

## Safety Mode Selection

Check <$ARGUMENTS> for safety mode:

- `--safe`: Maximum safety mode (recommended for production)
- `--balanced`: Moderate safety mode (default)
- `--yolo`: Minimal safety mode (legacy behavior)
- Sprint ID (e.g., S03): Work ONLY on that sprint
- If empty: Work on general tasks first, then active sprint tasks

**Safety Mode Determination:**
```bash
# Determine safety mode from arguments
if [[ "$ARGUMENTS" == *"--safe"* ]]; then
    SAFETY_MODE="safe"
    echo "🛡️  SAFE MODE: Maximum safety enabled"
elif [[ "$ARGUMENTS" == *"--balanced"* ]]; then
    SAFETY_MODE="balanced"
    echo "⚖️  BALANCED MODE: Moderate safety enabled"
elif [[ "$ARGUMENTS" == *"--yolo"* ]]; then
    SAFETY_MODE="yolo"
    echo "⚡ YOLO MODE: Minimal safety (legacy)"
else
    SAFETY_MODE="balanced"  # Default to balanced
    echo "⚖️  DEFAULT MODE: Balanced safety enabled"
fi
```

**Report Mode** to the User!

## Enhanced Safety System

### 1. Pre-Flight Safety Checks

**MANDATORY**: Run comprehensive safety checks before starting:

```bash
# Execute safety check command
@.claude/commands/simone/safety_check.md $SAFETY_MODE

# Check for emergency stop signal
if [[ -f ".emergency_stop" ]]; then
    echo "❌ EMERGENCY STOP ACTIVE - Operations blocked"
    echo "Clear emergency stop before continuing"
    exit 1
fi
```

### 2. Safety Guidelines by Mode

**SAFE MODE (--safe):**
- Maximum 3 files changed per task
- User approval required for critical changes
- Automatic rollback on any test failure
- Execution time limit: 15 minutes per task
- **STOP** conditions: Any security risk, >3 files changed, test pass rate <80%

**BALANCED MODE (--balanced - DEFAULT):**
- Maximum 5 files changed per task
- Automatic rollback on critical failures
- Execution time limit: 25 minutes per task
- **STOP** conditions: Security risks, >5 files changed, test pass rate <70%

**YOLO MODE (--yolo):**
- Maximum 10 files changed per task
- Continue on non-critical failures
- Execution time limit: 35 minutes per task
- **STOP** conditions: Security risks, >10 files changed, test pass rate <60%

### 3. Universal Safety Rules (All Modes)

- **NEVER** modify critical files (.env, alembic migrations, production configs)
- **STOP** if you encounter database schema changes
- **STOP** if security vulnerabilities detected
- **STOP** if system resources exceed 85% usage
- **ALWAYS** run tests after implementing a task
- **ALWAYS** create rollback points before major changes

### 4. Emergency Stop Integration

**Continuous monitoring for emergency conditions:**
- Disk space critical (>95%)
- Memory usage critical (>90%)
- Too many consecutive failures (>3)
- User intervention requested
- System instability detected

```bash
# Check for emergency conditions during execution
check_emergency_conditions() {
    # This function is called between each task
    if [[ $(df . | tail -1 | awk '{print $5}' | sed 's/%//') -gt 95 ]]; then
        echo "🚨 EMERGENCY: Disk space critical"
        @.claude/commands/simone/emergency_stop.md --reason "Disk space critical"
        exit 1
    fi
}
```

## Follow this exact process

**MCP INTEGRATION:** YOLO mode requires comprehensive MCP server usage:
- **Work History**: Critical for tracking all autonomous operations and decisions
- **Sequential Thinking**: Structure autonomous decision-making processes
- **Context7**: Maintain context across autonomous task execution
- **Serena**:  Code analysis for autonomous development

You need to stick to this process and **PRECISELY** follow it

### 5. Enhanced Pre-Flight Sequence

**MANDATORY PRE-FLIGHT CHECKS:**

```bash
# 1. Mark safe state for rollback
echo "🔒 Creating safe state marker..."
git tag "safe-state-$(date +%Y%m%d-%H%M%S)" 2>/dev/null || true

# 2. Execute comprehensive safety checks
echo "🛡️  Running safety checks..."
@.claude/commands/simone/safety_check.md $SAFETY_MODE

# 3. Check for emergency stop signal
if [[ -f ".emergency_stop" ]]; then
    echo "❌ EMERGENCY STOP ACTIVE - Aborting YOLO execution"
    exit 1
fi

# 4. Run baseline tests
echo "🧪 Establishing test baseline..."
@.claude/commands/simone/test.md

# Safety mode specific handling:
if [[ "$SAFETY_MODE" == "safe" ]]; then
    # Safe mode: Require >80% pass rate
    if [[ $TEST_PASS_RATE -lt 80 ]]; then
        echo "❌ SAFE MODE: Test pass rate too low ($TEST_PASS_RATE%)"
        echo "Fix tests before proceeding or use --balanced mode"
        exit 1
    fi
elif [[ "$SAFETY_MODE" == "balanced" ]]; then
    # Balanced mode: Require >70% pass rate
    if [[ $TEST_PASS_RATE -lt 70 ]]; then
        echo "⚠️  BALANCED MODE: Test pass rate concerning ($TEST_PASS_RATE%)"
        echo "Attempting to fix critical test failures..."
        # Attempt basic test fixes
    fi
else
    # YOLO mode: Continue if >60% pass rate
    if [[ $TEST_PASS_RATE -lt 60 ]]; then
        echo "⚠️  YOLO MODE: Test pass rate low ($TEST_PASS_RATE%) - continuing with caution"
    fi
fi

# 5. Check git status
echo "📝 Checking git status..."
if [[ -n $(git status --porcelain) ]]; then
    if [[ "$SAFETY_MODE" == "safe" ]]; then
        echo "❌ SAFE MODE: Working directory must be clean"
        git status --short
        exit 1
    else
        echo "⚠️  Working directory not clean - will be noted in final report"
        DIRTY_WORKDIR=true
    fi
fi
```

**Get current datetime stamp from the system and remember it**
```bash
START_TIME=$(date +%s)
START_DATETIME=$(date)
echo "⏰ YOLO session started: $START_DATETIME"
echo "🛡️  Safety mode: $SAFETY_MODE"
```

**Process additional arguments for special instructions:**
```bash
# Extract any special instructions from arguments
if [[ "$ARGUMENTS" =~ \<(.+)\> ]]; then
    SPECIAL_INSTRUCTIONS="${BASH_REMATCH[1]}"
    echo "📋 Special instructions detected: $SPECIAL_INSTRUCTIONS"
fi
```

### FIND OPEN WORK

Execute based on mode:

**If Sprint ID provided in arguments:**

- Navigate to .simone/03_SPRINTS/{sprint_id}/
- Check if sprint has tasks (T*.md files)
- If NO tasks exist:
  - Check for sprint meta file
  - If meta exists: Jump to ### CREATE SPRINT TASKS
  - If no meta: Exit with error - sprint doesn't exist
- If tasks exist: Continue to **Task selection** section below

**If NO arguments (general mode):**

- Use PARALLEL SUBAGENTS to check:
  - .simone/04_GENERAL_TASKS for open general tasks
  - .simone/00_PROJECT_MANIFEST.md for currently active sprint
  - .simone/03_SPRINTS/ for any sprint with only meta file
- Priority order:
  1. General tasks (if any open)
  2. Active sprint tasks (if any open)
  3. Sprint needing task creation (if found) - maintain order of Sprints

**Task Selection:**

- From found tasks, select ONE that is not completed. Take the lowest ID in Sprint or General Tasks
- Skip tasks you've previously attempted (check OUTPUT LOG)
- If no suitable task found and no sprint needs tasks: Exit gracefully

### CREATE SPRINT TASKS

**ONLY EXECUTE** if sprint needs task creation

- Use a **SUBAGENT** and have it include @.claude/commands/simone/create_sprint_tasks.md with Sprint ID as argument
- Wait for completion
- After task creation move back to `### FIND OPEN WORK`

### WORK ON TASK (Enhanced Safety)

**MCP INTEGRATION:** Use MCP servers for autonomous task execution:
- **Work History**: Log all autonomous task decisions and outcomes
- **Sequential Thinking**: Structure autonomous problem-solving approach
- **Context7**: Maintain context about task execution and decisions

**Enhanced Task Execution with Safety Monitoring:**

```bash
# Pre-task safety checks
echo "🔍 Pre-task safety verification..."
check_emergency_conditions  # Check for emergency stop conditions

# Check if task was attempted before
if [[ -f "task_attempts.log" ]] && grep -q "$TASK_ID" task_attempts.log; then
    echo "⚠️  Task $TASK_ID previously attempted - skipping"
    continue
fi

# Log task attempt
echo "$TASK_ID: $(date)" >> task_attempts.log

# Create safe rollback point
echo "🔒 Creating task-specific rollback point..."
TASK_ROLLBACK_POINT="task-$TASK_ID-$(date +%Y%m%d-%H%M%S)"
git tag "$TASK_ROLLBACK_POINT" 2>/dev/null || true

# Safety mode specific pre-task checks
if [[ "$SAFETY_MODE" == "safe" ]]; then
    # Safe mode: Require user approval for complex tasks
    TASK_COMPLEXITY=$(grep -c "TODO\|FIXME\|XXX" "$TASK_FILE" 2>/dev/null || echo 0)
    if [[ $TASK_COMPLEXITY -gt 5 ]]; then
        echo "⚠️  SAFE MODE: Complex task detected ($TASK_COMPLEXITY items)"
        echo "Task: $TASK_ID"
        echo "Continue with this task? (y/N)"
        read -n 1 -r
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Task skipped by user"
            continue
        fi
    fi
fi

# Create git branch for the task
echo "🌿 Creating task branch..."
git checkout -b "task/$TASK_ID" || {
    echo "❌ Failed to create task branch"
    continue
}

# Execute task with enhanced monitoring
echo "🚀 Executing task: $TASK_ID"
TASK_START_TIME=$(date +%s)

# Set task timeout based on safety mode
case "$SAFETY_MODE" in
    "safe")
        TASK_TIMEOUT=900  # 15 minutes
        ;;
    "balanced")
        TASK_TIMEOUT=1500  # 25 minutes
        ;;
    "yolo")
        TASK_TIMEOUT=2100  # 35 minutes
        ;;
esac

# Execute task with timeout monitoring
{
    timeout "$TASK_TIMEOUT" @.claude/commands/simone/do_task.md "$TASK_ID"
    TASK_RESULT=$?
} || {
    echo "⏰ Task execution timed out after $TASK_TIMEOUT seconds"
    TASK_RESULT=124
}

# Post-task safety verification
echo "🔍 Post-task safety verification..."
TASK_END_TIME=$(date +%s)
TASK_DURATION=$((TASK_END_TIME - TASK_START_TIME))

# Check for emergency conditions
check_emergency_conditions

# Run tests with safety mode specific handling
echo "🧪 Running post-task tests..."
@.claude/commands/simone/test.md
POST_TASK_PASS_RATE=$?

# Safety mode specific test evaluation
case "$SAFETY_MODE" in
    "safe")
        if [[ $POST_TASK_PASS_RATE -lt 80 ]]; then
            echo "❌ SAFE MODE: Test pass rate dropped below 80%"
            echo "Initiating automatic rollback..."
            @.claude/commands/simone/rollback.md --task "$TASK_ID"
            continue
        fi
        ;;
    "balanced")
        if [[ $POST_TASK_PASS_RATE -lt 70 ]]; then
            echo "⚠️  BALANCED MODE: Test pass rate concerning"
            echo "Attempting to fix critical issues..."
            # Attempt basic fixes
            if [[ $POST_TASK_PASS_RATE -lt 60 ]]; then
                echo "❌ BALANCED MODE: Critical test failures - rolling back"
                @.claude/commands/simone/rollback.md --task "$TASK_ID"
                continue
            fi
        fi
        ;;
    "yolo")
        if [[ $POST_TASK_PASS_RATE -lt 60 ]]; then
            echo "⚠️  YOLO MODE: Significant test failures - logging but continuing"
            echo "Task $TASK_ID: Test failures detected" >> yolo_warnings.log
        fi
        ;;
esac

# Log task completion
echo "✅ Task $TASK_ID completed in ${TASK_DURATION}s"
echo "Task $TASK_ID: Completed $(date) - Duration: ${TASK_DURATION}s - Tests: $POST_TASK_PASS_RATE%" >> task_completion.log
```

### COMMIT WORK (Enhanced Safety)

**Enhanced commit process with safety verification:**

```bash
# Pre-commit safety checks
echo "🔍 Pre-commit safety verification..."

# Check emergency conditions
check_emergency_conditions

# Safety mode specific commit requirements
case "$SAFETY_MODE" in
    "safe")
        # Safe mode: Require perfect tests and security scan
        if [[ $POST_TASK_PASS_RATE -lt 100 ]]; then
            echo "❌ SAFE MODE: All tests must pass for commit"
            echo "Current pass rate: $POST_TASK_PASS_RATE%"
            continue
        fi
        echo "🔒 SAFE MODE: Running security scan..."
        # Run security scan (if available)
        if command -v bandit &> /dev/null; then
            bandit -r . -ll || {
                echo "❌ SAFE MODE: Security issues detected"
                continue
            }
        fi
        ;;
    "balanced")
        # Balanced mode: Require >80% pass rate
        if [[ $POST_TASK_PASS_RATE -lt 80 ]]; then
            echo "❌ BALANCED MODE: Test pass rate too low for commit"
            echo "Current pass rate: $POST_TASK_PASS_RATE%"
            continue
        fi
        ;;
    "yolo")
        # YOLO mode: Require >60% pass rate
        if [[ $POST_TASK_PASS_RATE -lt 60 ]]; then
            echo "⚠️  YOLO MODE: Test pass rate concerning but continuing"
            echo "Current pass rate: $POST_TASK_PASS_RATE%"
        fi
        ;;
esac

# Execute commit with enhanced logging
echo "💾 Committing task: $TASK_ID"
COMMIT_START_TIME=$(date +%s)

# Use subagent to commit with safety mode flag
@.claude/commands/simone/commit.md "$TASK_ID" "$SAFETY_MODE"
COMMIT_RESULT=$?

COMMIT_END_TIME=$(date +%s)
COMMIT_DURATION=$((COMMIT_END_TIME - COMMIT_START_TIME))

if [[ $COMMIT_RESULT -eq 0 ]]; then
    echo "✅ Commit successful in ${COMMIT_DURATION}s"
    
    # Merge to main with safety checks
    echo "🔄 Merging to main..."
    git checkout main
    
    # Safety mode specific merge handling
    if [[ "$SAFETY_MODE" == "safe" ]]; then
        # Safe mode: Use merge --no-ff for clear history
        git merge --no-ff "task/$TASK_ID" -m "Merge task $TASK_ID (SAFE MODE)"
    else
        # Balanced/YOLO mode: Use regular merge
        git merge "task/$TASK_ID" -m "Merge task $TASK_ID ($SAFETY_MODE mode)"
    fi
    
    if [[ $? -eq 0 ]]; then
        echo "✅ Merge successful"
        # Clean up task branch
        git branch -d "task/$TASK_ID"
        # Log successful completion
        echo "Task $TASK_ID: Successfully merged $(date)" >> successful_tasks.log
    else
        echo "❌ Merge failed - manual intervention required"
        echo "Task $TASK_ID: Merge failed $(date)" >> failed_merges.log
    fi
else
    echo "❌ Commit failed - logging issue"
    echo "Task $TASK_ID: Commit failed $(date) - Duration: ${COMMIT_DURATION}s" >> failed_commits.log
    
    # Safety mode specific failure handling
    if [[ "$SAFETY_MODE" == "safe" ]]; then
        echo "🔄 SAFE MODE: Automatic rollback on commit failure"
        @.claude/commands/simone/rollback.md --task "$TASK_ID"
    fi
fi
```

### REPEAT FOR ALL OPEN TASKS

**Based on current mode:**

**Sprint-specific mode:**

- Continue with next task in the specified sprint only
- Go back to ### WORK ON TASK until all sprint tasks are done
- When sprint is complete, move to project review

**General mode:**

- After completing a general task, check for more general tasks first
- If no general tasks remain, move to active sprint tasks
- Continue until all accessible tasks are done
- When done move on

## EXECUTE PROJECT REVIEW

- **USE A SUBAGENT** and have it include @.claude/commands/simone/project_review.md
- Depending on the results of the review:
  - On FAIL: Think about possible fixes.
  - If fixes are quickly done, fix right away and repeat `## EXECUTE PROJECT REVIEW``
  - If fixes are more complex **USE A SUBAGENT** and have it include @.claude/commands/simone/create_general_task.md to create new general tasks as needed.
  - Go back to `### FIND OPEN WORK` to work on these fixes
  - On PASS: move on

## MORE WORK TO DO?

**Based on current mode:**

**Sprint-specific mode:**

Your work is done. Move to `## CREATE SUMMARY`

**General mode:**

- Move on to check for more open Tasks or Sprints. Move to `### FIND OPEN WORK`

## CREATE ENHANCED SUMMARY

```bash
# Calculate execution metrics
END_TIME=$(date +%s)
END_DATETIME=$(date)
TOTAL_DURATION=$((END_TIME - START_TIME))
TOTAL_DURATION_MINS=$((TOTAL_DURATION / 60))

# Collect execution statistics
TASKS_COMPLETED=$(grep -c "Successfully merged" successful_tasks.log 2>/dev/null || echo 0)
TASKS_FAILED=$(grep -c "failed" failed_commits.log 2>/dev/null || echo 0)
TASKS_SKIPPED=$(grep -c "skipped" task_attempts.log 2>/dev/null || echo 0)
FINAL_TEST_STATUS=$(tail -1 test_results.log 2>/dev/null || echo "Unknown")

# Safety metrics
EMERGENCY_STOPS=$(grep -c "EMERGENCY STOP" *.log 2>/dev/null || echo 0)
ROLLBACKS=$(grep -c "rollback" *.log 2>/dev/null || echo 0)
SECURITY_ISSUES=$(grep -c "security" *.log 2>/dev/null || echo 0)

# Generate comprehensive report
cat > "yolo-summary-$(date +%Y%m%d-%H%M%S).md" << EOF
# YOLO Execution Summary

## Session Overview
- **Start Time**: $START_DATETIME
- **End Time**: $END_DATETIME
- **Total Duration**: ${TOTAL_DURATION_MINS} minutes (${TOTAL_DURATION} seconds)
- **Safety Mode**: $SAFETY_MODE
- **Working Directory**: $(pwd)

## Task Execution Results
- **Tasks Completed**: $TASKS_COMPLETED ✅
- **Tasks Failed**: $TASKS_FAILED ❌
- **Tasks Skipped**: $TASKS_SKIPPED ⏭️
- **Success Rate**: $(( TASKS_COMPLETED * 100 / (TASKS_COMPLETED + TASKS_FAILED + 1) ))%

## Safety Metrics
- **Emergency Stops**: $EMERGENCY_STOPS 🚨
- **Rollbacks Executed**: $ROLLBACKS 🔄
- **Security Issues**: $SECURITY_ISSUES 🔒
- **Final Test Status**: $FINAL_TEST_STATUS 🧪

## System Health
- **Git Status**: $(git status --porcelain | wc -l) uncommitted files
- **Current Branch**: $(git rev-parse --abbrev-ref HEAD)
- **Disk Usage**: $(df -h . | tail -1 | awk '{print $5}')
- **Memory Usage**: $(free -m | awk 'NR==2{printf "%.1f%%", $3*100/$2}' 2>/dev/null || echo "N/A")

## Mode-Specific Performance
### $SAFETY_MODE Mode Results
$(case "$SAFETY_MODE" in
    "safe")
        echo "- Maximum safety protocols active"
        echo "- All commits required 100% test pass rate"
        echo "- Automatic rollback on any failure"
        echo "- User approval required for complex tasks"
        ;;
    "balanced")
        echo "- Moderate safety protocols active"
        echo "- Commits required >80% test pass rate"
        echo "- Automatic rollback on critical failures"
        echo "- Autonomous execution with monitoring"
        ;;
    "yolo")
        echo "- Minimal safety protocols (legacy mode)"
        echo "- Commits required >60% test pass rate"
        echo "- Continued on non-critical failures"
        echo "- Maximum autonomous execution"
        ;;
esac)

## Critical Issues Encountered
$(if [[ -f "critical_issues.log" ]]; then
    cat critical_issues.log
else
    echo "No critical issues encountered ✅"
fi)

## Warnings and Recommendations
$(if [[ -f "yolo_warnings.log" ]]; then
    echo "### Warnings:"
    cat yolo_warnings.log
else
    echo "No warnings generated ✅"
fi)

### Next Recommended Actions
$(if [[ $TASKS_FAILED -gt 0 ]]; then
    echo "1. Review failed tasks in failed_commits.log"
    echo "2. Consider running with --safe mode for problematic tasks"
fi)
$(if [[ $ROLLBACKS -gt 0 ]]; then
    echo "3. Review rollback reasons and improve task quality"
fi)
$(if [[ $SECURITY_ISSUES -gt 0 ]]; then
    echo "4. Address security issues immediately"
fi)
$(if [[ $EMERGENCY_STOPS -gt 0 ]]; then
    echo "5. Investigate emergency stop triggers"
fi)
$(if [[ $TASKS_COMPLETED -eq 0 ]]; then
    echo "6. No tasks completed - check task availability and requirements"
else
    echo "6. Continue with remaining tasks if any"
fi)

## Final Status
$(if [[ $TASKS_COMPLETED -gt 0 && $SECURITY_ISSUES -eq 0 && $EMERGENCY_STOPS -eq 0 ]]; then
    echo "✅ **SUCCESSFUL EXECUTION** - Tasks completed with no critical issues"
elif [[ $TASKS_COMPLETED -gt 0 ]]; then
    echo "⚠️  **PARTIAL SUCCESS** - Some tasks completed but issues encountered"
else
    echo "❌ **EXECUTION FAILED** - No tasks completed successfully"
fi)

---
*Generated by Enhanced YOLO Safety System v2.0*
*Session ID: yolo-$(date +%Y%m%d-%H%M%S)*
EOF

# Display summary to user
echo "📊 YOLO EXECUTION SUMMARY"
echo "========================"
echo "🕒 Duration: ${TOTAL_DURATION_MINS} minutes"
echo "📋 Tasks Completed: $TASKS_COMPLETED"
echo "❌ Tasks Failed: $TASKS_FAILED"
echo "⏭️  Tasks Skipped: $TASKS_SKIPPED"
echo "🛡️  Safety Mode: $SAFETY_MODE"
echo "🚨 Emergency Stops: $EMERGENCY_STOPS"
echo "🔄 Rollbacks: $ROLLBACKS"
echo ""
echo "📄 Full report: yolo-summary-$(date +%Y%m%d-%H%M%S).md"
echo ""
if [[ $TASKS_COMPLETED -gt 0 && $SECURITY_ISSUES -eq 0 && $EMERGENCY_STOPS -eq 0 ]]; then
    echo "✅ YOLO execution completed successfully!"
else
    echo "⚠️  YOLO execution completed with issues - review summary report"
fi

# Clean up temporary files
rm -f task_attempts.log task_completion.log 2>/dev/null || true

echo "🏁 Enhanced YOLO execution finished. Thank you!"
```
