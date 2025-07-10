# User Intervention Command

Provides manual override and intervention capabilities for autonomous operations.

## Usage

This command handles user intervention during autonomous operations.

Check <$ARGUMENTS> for intervention type:
- `--pause`: Pause all operations
- `--resume`: Resume paused operations
- `--approve <task_id>`: Approve a pending task
- `--reject <task_id>`: Reject a pending task
- `--override <safety_check>`: Override a safety check
- `--emergency`: Emergency intervention menu

## Intervention Types

### 1. Operation Control
```bash
# Pause all autonomous operations
pause_operations() {
    echo "⏸️  PAUSING ALL OPERATIONS"
    
    # Create pause signal
    touch .operation_paused
    echo "$(date): Operations paused by user" >> intervention_log.txt
    
    # Find and pause running processes
    YOLO_PIDS=$(ps aux | grep "yolo.md" | grep -v grep | awk '{print $2}')
    TASK_PIDS=$(ps aux | grep "do_task.md" | grep -v grep | awk '{print $2}')
    
    if [[ -n "$YOLO_PIDS" ]]; then
        echo "Pausing YOLO processes: $YOLO_PIDS"
        for pid in $YOLO_PIDS; do
            kill -STOP "$pid" 2>/dev/null || true
        done
    fi
    
    if [[ -n "$TASK_PIDS" ]]; then
        echo "Pausing task processes: $TASK_PIDS"
        for pid in $TASK_PIDS; do
            kill -STOP "$pid" 2>/dev/null || true
        done
    fi
    
    echo "✅ All operations paused"
    echo "Use --resume to continue operations"
}

# Resume paused operations
resume_operations() {
    echo "▶️  RESUMING OPERATIONS"
    
    # Remove pause signal
    rm -f .operation_paused
    echo "$(date): Operations resumed by user" >> intervention_log.txt
    
    # Resume paused processes
    PAUSED_PIDS=$(ps aux | grep -E "(yolo|do_task)" | grep -v grep | awk '{print $2}')
    
    if [[ -n "$PAUSED_PIDS" ]]; then
        echo "Resuming processes: $PAUSED_PIDS"
        for pid in $PAUSED_PIDS; do
            kill -CONT "$pid" 2>/dev/null || true
        done
    fi
    
    echo "✅ Operations resumed"
}
```

### 2. Task Approval System
```bash
# Approve a pending task
approve_task() {
    local TASK_ID="$1"
    
    if [[ -z "$TASK_ID" ]]; then
        echo "❌ Task ID required"
        return 1
    fi
    
    echo "✅ APPROVING TASK: $TASK_ID"
    
    # Create approval file
    echo "approved" > ".task_approval_$TASK_ID"
    echo "$(date): Task $TASK_ID approved by user" >> intervention_log.txt
    
    # Log approval
    echo "Task $TASK_ID: Approved by user at $(date)" >> approved_tasks.log
    
    echo "Task $TASK_ID approved and ready for execution"
}

# Reject a pending task
reject_task() {
    local TASK_ID="$1"
    local REASON="$2"
    
    if [[ -z "$TASK_ID" ]]; then
        echo "❌ Task ID required"
        return 1
    fi
    
    echo "❌ REJECTING TASK: $TASK_ID"
    
    # Create rejection file
    echo "rejected: ${REASON:-No reason provided}" > ".task_approval_$TASK_ID"
    echo "$(date): Task $TASK_ID rejected by user - $REASON" >> intervention_log.txt
    
    # Log rejection
    echo "Task $TASK_ID: Rejected by user at $(date) - $REASON" >> rejected_tasks.log
    
    echo "Task $TASK_ID rejected"
}
```

