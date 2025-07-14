# Metadata Tracking Issues - Troubleshooting Guide

**Purpose**: Comprehensive troubleshooting guide for completion status and metadata tracking issues in the Simone Framework.

**Updated**: 2025-01-14 | **Version**: 3.0.0

## Overview

This guide addresses common issues with task, sprint, milestone, and project completion status tracking, providing step-by-step solutions for metadata inconsistencies and synchronization problems.

## Common Issues and Solutions

### 1. Tasks Marked Complete But Sprint Still Shows In Progress

**Symptoms**:
- All tasks in sprint are marked "completed"
- Sprint meta file still shows "active" or "in_progress"
- Sprint progress percentage is 100% but status not updated

**Diagnosis**:
```bash
# Check sprint completion status
find .simone/03_SPRINTS -name "*sprint*meta*.md" -exec grep -l "status: active" {} \;

# Count completed vs total tasks in specific sprint
sprint_dir=".simone/03_SPRINTS/S01_M01_Sprint_Name"
total_tasks=$(find "$sprint_dir" -name "*.md" -not -name "*meta*" | wc -l)
completed_tasks=$(grep -l "^status: completed" "$sprint_dir"/*.md 2>/dev/null | wc -l)
echo "Progress: $completed_tasks/$total_tasks"
```

**Solution**:
```bash
# Manual sprint completion check
.simone/01_UTILS/metadata-manager.sh check_completion

# Force sprint status sync
/project:simone:sync_metadata --fix-inconsistencies

# Manual sprint status update (if needed)
sprint_meta_file=".simone/03_SPRINTS/S01_M01_Sprint/sprint_meta.md"
sed -i 's/^status: active/status: completed/' "$sprint_meta_file"
echo "completion_date: $(date '+%Y-%m-%d %H:%M')" >> "$sprint_meta_file"
```

### 2. Task Can't Be Marked Complete Due to Validation Errors

**Symptoms**:
- `update_task_status` fails with completion validation error
- Error message: "Task completion validation failed"
- Acceptance criteria or quality gates blocking completion

**Diagnosis**:
```bash
# Check specific task completion requirements
task_file=".simone/03_SPRINTS/S01_M01_Sprint/TASK_001_feature.md"

# Check uncompleted acceptance criteria
unchecked_criteria=$(grep -c "^- \[ \]" "$task_file" 2>/dev/null || echo "0")
echo "Unchecked criteria: $unchecked_criteria"

# Check quality gates
grep "quality_gate" "$task_file"

# Manual validation check
.simone/01_UTILS/metadata-manager.sh validate_completion "$task_file"
```

**Solution**:
```bash
# Option 1: Complete all acceptance criteria
# Edit task file and change [ ] to [x] for all criteria

# Option 2: Override validation (use cautiously)
# Temporarily bypass validation by updating status directly
sed -i 's/^status: .*/status: completed/' "$task_file"
echo "updated_date: $(date '+%Y-%m-%d %H:%M')" >> "$task_file"

# Option 3: Fix quality gates
# Update quality gate status in task metadata
sed -i 's/quality_gate: failed/quality_gate: passed/' "$task_file"
```

### 3. Project Progress Percentage Incorrect

**Symptoms**:
- Project manifest shows wrong completion percentage
- Progress doesn't match actual milestone completion
- Dashboard shows inconsistent progress numbers

**Diagnosis**:
```bash
# Check current project progress
grep "project_progress" .simone/00_PROJECT_MANIFEST.md

# Manual calculation
total_milestones=$(find .simone/02_REQUIREMENTS -name "M*" -type d | wc -l)
completed_milestones=0

# Count completed milestones
for milestone_dir in .simone/02_REQUIREMENTS/M*; do
    milestone_meta=$(find "$milestone_dir" -name "*milestone*meta*.md" | head -1)
    if [[ -f "$milestone_meta" ]]; then
        status=$(grep "^status:" "$milestone_meta" | cut -d':' -f2 | xargs || echo "active")
        if [[ "$status" == "completed" ]]; then
            ((completed_milestones++))
        fi
    fi
done

expected_progress=$(( (completed_milestones * 100) / total_milestones ))
echo "Expected progress: $expected_progress% ($completed_milestones/$total_milestones)"
```

**Solution**:
```bash
# Comprehensive sync to fix all progress percentages
/project:simone:sync_metadata

# Manual project progress update
manifest_file=".simone/00_PROJECT_MANIFEST.md"
correct_progress="75" # Replace with calculated value

if grep -q "^project_progress:" "$manifest_file"; then
    sed -i "s/^project_progress:.*/project_progress: ${correct_progress}%/" "$manifest_file"
else
    sed -i "s/^---$/project_progress: ${correct_progress}%\n---/" "$manifest_file"
fi
```

### 4. Milestone Status Inconsistencies

**Symptoms**:
- All sprints in milestone completed but milestone still active
- Milestone progress shows 100% but status not "completed"
- Cross-references between sprints and milestones broken

