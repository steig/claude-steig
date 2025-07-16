# Complete Work Item - Unified Completion with Renaming

Marks work items as completed and applies the Simone completion naming convention (X prefix).

**COGNITIVE PERSONAS INTEGRATION:** This command supports domain expertise for comprehensive completion validation.

**AVAILABLE PERSONAS** (reference: `.claude/commands/shared/persona-flags.yml`):
- `--persona-qa`: Quality assurance validation and testing verification
- `--persona-mentor`: Educational completion review and best practices validation
- `--persona-analyzer`: Completion metrics and impact analysis
- `--persona-architect`: Architecture impact assessment and design validation

**ADVANCED FLAGS:**
- `--introspect`: Show transparent reasoning for completion validation decisions
- `--consensus`: Multi-model consensus for complex completion scenarios
- `--think-deep`: Extended analysis for high-impact completions

**USAGE EXAMPLES:**
- `/project:simone:complete_work_item T01_S01` (Complete sprint task)
- `/project:simone:complete_work_item BUG001 --persona-qa` (Complete bug with QA validation)
- `/project:simone:complete_work_item S01_M01 --persona-architect --introspect` (Complete sprint with architecture review)

## Create a TODO with EXACTLY these 7 items

1. Parse arguments and identify work item type
2. Validate completion readiness and criteria
3. Backup current state and validate references
4. Apply completion naming convention (X prefix)
5. Update all cross-references and metadata
6. Update project manifest and tracking files
7. Verify completion and report results

---

## 1 · Parse arguments and identify work item type

**MCP INTEGRATION:** Use MCP servers to enhance completion analysis:
- **GitHub**: Track completion patterns and document completion reasoning
- **Sequential Thinking**: Structure logical completion validation systematically
- **Serena**: Enhance completion verification and cross-reference analysis

**Arguments Format:** `<Work_Item_ID> [--force] [--dry-run]`

**Supported Work Item Types:**
- **Tasks**: `T001`, `T01_S01` → `TX001`, `TX01_S01`
- **Sprints**: `S01_M01` → `SX01_M01`
- **Milestones**: `M01` → `MX01`
- **Bugs**: `BUG001` → `BUGX001`

**Flags:**
- `--force`: Skip validation checks and force completion
- `--dry-run`: Show what would be changed without making changes

**Validation Steps:**
1. **Identify work item type** from ID pattern
2. **Locate primary file/directory** for the work item
3. **Check current status** in metadata
4. **Validate completion eligibility** based on type

## 2 · Validate completion readiness and criteria

**PERSONA ACTIVATION:** Apply relevant personas for completion validation:

**🔧 QA Persona Validation:**
- All acceptance criteria met
- Testing completed and passed
- No open defects or issues
- Quality gates satisfied

**🎓 Mentor Persona Validation:**
- Documentation is complete and accurate
- Code follows best practices
- Knowledge transfer completed
- Learning objectives achieved

**📊 Analyzer Persona Validation:**
- Performance metrics acceptable
- Code quality metrics met
- Technical debt addressed
- Impact analysis completed

**🏗️ Architect Persona Validation:**
- Architecture decisions documented
- System integration verified
- Design patterns properly implemented
- Scalability considerations addressed

**Type-Specific Validation:**

**Tasks:**
- Status is "review" or "testing"
- All acceptance criteria checked off
- Code review completed
- Tests passing
- Documentation updated

**Sprints:**
- All tasks in sprint completed (TX prefix)
- Sprint goals achieved
- Sprint retrospective completed
- Deliverables verified

**Milestones:**
- All sprints in milestone completed (SX prefix)
- Milestone objectives met
- Stakeholder acceptance obtained
- Release criteria satisfied

**Bugs:**
- Root cause identified and addressed
- Fix implemented and tested
- Regression testing completed
- Verification in target environment

## 3 · Backup current state and validate references

**Pre-Completion Backup:**
1. **Create backup** of current work item state
2. **Document current references** to this work item
3. **Validate dependency chain** (what depends on this item)
4. **Check for blocking relationships** (what this item blocks)

**Reference Analysis:**
- Scan all files for references to the work item ID
- Check project manifest for work item mentions
- Validate related items and dependencies
- Document cross-references that need updating

**Safety Checks:**
- Ensure no active dependencies
- Verify no blocking relationships
- Confirm all related work is ready
- Validate completion won't break workflows