### 3. Safety Override System
```bash
# Override safety checks
override_safety_check() {
    local CHECK_TYPE="$1"
    local REASON="$2"
    
    if [[ -z "$CHECK_TYPE" ]]; then
        echo "❌ Safety check type required"
        echo "Available overrides: test_failure, file_limit, time_limit, resource_usage"
        return 1
    fi
    
    echo "⚠️  OVERRIDING SAFETY CHECK: $CHECK_TYPE"
    echo "Reason: ${REASON:-No reason provided}"
    
    # Create override file
    echo "overridden: ${REASON:-No reason provided}" > ".safety_override_$CHECK_TYPE"
    echo "$(date): Safety check $CHECK_TYPE overridden by user - $REASON" >> intervention_log.txt
    
    # Log override with warning
    echo "⚠️  SAFETY OVERRIDE: $CHECK_TYPE overridden by user at $(date) - $REASON" >> safety_overrides.log
    
    # Set expiration (overrides expire after 1 hour)
    echo "$(date -d '+1 hour' +%s)" > ".safety_override_${CHECK_TYPE}_expires"
    
    echo "Safety check $CHECK_TYPE overridden for 1 hour"
    echo "⚠️  WARNING: This override will expire in 1 hour"
}
```

### 4. Emergency Intervention Menu
```bash
# Interactive emergency intervention
emergency_intervention() {
    echo "🚨 EMERGENCY INTERVENTION MENU"
    echo "============================="
    echo ""
    
    # Show current system status
    echo "📊 CURRENT STATUS:"
    echo "├─ Active YOLO processes: $(ps aux | grep "yolo.md" | grep -v grep | wc -l)"
    echo "├─ Active task processes: $(ps aux | grep "do_task.md" | grep -v grep | wc -l)"
    echo "├─ Operations paused: $(if [[ -f ".operation_paused" ]]; then echo "YES"; else echo "NO"; fi)"
    echo "├─ Emergency stop active: $(if [[ -f ".emergency_stop" ]]; then echo "YES"; else echo "NO"; fi)"
    echo "└─ Git status: $(git status --porcelain | wc -l) uncommitted files"
    echo ""
    
    # Show intervention options
    echo "🛠️  INTERVENTION OPTIONS:"
    echo "1. Pause all operations"
    echo "2. Resume all operations"
    echo "3. Emergency stop all operations"
    echo "4. Kill all autonomous processes"
    echo "5. View pending approvals"
    echo "6. Approve/reject specific task"
    echo "7. Override safety check"
    echo "8. View recent alerts"
    echo "9. System health check"
    echo "10. Exit intervention menu"
    echo ""
    
    read -p "Choose option (1-10): " -n 2 -r
    echo
    
    case $REPLY in
        1)
            pause_operations
            ;;
        2)
            resume_operations
            ;;
        3)
            /Users/tom/code/claude-simone/.claude/commands/simone/emergency_stop.md --reason "User emergency intervention"
            ;;
        4)
            kill_all_processes
            ;;
        5)
            show_pending_approvals
            ;;
        6)
            approve_reject_menu
            ;;
        7)
            safety_override_menu
            ;;
        8)
            show_recent_alerts
            ;;
        9)
            system_health_check
            ;;
        10)
            echo "Exiting intervention menu"
            return 0
            ;;
        *)
            echo "Invalid option"
            emergency_intervention
            ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..." -r
    emergency_intervention
}
```

