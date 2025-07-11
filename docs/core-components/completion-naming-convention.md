# Completion Naming Convention

**Purpose**: Standardized naming convention for completed work items across the Simone framework  
**Scope**: Tasks, Sprints, Milestones, and Bugs

## Overview

The Simone framework uses a consistent "X" prefix to mark completed work items, making it easy to distinguish active work from completed work while maintaining historical context and traceability.

## Naming Convention Rules

### **Tasks** - `T` → `TX`
**Sprint Tasks:**
- Active: `T01_S01_Feature_Name.md`
- Completed: `TX01_S01_Feature_Name.md`

**General Tasks:**
- Active: `T001_Task_Name.md`
- Completed: `TX001_Task_Name.md`

### **Sprints** - `S` → `SX`
**Sprint Directories:**
- Active: `S01_M01_Sprint_Name/`
- Completed: `SX01_M01_Sprint_Name/`

**Sprint Files:**
- Active: `S01_M01_Sprint_Name.md`
- Completed: `SX01_M01_Sprint_Name.md`

### **Milestones** - `M` → `MX`
**Milestone Directories:**
- Active: `M01_Milestone_Name/`
- Completed: `MX01_Milestone_Name/`

**Milestone Files:**
- Active: `M01_PRD.md`, `M01_Specifications.md`
- Completed: `MX01_PRD.md`, `MX01_Specifications.md`

### **Bugs** - `BUG` → `BUGX`
**Bug Reports:**
- Active: `BUG001_Bug_Description.md`
- Completed: `BUGX001_Bug_Description.md`

**Bug Directories (if applicable):**
- Active: `BUG001_Critical_Issue/`
- Completed: `BUGX001_Critical_Issue/`

## Implementation Guidelines

### **Automatic Renaming**
When marking items as completed, the system should:

1. **Rename files and directories** with the "X" prefix
2. **Update all references** in related files
3. **Update project manifest** to reflect completion
4. **Maintain git history** through proper file moves
5. **Update status metadata** in YAML frontmatter

### **Reference Updates**
When items are completed, update references in:

- **Project Manifest** (`00_PROJECT_MANIFEST.md`)
- **Related tasks** that reference the completed item
- **Sprint summaries** and milestone tracking
- **Architectural decisions** that reference the work
- **Documentation links** and cross-references

## File System Organization

### **Completed Work Location**
Completed items remain in their original directories but with renamed identifiers:

```
.simone/
├── 02_REQUIREMENTS/
│   ├── M01_Active_Milestone/
│   └── MX01_Completed_Milestone/      # ← Completed milestone
├── 03_SPRINTS/
│   ├── S01_M01_Active_Sprint/
│   └── SX01_M01_Completed_Sprint/     # ← Completed sprint
├── 04_GENERAL_TASKS/
│   ├── T001_Active_Task.md
│   └── TX001_Completed_Task.md        # ← Completed task
└── 06_BUGS/
    ├── BUG001_Active_Bug.md
    └── BUGX001_Completed_Bug.md       # ← Completed bug
```

### **Benefits of This Approach**
1. **Clear Visual Distinction**: Easy to identify completed vs. active work
2. **Preserved History**: All work remains accessible for reference
3. **Consistent Pattern**: Same logic applies across all work item types
4. **Tool Compatibility**: Scripts and commands can easily filter by prefix
5. **Git Friendly**: File moves preserve history when done properly

## Status Management Integration

### **YAML Frontmatter Updates**
When completing items, update the status metadata:

```yaml
# Before completion
task_id: "T01_S01"
status: "in_progress"
completed_date: null

# After completion  
task_id: "TX01_S01"      # ← Updated with X prefix
status: "completed"
completed_date: "2025-01-11"
```

### **Cross-Reference Updates**
Update all files that reference the completed item:

```yaml
# In related files, update references:
related_tasks: 
  - "T01_S01"     # Before
  - "TX01_S01"    # After

milestone_tasks:
  - "T01_S01"     # Before  
  - "TX01_S01"    # After
```

## Command Integration

### **Existing Commands to Enhance**
1. **`update_task_status`** - Add automatic renaming when status → completed
2. **`merge`** - Handle completion of associated work items
3. **`project_review`** - Report on completion statistics using naming convention

### **New Commands Needed**
1. **`complete_sprint`** - Mark sprint as completed and rename accordingly
2. **`complete_milestone`** - Mark milestone as completed and rename accordingly  
3. **`complete_bug`** - Mark bug as resolved and rename accordingly
4. **`update_references`** - Utility to update cross-references after renaming

## Search and Filtering

### **Finding Completed Work**
The "X" prefix enables easy filtering:

```bash
# Find all completed tasks
find .simone -name "TX*"

# Find all completed sprints  
find .simone -name "SX*"

# Find all completed milestones
find .simone -name "MX*"

# Find all completed bugs
find .simone -name "BUGX*"
```

### **Active Work Filtering**
Similarly, find active work by excluding "X" prefix:

```bash
# Find active tasks (exclude completed)
find .simone -name "T[0-9]*" ! -name "TX*"

# Find active sprints
find .simone -name "S[0-9]*" ! -name "SX*"
```

## Best Practices

### **When to Apply Completion Naming**
- **Tasks**: When status changes to "completed"
- **Sprints**: When all tasks are completed and sprint is closed
- **Milestones**: When all requirements are met and milestone is delivered
- **Bugs**: When bug is verified as resolved and closed

### **Automation Recommendations**
1. **Use git mv** for renaming to preserve history
2. **Update in atomic operations** to maintain consistency
3. **Validate references** before and after renaming
4. **Log all changes** for audit trail
5. **Test automation** with dry-run capabilities

### **Manual Override Support**
Allow manual completion marking for edge cases:
- Items completed outside the normal workflow
- Historical items being imported
- Bulk operations for project cleanup

This consistent naming convention provides a robust foundation for tracking project progress and maintaining a clear history of completed work across the entire Simone framework.