**Diagnosis**:
```bash
# Check specific milestone
milestone_id="M01"
milestone_dir=".simone/02_REQUIREMENTS/${milestone_id}"*
milestone_meta=$(find "$milestone_dir" -name "*milestone*meta*.md" | head -1)

echo "Milestone meta file: $milestone_meta"
grep "^status:" "$milestone_meta"
grep "^progress:" "$milestone_meta"

# Check associated sprints
find .simone/03_SPRINTS -name "*${milestone_id}*" -type d | while read sprint_dir; do
    sprint_meta=$(find "$sprint_dir" -name "*sprint*meta*.md" | head -1)
    if [[ -f "$sprint_meta" ]]; then
        sprint_status=$(grep "^status:" "$sprint_meta" | cut -d':' -f2 | xargs)
        echo "Sprint $(basename "$sprint_dir"): $sprint_status"
    fi
done
```

**Solution**:
```bash
# Check and update milestone completion
.simone/01_UTILS/metadata-manager.sh check_completion

# Manual milestone completion (if automated check fails)
milestone_meta=".simone/02_REQUIREMENTS/M01_Milestone/milestone_meta.md"
sed -i 's/^status: active/status: completed/' "$milestone_meta"
echo "completion_date: $(date '+%Y-%m-%d %H:%M')" >> "$milestone_meta"

# Update progress to 100%
sed -i 's/^progress: .*/progress: 100%/' "$milestone_meta"
```

### 5. Metadata Manager Script Not Working

**Symptoms**:
- Error: "metadata-manager.sh: command not found"
- Functions not available when sourced
- Transaction failures or rollback errors

**Diagnosis**:
```bash
# Check if script exists and is executable
ls -la .simone/01_UTILS/metadata-manager.sh

# Check script syntax
bash -n .simone/01_UTILS/metadata-manager.sh

# Test basic functionality
.simone/01_UTILS/metadata-manager.sh init

# Check if functions are exported
source .simone/01_UTILS/metadata-manager.sh
type -f update_task_status
```

**Solution**:
```bash
# Make script executable
chmod +x .simone/01_UTILS/metadata-manager.sh

# Reinitialize metadata manager
.simone/01_UTILS/metadata-manager.sh init

# Source the script properly
source .simone/01_UTILS/metadata-manager.sh

# Clear any cached state
rm -rf .simone/.cache/transactions/*
```

### 6. Cross-Reference Inconsistencies

**Symptoms**:
- Task references in manifest don't match actual task status
- Sprint summaries show wrong task counts
- Broken links between tasks, sprints, and milestones

**Diagnosis**:
```bash
# Check manifest task references
grep -n "TASK_" .simone/00_PROJECT_MANIFEST.md

# Compare with actual task files
find .simone -name "TASK_*.md" | while read task_file; do
    task_id=$(basename "$task_file" | grep -o "TASK_[0-9]*")
    status=$(grep "^status:" "$task_file" | cut -d':' -f2 | xargs)
    echo "$task_id: $status"
done

# Check for orphaned references
grep -r "TASK_" .simone/ --include="*.md" | grep -v ".md:status:" | head -10
```

**Solution**:
```bash
# Comprehensive cross-reference repair
/project:simone:sync_metadata --fix-inconsistencies

# Manual manifest cleanup (if needed)
# Remove references to non-existent tasks
# Update task statuses to match actual files

# Validate final state
.simone/01_UTILS/metadata-manager.sh validate
```

### 7. Completion Dashboard Shows Wrong Information

**Symptoms**:
- Dashboard percentages don't match manual calculation
- Missing milestones or sprints in dashboard
- Progress bars showing inconsistent values

**Diagnosis**:
```bash
# Generate fresh dashboard
/project:simone:sync_metadata --dashboard

# Compare with manual calculation
echo "=== Manual Calculation ==="
echo "Milestones: $(find .simone/02_REQUIREMENTS -name "M*" -type d | wc -l)"
echo "Sprints: $(find .simone/03_SPRINTS -type d -mindepth 1 | wc -l)"
echo "Tasks: $(find .simone -name "*.md" -path "*/03_SPRINTS/*" -o -path "*/04_GENERAL_TASKS/*" -not -name "*meta*" | wc -l)"

# Check for missing meta files
find .simone/03_SPRINTS -type d -mindepth 1 ! -exec test -f "{}/*meta*.md" \; -print
find .simone/02_REQUIREMENTS -name "M*" -type d ! -exec test -f "{}/*meta*.md" \; -print
```

**Solution**:
```bash
# Force complete recalculation
/project:simone:sync_metadata

# Create missing meta files (if needed)
for sprint_dir in .simone/03_SPRINTS/*/; do
    if [[ ! -f "$sprint_dir"/*meta*.md ]]; then
        sprint_name=$(basename "$sprint_dir")
        echo "Creating missing sprint meta for: $sprint_name"
        cat > "$sprint_dir/sprint_meta.md" <<EOF
---
id: "${sprint_name}"
status: active
progress: 0%
created_date: $(date '+%Y-%m-%d %H:%M')
---

# Sprint Meta: $sprint_name

Auto-generated sprint metadata file.
EOF
    fi
done
```

