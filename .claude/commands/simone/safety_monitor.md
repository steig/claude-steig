# Safety Monitor Command

Real-time monitoring of autonomous operations with safety alerting.

## Usage

This command provides continuous monitoring of YOLO and other autonomous operations.

Check <$ARGUMENTS> for monitoring mode:
- `--start`: Start monitoring daemon
- `--stop`: Stop monitoring daemon  
- `--status`: Check monitoring status
- `--dashboard`: Show real-time dashboard
- `--alerts`: Show recent alerts

## Monitoring Dashboard

### Real-time Safety Dashboard
```bash
# Start interactive monitoring dashboard
start_safety_dashboard() {
    echo "🛡️  SAFETY MONITORING DASHBOARD"
    echo "================================"
    echo "Press Ctrl+C to exit"
    echo ""
    
    while true; do
        clear
        echo "🛡️  SAFETY MONITORING DASHBOARD - $(date)"
        echo "================================"
        
        # System Health
        echo "📊 SYSTEM HEALTH"
        echo "├─ CPU Usage: $(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/,//' || echo "N/A")"
        echo "├─ Memory Usage: $(free -m | awk 'NR==2{printf "%.1f%%", $3*100/$2}' 2>/dev/null || echo "N/A")"
        echo "├─ Disk Usage: $(df -h . | tail -1 | awk '{print $5}')"
        echo "└─ Load Average: $(uptime | awk -F'load average:' '{print $2}' || echo "N/A")"
        echo ""
        
        # Active Operations
        echo "🚀 ACTIVE OPERATIONS"
        ACTIVE_YOLO=$(ps aux | grep -c "yolo.md" | grep -v grep || echo 0)
        ACTIVE_TASKS=$(ps aux | grep -c "do_task.md" | grep -v grep || echo 0)
        echo "├─ YOLO Sessions: $ACTIVE_YOLO"
        echo "├─ Active Tasks: $ACTIVE_TASKS"
        echo "└─ Total Processes: $((ACTIVE_YOLO + ACTIVE_TASKS))"
        echo ""
        
        # Safety Status
        echo "🛡️  SAFETY STATUS"
        if [[ -f ".emergency_stop" ]]; then
            echo "├─ Emergency Stop: 🔴 ACTIVE"
        else
            echo "├─ Emergency Stop: 🟢 CLEAR"
        fi
        
        # Test Status
        if [[ -f "test_results.log" ]]; then
            LAST_TEST_RESULT=$(tail -1 test_results.log)
            echo "├─ Last Test Run: $LAST_TEST_RESULT"
        else
            echo "├─ Last Test Run: No recent tests"
        fi
        
        # Git Status
        GIT_STATUS=$(git status --porcelain | wc -l)
        if [[ $GIT_STATUS -eq 0 ]]; then
            echo "├─ Git Status: 🟢 Clean"
        else
            echo "├─ Git Status: 🟡 $GIT_STATUS uncommitted files"
        fi
        
        # Recent Alerts
        echo "└─ Recent Alerts:"
        if [[ -f "safety_alerts.log" ]]; then
            tail -3 safety_alerts.log | sed 's/^/   /'
        else
            echo "   No recent alerts"
        fi
        echo ""
        
        # Performance Metrics
        echo "📈 PERFORMANCE METRICS"
        if [[ -f "task_completion.log" ]]; then
            TASKS_TODAY=$(grep "$(date +%Y-%m-%d)" task_completion.log | wc -l)
            AVG_DURATION=$(grep "$(date +%Y-%m-%d)" task_completion.log | awk -F'Duration: ' '{print $2}' | awk '{sum+=$1; count++} END {if(count>0) print sum/count"s"; else print "N/A"}')
            echo "├─ Tasks Today: $TASKS_TODAY"
            echo "├─ Avg Duration: $AVG_DURATION"
        else
            echo "├─ Tasks Today: 0"
            echo "├─ Avg Duration: N/A"
        fi
        
        if [[ -f "successful_tasks.log" ]]; then
            SUCCESS_RATE=$(( $(wc -l < successful_tasks.log) * 100 / ($(wc -l < successful_tasks.log) + $(wc -l < failed_commits.log 2>/dev/null || echo 0) + 1) ))
            echo "└─ Success Rate: $SUCCESS_RATE%"
        else
            echo "└─ Success Rate: N/A"
        fi
        
        echo ""
        echo "🔄 Auto-refresh in 5 seconds... (Ctrl+C to exit)"
        sleep 5
    done
}
```

## Safety Monitoring Rules