### 5. Process Management
```bash
# Kill all autonomous processes
kill_all_processes() {
    echo "💀 KILLING ALL AUTONOMOUS PROCESSES"
    echo "This will forcefully terminate all operations"
    echo ""
    read -p "Are you sure? (y/N): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Kill YOLO processes
        YOLO_PIDS=$(ps aux | grep "yolo.md" | grep -v grep | awk '{print $2}')
        if [[ -n "$YOLO_PIDS" ]]; then
            echo "Killing YOLO processes: $YOLO_PIDS"
            for pid in $YOLO_PIDS; do
                kill -9 "$pid" 2>/dev/null || true
            done
        fi
        
        # Kill task processes
        TASK_PIDS=$(ps aux | grep "do_task.md" | grep -v grep | awk '{print $2}')
        if [[ -n "$TASK_PIDS" ]]; then
            echo "Killing task processes: $TASK_PIDS"
            for pid in $TASK_PIDS; do
                kill -9 "$pid" 2>/dev/null || true
            done
        fi
        
        # Kill Claude processes
        CLAUDE_PIDS=$(ps aux | grep "claude" | grep -v grep | awk '{print $2}')
        if [[ -n "$CLAUDE_PIDS" ]]; then
            echo "Killing Claude processes: $CLAUDE_PIDS"
            for pid in $CLAUDE_PIDS; do
                kill -9 "$pid" 2>/dev/null || true
            done
        fi
        
        echo "✅ All processes killed"
        echo "$(date): All processes killed by user" >> intervention_log.txt
    else\n        echo "Operation cancelled"
    fi
}
```

### 6. Approval Management
```bash
# Show pending approvals
show_pending_approvals() {
    echo "📋 PENDING APPROVALS"
    echo "==================="
    
    # Find pending tasks
    PENDING_COUNT=0
    for approval_file in .task_approval_*; do
        if [[ -f "$approval_file" ]]; then
            TASK_ID=$(basename "$approval_file" | sed 's/.task_approval_//')
            STATUS=$(cat "$approval_file")
            
            if [[ "$STATUS" == "pending" ]]; then
                echo "Task $TASK_ID: Pending approval"
                ((PENDING_COUNT++))
            fi
        fi
    done
    
    if [[ $PENDING_COUNT -eq 0 ]]; then
        echo "No pending approvals"
    fi
}

# Approve/reject menu
approve_reject_menu() {
    echo "✅❌ APPROVE/REJECT MENU"
    echo "======================="
    
    # Show pending tasks
    show_pending_approvals
    
    echo ""
    read -p "Enter task ID to approve/reject (or 'back'): " -r TASK_ID
    
    if [[ "$TASK_ID" == "back" ]]; then
        return 0
    fi
    
    if [[ -z "$TASK_ID" ]]; then
        echo "❌ Task ID required"
        return 1
    fi
    
    # Show task details if available
    if [[ -f ".simone/04_GENERAL_TASKS/T$TASK_ID.md" ]]; then
        echo ""
        echo "📄 Task Details:"
        head -20 ".simone/04_GENERAL_TASKS/T$TASK_ID.md"
        echo ""
    fi
    
    echo "Choose action:"
    echo "1. Approve task"
    echo "2. Reject task"
    echo "3. Back to menu"
    
    read -p "Choose option (1-3): " -n 1 -r
    echo
    
    case $REPLY in
        1)
            approve_task "$TASK_ID"
            ;;
        2)
            read -p "Enter rejection reason: " -r REASON
            reject_task "$TASK_ID" "$REASON"
            ;;
        3)
            return 0
            ;;
        *)
            echo "Invalid option"
            approve_reject_menu
            ;;
    esac
}
```

