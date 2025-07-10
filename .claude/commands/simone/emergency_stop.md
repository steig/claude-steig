# Emergency Stop Command

Immediately halt all autonomous operations and secure the system.

## Usage

This command provides immediate emergency stop functionality for autonomous operations.

Check <$ARGUMENTS> for stop scope:
- `--all`: Stop all operations (default)
- `--task <task_id>`: Stop specific task
- `--process <pid>`: Stop specific process
- `--reason <reason>`: Specify stop reason

## Immediate Stop Actions

### 1. Signal All Autonomous Processes
```bash
# Find and stop all YOLO/autonomous processes
echo "=== EMERGENCY STOP INITIATED ==="
echo "Timestamp: $(date)"
echo "Reason: ${STOP_REASON:-Emergency stop requested}"

# Kill any running autonomous processes
pkill -f "yolo.md" 2>/dev/null || true
pkill -f "do_task.md" 2>/dev/null || true
pkill -f "claude-code" 2>/dev/null || true

# Create stop signal file
touch .emergency_stop
echo "Emergency stop signal created"
```

### 2. Preserve Current State
```bash
# Create emergency snapshot
EMERGENCY_BRANCH="emergency-stop-$(date +%Y%m%d-%H%M%S)"
git branch "$EMERGENCY_BRANCH" 2>/dev/null || true
echo "Emergency state preserved as: $EMERGENCY_BRANCH"

# Save current working directory state
mkdir -p .emergency_snapshots
cp -r . ".emergency_snapshots/snapshot-$(date +%Y%m%d-%H%M%S)" 2>/dev/null || true
echo "Working directory snapshot created"
```

### 3. Log Emergency Stop
```bash
# Create emergency log
EMERGENCY_LOG="emergency-stop-$(date +%Y%m%d-%H%M%S).log"
cat > "$EMERGENCY_LOG" << EOF
=== EMERGENCY STOP REPORT ===
Date: $(date)
Reason: ${STOP_REASON:-Emergency stop requested}
User: $(whoami)
Working Directory: $(pwd)
Git Branch: $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
Git Commit: $(git rev-parse HEAD 2>/dev/null || echo "unknown")

=== SYSTEM STATE ===
Git Status:
$(git status --porcelain 2>/dev/null || echo "Git not available")

Running Processes:
$(ps aux | grep -E "(yolo|claude|simone)" | grep -v grep || echo "No relevant processes found")

=== EMERGENCY ACTIONS TAKEN ===
- All autonomous processes terminated
- Emergency state preserved as: $EMERGENCY_BRANCH
- Working directory snapshot created
- Emergency stop signal created

=== NEXT STEPS ===
1. Review this log file
2. Assess system state
3. Determine if rollback is needed
4. Clear emergency stop signal when ready
EOF

echo "Emergency log created: $EMERGENCY_LOG"
```

## System Status Assessment

### 1. Check for Active Operations
```bash
# Verify all operations are stopped
echo "=== VERIFYING STOP COMPLETION ==="

# Check for any remaining processes
REMAINING_PROCESSES=$(ps aux | grep -E "(yolo|claude|simone)" | grep -v grep | wc -l)
if [[ $REMAINING_PROCESSES -gt 0 ]]; then
    echo "WARNING: $REMAINING_PROCESSES processes still running"
    ps aux | grep -E "(yolo|claude|simone)" | grep -v grep
else
    echo "✅ All autonomous processes stopped"
fi
```

### 2. Assess System Damage
```bash
# Check for any obvious issues
echo "=== SYSTEM DAMAGE ASSESSMENT ==="

# Check git status
echo "Git working directory status:"
git status --short 2>/dev/null || echo "Git not available"

# Check for corrupted files
echo "Checking for corrupted files..."
find . -name "*.tmp" -o -name "*.lock" -o -name "*.swp" 2>/dev/null || true

# Check disk space
echo "Disk space:"
df -h . 2>/dev/null || echo "Disk space check failed"

# Check for test failures
echo "Quick test check:"
if [[ -f "package.json" ]]; then
    npm test --passWithNoTests 2>/dev/null || echo "Tests not available"
elif [[ -f "pyproject.toml" ]]; then
    python -m pytest --tb=no -x 2>/dev/null || echo "Tests not available"
fi
```