## Preventive Measures

### 1. Regular Metadata Sync

**Weekly maintenance**:
```bash
# Add to cron or team workflow
0 9 * * 1 cd /path/to/project && /project:simone:sync_metadata --dashboard
```

### 2. Validation Before Major Operations

**Before milestone reviews**:
```bash
/project:simone:sync_metadata --validate-only
```

**Before project completion**:
```bash
/project:simone:sync_metadata
.simone/01_UTILS/metadata-manager.sh validate
```

### 3. Proper Task Completion Workflow

**Always use proper commands**:
```bash
# Correct way to complete tasks
/project:simone:update_task_status TASK_001 completed

# Avoid direct file editing when possible
```

### 4. Monitor Completion Dashboard

**Regular dashboard checks**:
```bash
# Weekly team review
/project:simone:sync_metadata --dashboard
```

## Emergency Recovery Procedures

### Full Metadata Reset and Sync

**When everything is inconsistent**:
```bash
# 1. Backup current state
cp -r .simone .simone.backup.$(date +%Y%m%d)

# 2. Clear cached state
rm -rf .simone/.cache/transactions/*
rm -rf .simone/.cache/validation.log

# 3. Reinitialize metadata manager
.simone/01_UTILS/metadata-manager.sh init

# 4. Force complete sync
/project:simone:sync_metadata --fix-inconsistencies

# 5. Validate results
.simone/01_UTILS/metadata-manager.sh validate
```

### Recovery from Backup

**If sync causes problems**:
```bash
# Restore from backup
rm -rf .simone
cp -r .simone.backup.YYYYMMDD .simone

# Selective restoration of specific components
cp .simone.backup.YYYYMMDD/00_PROJECT_MANIFEST.md .simone/
cp -r .simone.backup.YYYYMMDD/03_SPRINTS/* .simone/03_SPRINTS/
```

## Advanced Diagnostics

### Comprehensive Validation Report

```bash
#!/bin/bash
# comprehensive-validation.sh

echo "=== Simone Metadata Validation Report ==="
echo "Generated: $(date)"
echo ""

# Project structure check
echo "### Project Structure"
echo "- Manifest: $(test -f .simone/00_PROJECT_MANIFEST.md && echo "✅" || echo "❌")"
echo "- Milestones: $(find .simone/02_REQUIREMENTS -name "M*" -type d | wc -l)"
echo "- Sprints: $(find .simone/03_SPRINTS -type d -mindepth 1 | wc -l)"
echo "- Tasks: $(find .simone -name "*.md" -path "*/03_SPRINTS/*" -o -path "*/04_GENERAL_TASKS/*" -not -name "*meta*" | wc -l)"
echo ""

# Status distribution
echo "### Task Status Distribution"
for status in pending in_progress review testing completed blocked; do
    count=$(grep -r "^status: $status" .simone/ --include="*.md" 2>/dev/null | wc -l)
    echo "- $status: $count"
done
echo ""

# Completion validation
echo "### Completion Validation Issues"
validation_errors=0
while IFS= read -r -d '' task_file; do
    task_status=$(grep "^status:" "$task_file" | cut -d':' -f2 | xargs || echo "pending")
    if [[ "$task_status" == "completed" ]]; then
        unchecked=$(grep -c "^- \[ \]" "$task_file" 2>/dev/null || echo "0")
        if [[ $unchecked -gt 0 ]]; then
            echo "❌ $(basename "$task_file"): $unchecked unchecked criteria"
            ((validation_errors++))
        fi
    fi
done < <(find .simone -name "*.md" -path "*/03_SPRINTS/*" -o -path "*/04_GENERAL_TASKS/*" -print0)

if [[ $validation_errors -eq 0 ]]; then
    echo "✅ All completed tasks pass validation"
fi
echo ""

# Cross-reference validation
echo "### Cross-Reference Validation"
orphaned_refs=0
grep -r "TASK_" .simone/ --include="*.md" | grep -v ".md:status:" | while read ref; do
    task_id=$(echo "$ref" | grep -o "TASK_[0-9]*")
    if ! find .simone -name "*$task_id*.md" -type f >/dev/null 2>&1; then
        echo "❌ Orphaned reference: $ref"
        ((orphaned_refs++))
    fi
done

echo ""
echo "=== Validation Complete ==="
echo "Run '/project:simone:sync_metadata' to fix identified issues"
```

This troubleshooting guide provides comprehensive solutions for all metadata tracking issues in the Simone Framework, ensuring accurate completion status across the entire project hierarchy.

## Support Resources

- **Command Reference**: [docs/core-components/command-reference.md](../core-components/command-reference.md)
- **Task Management**: [docs/core-components/task-management.md](../core-components/task-management.md)
- **Quality Assurance**: [docs/workflows/quality-assurance.md](../workflows/quality-assurance.md)
- **Metadata Manager**: [.simone/01_UTILS/metadata-manager.sh](../../.simone/01_UTILS/metadata-manager.sh)

For additional support, create an issue in the project repository with diagnostic output from the validation commands.