### 7. Safety Override Management
```bash
# Safety override menu
safety_override_menu() {
    echo "⚠️  SAFETY OVERRIDE MENU"
    echo "========================"
    echo ""
    echo "🔒 ACTIVE OVERRIDES:"
    
    # Show active overrides
    OVERRIDE_COUNT=0
    for override_file in .safety_override_*; do
        if [[ -f "$override_file" && ! "$override_file" =~ _expires$ ]]; then
            OVERRIDE_TYPE=$(basename "$override_file" | sed 's/.safety_override_//')
            REASON=$(cat "$override_file" | sed 's/overridden: //')
            
            # Check if override is expired
            EXPIRES_FILE="${override_file}_expires"
            if [[ -f "$EXPIRES_FILE" ]]; then
                EXPIRES=$(cat "$EXPIRES_FILE")
                CURRENT=$(date +%s)
                
                if [[ $CURRENT -gt $EXPIRES ]]; then
                    echo "Override $OVERRIDE_TYPE: EXPIRED"
                    rm -f "$override_file" "$EXPIRES_FILE"
                else
                    REMAINING=$(( (EXPIRES - CURRENT) / 60 ))
                    echo "Override $OVERRIDE_TYPE: Active ($REMAINING minutes remaining)"
                    echo "  Reason: $REASON"
                    ((OVERRIDE_COUNT++))
                fi
            else
                echo "Override $OVERRIDE_TYPE: Active (no expiration)"
                echo "  Reason: $REASON"
                ((OVERRIDE_COUNT++))
            fi
        fi
    done
    
    if [[ $OVERRIDE_COUNT -eq 0 ]]; then
        echo "No active overrides"
    fi
    
    echo ""
    echo "Available safety checks to override:"
    echo "1. test_failure - Override test failure stops"
    echo "2. file_limit - Override file modification limits"
    echo "3. time_limit - Override task time limits"
    echo "4. resource_usage - Override resource usage limits"
    echo "5. critical_files - Override critical file protection"
    echo "6. Back to menu"
    
    read -p "Choose option (1-6): " -n 1 -r
    echo
    
    case $REPLY in
        1)
            read -p "Enter reason for test failure override: " -r REASON
            override_safety_check "test_failure" "$REASON"
            ;;
        2)
            read -p "Enter reason for file limit override: " -r REASON
            override_safety_check "file_limit" "$REASON"
            ;;
        3)
            read -p "Enter reason for time limit override: " -r REASON
            override_safety_check "time_limit" "$REASON"
            ;;
        4)
            read -p "Enter reason for resource usage override: " -r REASON
            override_safety_check "resource_usage" "$REASON"
            ;;
        5)
            read -p "Enter reason for critical files override: " -r REASON
            override_safety_check "critical_files" "$REASON"
            ;;
        6)
            return 0
            ;;
        *)
            echo "Invalid option"
            safety_override_menu
            ;;
    esac
}
```