## Emergency Recovery Options

### 1. Immediate Rollback
```bash
# Offer immediate rollback option
offer_immediate_rollback() {
    echo "=== EMERGENCY RECOVERY OPTIONS ==="
    echo "1. Immediate rollback to last safe state"
    echo "2. Inspect current state first"
    echo "3. Continue with manual recovery"
    echo "4. Exit and handle manually"
    
    read -p "Choose option (1-4): " -n 1 -r
    echo
    
    case $REPLY in
        1)
            echo "Initiating immediate rollback..."
            # Call rollback command
            /Users/tom/code/claude-simone/.claude/commands/simone/rollback.md --emergency
            ;;
        2)
            echo "Current system state preserved for inspection"
            echo "Emergency log: $EMERGENCY_LOG"
            echo "Emergency branch: $EMERGENCY_BRANCH"
            ;;
        3)
            echo "Manual recovery mode selected"
            echo "Emergency stop signal remains active"
            ;;
        4)
            echo "Exiting emergency stop command"
            exit 0
            ;;
        *)
            echo "Invalid option selected"
            ;;
    esac
}
```

### 2. Safe Mode Recovery
```bash
# Provide safe mode recovery
safe_mode_recovery() {
    echo "=== SAFE MODE RECOVERY ==="
    
    # Switch to main branch
    git checkout main 2>/dev/null || true
    
    # Stash any uncommitted changes
    if [[ -n $(git status --porcelain) ]]; then
        git stash push -m "emergency-stop-stash-$(date +%Y%m%d-%H%M%S)"
        echo "Uncommitted changes stashed"
    fi
    
    # Clean working directory
    git clean -fd 2>/dev/null || true
    
    # Run basic tests
    echo "Running basic system verification..."
    if [[ -f "package.json" ]]; then
        npm test --passWithNoTests || echo "Tests failed - system may be compromised"
    elif [[ -f "pyproject.toml" ]]; then
        python -m pytest --tb=no || echo "Tests failed - system may be compromised"
    fi
    
    echo "Safe mode recovery completed"
}
```

## User Interaction

### 1. Guided Recovery
```bash
# Provide guided recovery process
guided_recovery() {
    echo "=== GUIDED EMERGENCY RECOVERY ==="
    echo "This will help you recover from the emergency stop"
    echo ""
    
    # Step 1: Assess situation
    echo "Step 1: Assessing situation..."
    echo "Emergency reason: ${STOP_REASON:-Unknown}"
    echo "Current branch: $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")"
    echo "Uncommitted changes: $(git status --porcelain | wc -l) files"
    
    # Step 2: Choose recovery path
    echo ""
    echo "Step 2: Choose recovery path"
    echo "A. Full rollback (safest - loses recent changes)"
    echo "B. Selective recovery (inspect and choose what to keep)"
    echo "C. Continue from current state (risky)"
    echo "D. Exit and handle manually"
    
    read -p "Choose recovery path (A-D): " -n 1 -r
    echo
    
    case $REPLY in
        A|a)
            echo "Full rollback selected"
            /Users/tom/code/claude-simone/.claude/commands/simone/rollback.md --emergency
            ;;
        B|b)
            echo "Selective recovery selected"
            selective_recovery
            ;;
        C|c)
            echo "Continue from current state selected"
            clear_emergency_stop
            ;;
        D|d)
            echo "Manual recovery selected"
            echo "Emergency stop signal remains active"
            echo "Clear with: rm .emergency_stop"
            exit 0
            ;;
        *)
            echo "Invalid option - defaulting to manual recovery"
            exit 0
            ;;
    esac
}
```