### 1. System Resource Monitoring
```bash
# Monitor system resources continuously
monitor_system_resources() {
    while true; do
        # Check disk space
        DISK_USAGE=$(df . | tail -1 | awk '{print $5}' | sed 's/%//')
        if [[ $DISK_USAGE -gt 90 ]]; then
            log_alert "CRITICAL" "Disk space at $DISK_USAGE%"
            if [[ $DISK_USAGE -gt 95 ]]; then
                trigger_emergency_stop "Disk space critical ($DISK_USAGE%)"
            fi
        fi
        
        # Check memory usage
        MEMORY_USAGE=$(free | awk 'NR==2{printf "%.0f", $3*100/$2}' 2>/dev/null || echo 0)
        if [[ $MEMORY_USAGE -gt 85 ]]; then
            log_alert "WARNING" "Memory usage at $MEMORY_USAGE%"
            if [[ $MEMORY_USAGE -gt 90 ]]; then
                trigger_emergency_stop "Memory usage critical ($MEMORY_USAGE%)"
            fi
        fi
        
        # Check load average
        LOAD_AVG=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | sed 's/,//' || echo 0)
        if [[ $(echo "$LOAD_AVG > 8.0" | bc -l 2>/dev/null || echo 0) -eq 1 ]]; then
            log_alert "WARNING" "High load average: $LOAD_AVG"
        fi
        
        sleep 30  # Check every 30 seconds
    done
}
```

### 2. Process Monitoring
```bash
# Monitor autonomous processes
monitor_processes() {
    while true; do
        # Check for runaway processes
        YOLO_PROCESSES=$(ps aux | grep "yolo.md" | grep -v grep | wc -l)
        if [[ $YOLO_PROCESSES -gt 3 ]]; then
            log_alert "WARNING" "Multiple YOLO processes detected ($YOLO_PROCESSES)"
        fi
        
        # Check for hung processes
        ps aux | grep -E "(yolo|do_task)" | grep -v grep | while read -r process; do
            PID=$(echo "$process" | awk '{print $2}')
            RUNTIME=$(ps -o etime= -p "$PID" 2>/dev/null || echo "unknown")
            
            # Alert if process running longer than 1 hour
            if [[ "$RUNTIME" =~ ^[0-9]+-[0-9]+:[0-9]+:[0-9]+$ ]]; then
                log_alert "WARNING" "Long-running process detected: PID $PID ($RUNTIME)"
            fi
        done
        
        sleep 60  # Check every minute
    done
}
```

### 3. Git Repository Monitoring
```bash
# Monitor git repository health
monitor_git_health() {
    while true; do
        # Check for too many uncommitted files
        UNCOMMITTED_FILES=$(git status --porcelain | wc -l)
        if [[ $UNCOMMITTED_FILES -gt 20 ]]; then
            log_alert "WARNING" "Too many uncommitted files: $UNCOMMITTED_FILES"
        fi
        
        # Check for merge conflicts
        if git status | grep -q "You have unmerged paths"; then
            log_alert "CRITICAL" "Merge conflicts detected"
            trigger_emergency_stop "Merge conflicts in repository"
        fi
        
        # Check for corrupted repository
        if ! git fsck --quiet 2>/dev/null; then
            log_alert "CRITICAL" "Git repository corruption detected"
            trigger_emergency_stop "Git repository corrupted"
        fi
        
        sleep 120  # Check every 2 minutes
    done
}
```

## Alert System

### 1. Alert Logging
```bash
# Log safety alerts
log_alert() {
    local SEVERITY="$1"
    local MESSAGE="$2"
    local TIMESTAMP=$(date)
    
    # Log to alert file
    echo "$TIMESTAMP [$SEVERITY] $MESSAGE" >> safety_alerts.log
    
    # Display alert based on severity
    case "$SEVERITY" in
        "CRITICAL")
            echo "🚨 CRITICAL: $MESSAGE" >&2
            ;;
        "WARNING")
            echo "⚠️  WARNING: $MESSAGE" >&2
            ;;
        "INFO")
            echo "ℹ️  INFO: $MESSAGE" >&2
            ;;
    esac
    
    # Keep only last 100 alerts
    tail -100 safety_alerts.log > safety_alerts.log.tmp
    mv safety_alerts.log.tmp safety_alerts.log
}
```

### 2. Emergency Stop Trigger
```bash
# Trigger emergency stop from monitoring
trigger_emergency_stop() {
    local REASON="$1"
    
    log_alert "CRITICAL" "Triggering emergency stop: $REASON"
    
    # Execute emergency stop
    /Users/tom/code/claude-simone/.claude/commands/simone/emergency_stop.md --reason "$REASON"
    
    # Send notification if possible
    if command -v notify-send &> /dev/null; then
        notify-send "YOLO Emergency Stop" "$REASON"
    fi
}
```

## User Intervention System