### 8. System Health Check
```bash
# Comprehensive system health check
system_health_check() {
    echo "🏥 SYSTEM HEALTH CHECK"
    echo "====================="
    
    # Git health
    echo "📊 GIT HEALTH:"
    echo "├─ Repository status: $(git status --porcelain | wc -l) uncommitted files"
    echo "├─ Current branch: $(git rev-parse --abbrev-ref HEAD)"
    echo "├─ Commits ahead: $(git rev-list --count HEAD ^origin/main 2>/dev/null || echo "N/A")"
    echo "└─ Repository integrity: $(git fsck --quiet 2>/dev/null && echo "OK" || echo "ISSUES DETECTED")"
    echo ""
    
    # System resources
    echo "💻 SYSTEM RESOURCES:"
    echo "├─ Disk usage: $(df -h . | tail -1 | awk '{print $5}')"
    echo "├─ Memory usage: $(free -m | awk 'NR==2{printf "%.1f%%", $3*100/$2}' 2>/dev/null || echo "N/A")"
    echo "├─ CPU usage: $(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/,//' || echo "N/A")"
    echo "└─ Load average: $(uptime | awk -F'load average:' '{print $2}' || echo "N/A")"
    echo ""
    
    # Process status
    echo "🔄 PROCESS STATUS:"
    echo "├─ Active YOLO: $(ps aux | grep "yolo.md" | grep -v grep | wc -l)"
    echo "├─ Active tasks: $(ps aux | grep "do_task.md" | grep -v grep | wc -l)"
    echo "├─ Paused operations: $(if [[ -f ".operation_paused" ]]; then echo "YES"; else echo "NO"; fi)"
    echo "└─ Emergency stop: $(if [[ -f ".emergency_stop" ]]; then echo "ACTIVE"; else echo "CLEAR"; fi)"
    echo ""
    
    # Recent activity
    echo "📈 RECENT ACTIVITY:"
    if [[ -f "task_completion.log" ]]; then
        RECENT_TASKS=$(grep "$(date +%Y-%m-%d)" task_completion.log | wc -l)
        echo "├─ Tasks completed today: $RECENT_TASKS"
    else
        echo "├─ Tasks completed today: 0"
    fi
    
    if [[ -f "safety_alerts.log" ]]; then
        RECENT_ALERTS=$(grep "$(date +%Y-%m-%d)" safety_alerts.log | wc -l)
        echo "├─ Safety alerts today: $RECENT_ALERTS"
    else
        echo "├─ Safety alerts today: 0"
    fi
    
    if [[ -f "failed_commits.log" ]]; then
        RECENT_FAILURES=$(grep "$(date +%Y-%m-%d)" failed_commits.log | wc -l)
        echo "└─ Failed operations today: $RECENT_FAILURES"
    else
        echo "└─ Failed operations today: 0"
    fi
    echo ""
    
    # Health score
    HEALTH_SCORE=100
    
    # Deduct points for issues
    if [[ $(git status --porcelain | wc -l) -gt 10 ]]; then
        HEALTH_SCORE=$((HEALTH_SCORE - 10))
    fi
    
    if [[ $(ps aux | grep -E "(yolo|do_task)" | grep -v grep | wc -l) -gt 5 ]]; then
        HEALTH_SCORE=$((HEALTH_SCORE - 15))
    fi
    
    if [[ -f ".emergency_stop" ]]; then
        HEALTH_SCORE=$((HEALTH_SCORE - 30))
    fi
    
    if [[ -f "safety_alerts.log" ]] && [[ $(grep "CRITICAL" safety_alerts.log | wc -l) -gt 0 ]]; then
        HEALTH_SCORE=$((HEALTH_SCORE - 20))
    fi
    
    # Display health score
    echo "🏆 OVERALL HEALTH SCORE: $HEALTH_SCORE/100"
    if [[ $HEALTH_SCORE -gt 90 ]]; then
        echo "✅ System health: EXCELLENT"
    elif [[ $HEALTH_SCORE -gt 70 ]]; then
        echo "⚠️  System health: GOOD"
    elif [[ $HEALTH_SCORE -gt 50 ]]; then
        echo "⚠️  System health: CONCERNING"
    else
        echo "❌ System health: POOR"
    fi
}
```

## Main Execution Logic

```bash
# Parse arguments and execute appropriate action
case "${ARGUMENTS}" in
    "--pause")
        pause_operations
        ;;
    "--resume")
        resume_operations
        ;;
    "--approve")
        TASK_ID=$(echo "$ARGUMENTS" | sed 's/--approve //')
        approve_task "$TASK_ID"
        ;;
    "--reject")
        TASK_ID=$(echo "$ARGUMENTS" | sed 's/--reject //')
        read -p "Enter rejection reason: " -r REASON
        reject_task "$TASK_ID" "$REASON"
        ;;
    "--override")
        CHECK_TYPE=$(echo "$ARGUMENTS" | sed 's/--override //')
        read -p "Enter override reason: " -r REASON
        override_safety_check "$CHECK_TYPE" "$REASON"
        ;;
    "--emergency")
        emergency_intervention
        ;;
    *)
        echo "Usage: user_intervention.md [--pause|--resume|--approve <task_id>|--reject <task_id>|--override <check>|--emergency]"
        echo ""
        echo "Commands:"
        echo "  --pause              Pause all operations"
        echo "  --resume             Resume paused operations"
        echo "  --approve <task_id>  Approve a pending task"
        echo "  --reject <task_id>   Reject a pending task"
        echo "  --override <check>   Override a safety check"
        echo "  --emergency          Emergency intervention menu"
        ;;
esac
```

This user intervention system provides comprehensive manual control over autonomous operations with safety checks and detailed logging.