## 4 · Apply completion naming convention (X prefix)

**File/Directory Renaming:**

**Tasks:**
```bash
# Sprint tasks
mv "T01_S01_Task_Name.md" "TX01_S01_Task_Name.md"

# General tasks  
mv "T001_Task_Name.md" "TX001_Task_Name.md"
```

**Sprints:**
```bash
# Sprint directories and files
mv "S01_M01_Sprint_Name/" "SX01_M01_Sprint_Name/"
mv "S01_M01_Sprint_Name.md" "SX01_M01_Sprint_Name.md"
```

**Milestones:**
```bash
# Milestone directories and files
mv "M01_Milestone_Name/" "MX01_Milestone_Name/"
# Rename all files within the directory
mv "M01_PRD.md" "MX01_PRD.md"
mv "M01_Specifications.md" "MX01_Specifications.md"
```

**Bugs:**
```bash
# Bug reports
mv "BUG001_Bug_Description.md" "BUGX001_Bug_Description.md"
```

**Git Integration:**
- Use `git mv` to preserve file history
- Commit renaming changes with descriptive message
- Maintain proper Git tracking for renamed files

## 5 · Update all cross-references and metadata

**Metadata Updates:**
```yaml
# Update work item's own metadata
work_item_id: "TX01_S01"  # Updated with X prefix
status: "completed"
completed_date: "2025-01-11"
completion_method: "automated"  # automated, manual
```

**Cross-Reference Updates:**
1. **Project Manifest** (`00_PROJECT_MANIFEST.md`)
   - Update current milestone/sprint if completing active item
   - Update completion counters and progress tracking
   
2. **Related Work Items**
   - Update all files that reference the completed item
   - Change references from `T01_S01` to `TX01_S01`
   - Update dependency lists and related item arrays

3. **Documentation Files**
   - Update links and references in documentation
   - Maintain cross-reference integrity
   - Update status in summary documents

**Systematic Reference Update:**
```bash
# Find and update all references
find .simone -name "*.md" -exec sed -i.bak 's/T01_S01/TX01_S01/g' {} \;
find .simone -name "*.yml" -exec sed -i.bak 's/T01_S01/TX01_S01/g' {} \;
find .simone -name "*.yaml" -exec sed -i.bak 's/T01_S01/TX01_S01/g' {} \;
```

## 6 · Update project manifest and tracking files

**Project Manifest Updates:**
- Update current milestone/sprint if the completed item was active
- Increment completion counters
- Update progress percentages
- Update last_updated timestamp
- Add completion to project history

**Tracking File Updates:**
- Sprint summary files
- Milestone progress tracking
- Velocity and metrics tracking
- Completion dashboards

**Status Propagation:**
- If completing a sprint, check if milestone is now complete
- If completing a milestone, update project phase status
- Update parent item status based on child completions

## 7 · Verify completion and report results

**Verification Checks:**
1. **File/Directory Verification**
   - Confirm all files properly renamed
   - Verify directory structure maintained
   - Check that no references are broken

2. **Metadata Verification**
   - Confirm status updated to "completed"
   - Verify completion date set
   - Check cross-references updated

3. **Git Verification**
   - Confirm changes committed properly
   - Verify file history preserved
   - Check that Git tracking intact

**Completion Report:**
```
✅ WORK ITEM COMPLETION SUMMARY

Work Item: T01_S01_User_Authentication → TX01_S01_User_Authentication
Type: Sprint Task
Status: pending → completed
Completion Date: 2025-01-11

Files Updated:
- Renamed: T01_S01_User_Authentication.md → TX01_S01_User_Authentication.md
- Updated: 00_PROJECT_MANIFEST.md (progress tracking)
- Updated: S01_M01_Sprint_Summary.md (task completion)

Cross-References Updated: 3 files
- Related task references updated
- Documentation links updated  
- Project tracking updated

Next Steps:
- Sprint S01_M01 progress: 3/5 tasks completed
- Consider sprint completion when all tasks done
- Update team on completion status
```

**Error Handling:**
- Report any validation failures
- List any references that couldn't be updated
- Provide rollback instructions if needed
- Suggest manual fixes for complex scenarios

**Integration Notes:**
- This command integrates with existing `update_task_status` when completing tasks
- Can be used by `merge` command when merging completed work
- Supports batch completion operations for efficiency