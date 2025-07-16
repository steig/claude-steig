# Sync Metadata - Hierarchical Completion Synchronization

**Version**: 3.0.0 | **Framework**: Simone v3.0.0 | **Release**: 2025-01-14

**Purpose**: Synchronize all metadata across the project hierarchy and fix completion status inconsistencies.

**Usage**:
```bash
/project:simone:sync_metadata [--dashboard] [--fix-inconsistencies] [--validate-only]
```

**Arguments**:
- `--dashboard` - Show completion status dashboard after sync
- `--fix-inconsistencies` - Automatically fix detected inconsistencies
- `--validate-only` - Only validate without making changes

## Overview

This command ensures all task, sprint, milestone, and project completion status is properly synchronized across the entire project hierarchy. It's essential for maintaining accurate project progress tracking.

## What This Command Does

### 1. Hierarchical Validation
- **Task Level**: Validates completion requirements (acceptance criteria, quality gates)
- **Sprint Level**: Checks if sprints should be marked completed based on task status
- **Milestone Level**: Checks if milestones should be marked completed based on sprint status  
- **Project Level**: Checks if project should be marked completed based on milestone status

### 2. Metadata Synchronization
- Updates sprint progress percentages based on completed tasks
- Updates milestone progress percentages based on completed sprints
- Updates project progress percentage based on completed milestones
- Ensures all cross-references are current and accurate

### 3. Inconsistency Detection
- Identifies tasks marked completed without meeting all acceptance criteria
- Finds sprints that should be completed but aren't marked as such
- Discovers milestones that should be completed but aren't marked as such
- Detects project completion state mismatches

## Implementation Process

### Step 1: Initialize Sync Process
```bash
echo "🔄 Starting metadata synchronization across project hierarchy"

# Load metadata manager
source .simone/01_UTILS/metadata-manager.sh

# Initialize if needed
if ! command -v sync_all_metadata >/dev/null 2>&1; then
    echo "❌ Metadata manager not properly loaded"
    exit 1
fi

echo "✅ Metadata manager loaded successfully"
```

### Step 2: Pre-Sync Validation
```bash
echo "🔍 Running pre-sync validation..."

# Check for basic project structure
if [[ ! -f ".simone/00_PROJECT_MANIFEST.md" ]]; then
    echo "❌ Project manifest missing - cannot proceed"
    exit 1
fi

# Count project items
TOTAL_TASKS=$(find .simone -name "*.md" -path "*/03_SPRINTS/*" -o -path "*/04_GENERAL_TASKS/*" -not -name "*meta*" | wc -l)
TOTAL_SPRINTS=$(find .simone/03_SPRINTS -type d -mindepth 1 | wc -l)
TOTAL_MILESTONES=$(find .simone/02_REQUIREMENTS -name "M*" -type d | wc -l)

echo "📊 Project scope:"
echo "   - Tasks: $TOTAL_TASKS"
echo "   - Sprints: $TOTAL_SPRINTS" 
echo "   - Milestones: $TOTAL_MILESTONES"
```

### Step 3: Execute Comprehensive Sync
```bash
echo "🔄 Executing comprehensive metadata synchronization..."

# Run the full sync process
if sync_all_metadata; then
    echo "✅ Metadata synchronization completed successfully"
else
    echo "❌ Metadata synchronization encountered errors"
    echo "   Check individual component status below"
fi
```

### Step 4: Generate Completion Dashboard
```bash
echo "📊 Generating completion status dashboard..."

# Show completion dashboard
generate_completion_dashboard

echo ""
echo "📈 **Synchronization Summary**:"
echo "- All task statuses validated"
echo "- Sprint completion status updated"
echo "- Milestone completion status updated"  
echo "- Project completion status updated"
echo "- Cross-references synchronized"
```

### Step 5: Report Issues and Recommendations
```bash
echo "🔍 Checking for remaining inconsistencies..."

# Validate final state
if .simone/01_UTILS/metadata-manager.sh validate; then
    echo "✅ All metadata is now consistent"
else
    echo "⚠️ Some inconsistencies remain - manual review recommended"
fi

echo ""
echo "💡 **Recommendations**:"
echo "- Run this sync command weekly to maintain consistency"
echo "- Use 'update_task_status' command for individual task updates"
echo "- Check completion dashboard regularly for project progress"
echo "- Validate completion requirements before marking tasks complete"
```

## Command Flags Behavior

### Default Behavior (No Flags)
- Runs complete synchronization process
- Fixes detected inconsistencies automatically
- Shows summary dashboard at end

### --dashboard Flag
```bash
if [[ "$1" == "--dashboard" ]]; then
    echo "📊 Showing completion status dashboard only"
    generate_completion_dashboard
    exit 0
fi
```