### 1. Interactive Intervention
```bash
# Provide user intervention options
user_intervention() {
    local TRIGGER="$1"
    
    echo "🛑 USER INTERVENTION REQUIRED"
    echo "Trigger: $TRIGGER"
    echo ""
    echo "Options:"
    echo "1. Continue with current operation"
    echo "2. Pause all operations"
    echo "3. Emergency stop all operations"
    echo "4. Switch to safe mode"
    echo "5. View detailed status"
    echo ""
    read -p "Choose option (1-5): " -n 1 -r
    echo
    
    case $REPLY in
        1)
            log_alert "INFO" "User chose to continue operation"
            ;;
        2)
            log_alert "INFO" "User requested pause"
            pause_operations
            ;;
        3)
            log_alert "INFO" "User requested emergency stop"
            trigger_emergency_stop "User intervention"
            ;;
        4)
            log_alert "INFO" "User requested safe mode"
            switch_to_safe_mode
            ;;
        5)
            show_detailed_status
            user_intervention "$TRIGGER"  # Show options again
            ;;
        *)
            echo "Invalid option"
            user_intervention "$TRIGGER"
            ;;
    esac
}
```

### 2. Operation Control
```bash
# Pause operations
pause_operations() {
    touch .operation_paused
    log_alert "INFO" "Operations paused"
    echo "Operations paused. Remove .operation_paused file to resume."
}

# Resume operations
resume_operations() {
    rm -f .operation_paused
    log_alert "INFO" "Operations resumed"
    echo "Operations resumed."
}

# Switch to safe mode
switch_to_safe_mode() {
    echo "SAFETY_MODE=safe" > .yolo_mode_override
    log_alert "INFO" "Switched to safe mode"
    echo "All future operations will use safe mode."
}
```

## Monitoring Daemon

### 1. Start Monitoring
```bash
# Start monitoring daemon
start_monitoring() {
    if [[ -f ".safety_monitor.pid" ]]; then
        PID=$(cat .safety_monitor.pid)
        if ps -p "$PID" > /dev/null 2>&1; then
            echo "Safety monitor already running (PID: $PID)"
            return 0
        fi
    fi
    
    echo "🛡️  Starting safety monitor..."
    
    # Start monitoring processes in background
    {
        monitor_system_resources &
        RESOURCE_PID=$!
        
        monitor_processes &
        PROCESS_PID=$!
        
        monitor_git_health &
        GIT_PID=$!
        
        # Wait for any monitor to exit
        wait $RESOURCE_PID $PROCESS_PID $GIT_PID
    } &
    
    MONITOR_PID=$!
    echo "$MONITOR_PID" > .safety_monitor.pid
    
    log_alert "INFO" "Safety monitor started (PID: $MONITOR_PID)"
    echo "Safety monitor started with PID: $MONITOR_PID"
}
```

### 2. Stop Monitoring
```bash
# Stop monitoring daemon
stop_monitoring() {
    if [[ -f ".safety_monitor.pid" ]]; then
        PID=$(cat .safety_monitor.pid)
        if ps -p "$PID" > /dev/null 2>&1; then
            kill "$PID" 2>/dev/null
            log_alert "INFO" "Safety monitor stopped (PID: $PID)"
            echo "Safety monitor stopped."
        else
            echo "Safety monitor not running."
        fi
        rm -f .safety_monitor.pid
    else
        echo "Safety monitor not running."
    fi
}
```

## Integration with Other Commands

### 1. Auto-start with YOLO
```bash
# Function to be called by YOLO command
auto_start_monitoring() {
    if [[ ! -f ".safety_monitor.pid" ]]; then
        echo "🛡️  Auto-starting safety monitor..."
        start_monitoring
    fi
}
```

### 2. Check Monitoring Status
```bash
# Check if monitoring is active
check_monitoring_status() {
    if [[ -f ".safety_monitor.pid" ]]; then
        PID=$(cat .safety_monitor.pid)
        if ps -p "$PID" > /dev/null 2>&1; then
            echo "🟢 Safety monitor active (PID: $PID)"
            return 0
        else
            echo "🔴 Safety monitor not running"
            rm -f .safety_monitor.pid
            return 1
        fi
    else
        echo "🔴 Safety monitor not running"
        return 1
    fi
}
```

## Main Execution Logic

```bash
# Parse arguments and execute appropriate action
case "${ARGUMENTS}" in
    "--start")
        start_monitoring
        ;;
    "--stop")
        stop_monitoring
        ;;
    "--status")
        check_monitoring_status
        ;;
    "--dashboard")
        start_safety_dashboard
        ;;
    "--alerts")
        if [[ -f "safety_alerts.log" ]]; then
            echo "📋 Recent Safety Alerts:"
            tail -20 safety_alerts.log
        else
            echo "No safety alerts found."
        fi
        ;;
    *)
        echo "Usage: safety_monitor.md [--start|--stop|--status|--dashboard|--alerts]"
        echo ""
        echo "Commands:"
        echo "  --start      Start safety monitoring daemon"
        echo "  --stop       Stop safety monitoring daemon"
        echo "  --status     Check monitoring status"
        echo "  --dashboard  Show real-time safety dashboard"
        echo "  --alerts     Show recent safety alerts"
        ;;
esac
```

This safety monitor provides comprehensive real-time monitoring of autonomous operations with automatic alerting and emergency stop capabilities.