### 2. Selective Recovery
```bash
# Allow user to selectively recover items
selective_recovery() {
    echo "=== SELECTIVE RECOVERY ==="
    
    # Show what's available to recover
    echo "Available items to recover:"
    echo "1. Uncommitted changes"
    echo "2. Recent commits"
    echo "3. Specific files"
    echo "4. All items"
    
    read -p "What would you like to recover? (1-4): " -n 1 -r
    echo
    
    case $REPLY in
        1)
            echo "Recovering uncommitted changes..."
            git status --porcelain
            read -p "Keep these changes? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                echo "Uncommitted changes preserved"
            else
                git checkout -- .
                echo "Uncommitted changes discarded"
            fi
            ;;
        2)
            echo "Recent commits:"
            git log --oneline -10
            echo "Commits preserved in emergency branch: $EMERGENCY_BRANCH"
            ;;
        3)
            echo "Modified files:"
            git diff --name-only
            echo "Select files to recover manually"
            ;;
        4)
            echo "All items preserved - clearing emergency stop"
            clear_emergency_stop
            ;;
    esac
}
```

## Clear Emergency Stop

### 1. Safe Clear Process
```bash
# Clear emergency stop signal safely
clear_emergency_stop() {
    echo "=== CLEARING EMERGENCY STOP ==="
    
    # Verify system is stable
    echo "Verifying system stability..."
    
    # Check git status
    if [[ -n $(git status --porcelain) ]]; then
        echo "WARNING: Uncommitted changes detected"
        git status --short
        read -p "Continue clearing emergency stop? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Emergency stop NOT cleared"
            exit 0
        fi
    fi
    
    # Remove emergency stop signal
    rm -f .emergency_stop
    echo "✅ Emergency stop signal cleared"
    
    # Log clearance
    echo "Emergency stop cleared at $(date)" >> "$EMERGENCY_LOG"
    echo "System ready for normal operations"
}
```

## Integration with Other Commands

### 1. Check for Emergency Stop
```bash
# Function other commands can use to check for emergency stop
check_emergency_stop() {
    if [[ -f ".emergency_stop" ]]; then
        echo "❌ EMERGENCY STOP ACTIVE - Operations blocked"
        echo "Clear emergency stop before continuing"
        echo "Run: /Users/tom/code/claude-simone/.claude/commands/simone/emergency_stop.md --clear"
        exit 1
    fi
}
```

### 2. Auto-Emergency Stop Triggers
```bash
# Conditions that trigger automatic emergency stop
auto_emergency_triggers() {
    # Critical system conditions
    if [[ $(df . | tail -1 | awk '{print $5}' | sed 's/%//') -gt 95 ]]; then
        STOP_REASON="Disk space critical (>95%)"
        emergency_stop_trigger
    fi
    
    # Memory usage critical
    if [[ $(free | awk 'NR==2{printf "%.0f", $3*100/$2}') -gt 90 ]]; then
        STOP_REASON="Memory usage critical (>90%)"
        emergency_stop_trigger
    fi
    
    # Too many failed operations
    if [[ $(grep -c "FAILED" recent_operations.log 2>/dev/null || echo 0) -gt 5 ]]; then
        STOP_REASON="Too many failed operations (>5)"
        emergency_stop_trigger
    fi
}
```

## Emergency Stop Execution

### Main Emergency Stop Function
```bash
emergency_stop_trigger() {
    echo "🚨 EMERGENCY STOP TRIGGERED 🚨"
    echo "Reason: ${STOP_REASON:-Unknown emergency condition}"
    
    # Execute immediate stop actions
    signal_all_processes
    preserve_current_state
    log_emergency_stop
    
    # Offer recovery options
    offer_immediate_rollback
    
    echo "Emergency stop completed"
    echo "System is in safe mode"
    echo "Review emergency log: $EMERGENCY_LOG"
}
```

This emergency stop command provides immediate halt capabilities with comprehensive state preservation and recovery options.