### --validate-only Flag
```bash
if [[ "$1" == "--validate-only" ]]; then
    echo "🔍 Running validation without making changes"
    
    # Run validation without updates
    validation_errors=0
    
    # Check task completion requirements
    while IFS= read -r -d '' task_file; do
        task_status=$(grep "^status:" "$task_file" | cut -d':' -f2 | xargs || echo "pending")
        if [[ "$task_status" == "completed" ]]; then
            if ! validate_completion_requirements "$task_file"; then
                echo "❌ Validation failed: $(basename "$task_file")"
                ((validation_errors++))
            fi
        fi
    done < <(find .simone -name "*.md" -path "*/03_SPRINTS/*" -o -path "*/04_GENERAL_TASKS/*" -print0)
    
    echo "📊 Validation Summary: $validation_errors issues found"
    exit $validation_errors
fi
```

### --fix-inconsistencies Flag
```bash
if [[ "$1" == "--fix-inconsistencies" ]]; then
    echo "🔧 Running sync with automatic inconsistency fixes"
    
    # More aggressive fixing mode
    sync_all_metadata
    
    # Additional validation and fixes
    echo "🔧 Running additional consistency fixes..."
    
    # Example: Fix missing progress fields
    find .simone -name "*meta*.md" -exec grep -L "^progress:" {} \; | while read meta_file; do
        echo "progress: 0%" >> "$meta_file"
        echo "📝 Added missing progress field to: $(basename "$meta_file")"
    done
    
    exit 0
fi
```

## Integration with Other Commands

### Used by do_task_auto
The `do_task_auto` command automatically calls metadata sync when tasks are completed:

```bash
# After task completion in do_task_auto
if [[ "$task_status" == "completed" ]]; then
    /project:simone:sync_metadata --dashboard
fi
```

### Used by update_task_status
The `update_task_status` command includes hierarchical checking:

```bash
# After status update
if [[ "$NEW_STATUS" == "completed" ]]; then
    .simone/01_UTILS/metadata-manager.sh check_completion "$TASK_ID"
fi
```

## Monitoring and Alerting

### Weekly Sync Recommendation
Add to project cron or reminder system:
```bash
# Weekly metadata sync (recommended)
0 9 * * 1 cd /path/to/project && /project:simone:sync_metadata --dashboard
```

### Integration with Status Command
The `status` command can show when last sync was performed:
```bash
# Add to status command output
echo "Last metadata sync: $(stat -c %y .simone/.cache/last_sync 2>/dev/null || echo 'Never')"
```

## Error Handling and Recovery

### Transaction Safety
- All updates use atomic transactions via metadata-manager.sh
- Rollback capability if sync fails partway through
- Backup files created before major changes

### Common Issues and Solutions

**Issue**: Tasks marked complete but acceptance criteria unchecked
```bash
# Detection
validate_completion_requirements "$task_file"

# Solution
echo "⚠️ Please complete all acceptance criteria before marking task as completed"
```

**Issue**: Sprint shows 100% progress but not marked completed
```bash
# Detection and auto-fix
check_sprint_completion "$sprint_dir"
```

**Issue**: Project manifest out of sync
```bash
# Auto-repair
update_manifest_task_status "$task_id" "$correct_status"
```

## Success Criteria

### Sync Considered Successful When:
- [ ] All task completion requirements validated
- [ ] Sprint completion status matches actual task completion
- [ ] Milestone completion status matches actual sprint completion
- [ ] Project completion status matches actual milestone completion
- [ ] All progress percentages are accurate
- [ ] No metadata consistency errors detected
- [ ] Cross-references are current and valid

### Output Validation
```bash
# Final validation check
if .simone/01_UTILS/metadata-manager.sh validate; then
    echo "🎉 Metadata synchronization completed successfully"
    echo "📊 Project hierarchy is fully consistent"
else
    echo "❌ Synchronization completed with issues"
    echo "   Manual review recommended"
fi
```

---

## Quick Reference

**Common Usage**:
```bash
# Full sync with dashboard
/project:simone:sync_metadata

# Just show current status
/project:simone:sync_metadata --dashboard

# Validate without changes
/project:simone:sync_metadata --validate-only

# Aggressive fix mode
/project:simone:sync_metadata --fix-inconsistencies
```

**Integration Points**:
- Called automatically by `do_task_auto` on completion
- Used by `update_task_status` for hierarchical checking
- Referenced by `status` command for consistency reporting
- Supports `create_pr_auto` for accurate progress in PRs

This command solves the core issue of completion status not propagating properly through the project hierarchy, ensuring accurate progress tracking at all levels.