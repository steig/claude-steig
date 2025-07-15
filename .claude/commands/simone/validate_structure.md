# Validate Structure - Project Structure and Framework Compliance Validation

Performs comprehensive validation of project structure, naming conventions, file organization, and Simone Framework compliance to ensure project maintainability and team productivity.

## Create a TODO with EXACTLY these 7 Items

1. Parse validation arguments and determine scope
2. Validate core Simone directory structure and organization
3. Check naming conventions and file patterns compliance
4. Verify required files and template consistency  
5. Assess project metadata integrity and cross-references
6. Validate workflow integration and automation setup
7. Generate validation report with actionable recommendations

## DETAILS on every TODO item

### 1. Parse validation arguments and determine scope

**Arguments Format:** `[scope] [severity] [--fix-mode] [--output-format]`

**Examples:**
- `/project:simone:validate_structure` (full project validation)
- `/project:simone:validate_structure naming` (naming conventions only)
- `/project:simone:validate_structure --fix-mode=auto` (auto-fix minor issues)
- `/project:simone:validate_structure critical --output=json`

**Validation Scopes:**
- **full**: Complete project structure validation
- **structure**: Directory structure and organization
- **naming**: File and directory naming conventions
- **metadata**: Project metadata and cross-references
- **templates**: Template consistency and completeness
- **workflow**: Git and automation integration
- **compliance**: Framework compliance and best practices

**Severity Levels:**
- **critical**: Issues that break framework functionality
- **error**: Issues that impact productivity or maintainability
- **warning**: Best practice violations or recommendations
- **info**: Informational suggestions for improvement

**Fix Modes:**
- **manual**: Report issues for manual resolution
- **interactive**: Prompt for fixes during validation
- **auto**: Automatically fix safe/minor issues
- **preview**: Show what would be fixed without applying

### 2. Validate core Simone directory structure and organization

**MCP INTEGRATION:** Use MCP servers for enhanced structure validation:
- **Sequential Thinking**: Structure validation checks systematically
- **Serena**: Enhance directory analysis and pattern validation
- **GitHub**: Track structure evolution and compliance trends

**Core Structure Validation:**
```markdown
## 📁 Directory Structure Validation

### Required Directories Check
- ✅/❌ `.simone/` - Framework root directory
- ✅/❌ `.simone/00_PROJECT_MANIFEST.md` - Central project reference
- ✅/❌ `.simone/01_PROJECT_DOCS/` - Technical documentation
- ✅/❌ `.simone/02_REQUIREMENTS/` - Milestone requirements
- ✅/❌ `.simone/03_SPRINTS/` - Sprint organization
- ✅/❌ `.simone/04_GENERAL_TASKS/` - Non-sprint tasks
- ✅/❌ `.simone/05_ARCHITECTURAL_DECISIONS/` - ADR storage
- ✅/❌ `.simone/06_BUGS/` - Bug tracking
- ✅/❌ `.simone/07_TECHNICAL_DEBT/` - Technical debt management
- ✅/❌ `.simone/99_TEMPLATES/` - Document templates

### Directory Organization
- **Numbering Sequence**: {numbering_compliance} (01_, 02_, etc.)
- **Sorting Order**: {sorting_validation} (proper alphabetical order)
- **Missing Directories**: {missing_dirs_list}
- **Extra Directories**: {extra_dirs_list}
- **Empty Required Directories**: {empty_required_dirs}

### Structure Integrity
- **Orphaned Files**: {orphaned_files_count} files in wrong locations
- **Duplicate Structures**: {duplicate_structures} identified
- **Broken Symlinks**: {broken_symlinks} found
- **Permission Issues**: {permission_issues} files/directories
```

**Advanced Structure Checks:**
- **Milestone Structure**: Proper M##_Name/ organization in 02_REQUIREMENTS/
- **Sprint Structure**: Correct S##_M##_Name/ format in 03_SPRINTS/
- **Task Organization**: Proper file distribution between sprints and general tasks
- **Archive Structure**: Completed items properly archived

### 3. Check naming conventions and file patterns compliance

**Naming Convention Validation:**
```markdown
## 📝 Naming Convention Compliance

### File Naming Patterns
- **Project Manifest**: {manifest_naming_status}
  - Expected: `00_PROJECT_MANIFEST.md`
  - Found: {actual_manifest_names}

- **Milestone Files**: {milestone_naming_compliance}%
  - Pattern: `M##_milestone_meta.md`
  - Issues: {milestone_naming_issues}

- **Sprint Files**: {sprint_naming_compliance}%  
  - Pattern: `S##_M##_sprint_meta.md`
  - Issues: {sprint_naming_issues}

- **Task Files**: {task_naming_compliance}%
  - Pattern: `TASK_##_Description.md` or `T##-S##_Description.md`
  - Issues: {task_naming_issues}

- **ADR Files**: {adr_naming_compliance}%
  - Pattern: `ADR_###_Title.md`
  - Issues: {adr_naming_issues}

- **Bug Files**: {bug_naming_compliance}%
  - Pattern: `BUG_###_Description.md`
  - Issues: {bug_naming_issues}

### Directory Naming
- **Milestone Directories**: {milestone_dir_compliance}%
  - Pattern: `M##_Milestone_Name/`
  - Issues: {milestone_dir_issues}

- **Sprint Directories**: {sprint_dir_compliance}%
  - Pattern: `S##_M##_Sprint_Name/`
  - Issues: {sprint_dir_issues}

### Character Set Compliance
- **Forbidden Characters**: {forbidden_chars_found}
- **Case Sensitivity Issues**: {case_issues}
- **Special Character Usage**: {special_char_issues}
- **Length Violations**: {length_violations} (>255 chars)
```

### 4. Verify required files and template consistency

**Required Files Validation:**
```markdown
## 📋 Required Files Check

### Essential Framework Files
- ✅/❌ `00_PROJECT_MANIFEST.md` - {manifest_status}
- ✅/❌ `01_PROJECT_DOCS/ARCHITECTURE.md` - {architecture_status}
- ✅/❌ `99_TEMPLATES/task_template.md` - {task_template_status}
- ✅/❌ `99_TEMPLATES/milestone_meta_template.md` - {milestone_template_status}
- ✅/❌ `99_TEMPLATES/sprint_meta_template.md` - {sprint_template_status}

### Template Consistency
- **Template Version Alignment**: {template_version_status}
- **Required Template Fields**: {template_fields_compliance}%
- **Template Format Validation**: {template_format_issues} issues found
- **Custom Template Detection**: {custom_templates_count} custom templates

### Content Validation
- **YAML Frontmatter**: {yaml_frontmatter_compliance}% compliance
- **Required Metadata Fields**: {required_fields_missing} missing
- **Content Structure**: {content_structure_issues} structural issues
- **Cross-reference Integrity**: {cross_ref_broken} broken references

### File Completeness
- **Empty Required Files**: {empty_required_files}
- **Placeholder Content**: {placeholder_content_count} files with placeholders
- **Missing Documentation**: {missing_docs_list}
- **Outdated Content**: {outdated_content_count} files need updates
```

### 5. Assess project metadata integrity and cross-references

**Metadata Integrity Check:**
```markdown
## 🔗 Metadata Integrity Assessment

### Project Manifest Validation
- **Manifest Completeness**: {manifest_completeness}%
- **Current Milestone Reference**: {current_milestone_valid}
- **Current Sprint Reference**: {current_sprint_valid}
- **Last Updated Field**: {last_updated_status}
- **Version Consistency**: {version_consistency_status}

### Cross-Reference Validation
- **Task → Sprint References**: {task_sprint_refs}% valid
- **Sprint → Milestone References**: {sprint_milestone_refs}% valid
- **Bug → Task References**: {bug_task_refs}% valid
- **ADR → Implementation References**: {adr_impl_refs}% valid

### Status Consistency
- **Task Status Alignment**: {task_status_issues} inconsistencies
- **Sprint Progress Accuracy**: {sprint_progress_issues} calculation errors
- **Milestone Completion**: {milestone_completion_issues} status mismatches
- **Date Consistency**: {date_consistency_issues} timestamp problems

### Dependency Tracking
- **Circular Dependencies**: {circular_deps} detected
- **Orphaned References**: {orphaned_refs} broken links
- **Missing Dependencies**: {missing_deps} undefined references
- **Outdated Links**: {outdated_links} need updates
```

### 6. Validate workflow integration and automation setup

**Workflow Integration Check:**
```markdown
## ⚙️ Workflow Integration Validation

### Git Integration
- **Repository Structure**: {git_structure_status}
- **Branch Strategy**: {branch_strategy_compliance}
- **Commit Message Format**: {commit_format_compliance}%
- **Git Hooks Setup**: {git_hooks_status}

### Automation Setup
- **CI/CD Integration**: {cicd_integration_status}
- **Quality Gates**: {quality_gates_status}
- **Automated Validation**: {auto_validation_status}
- **Deployment Automation**: {deployment_automation_status}

### Tool Configuration
- **Claude Code Integration**: {claude_integration_status}
- **MCP Server Setup**: {mcp_setup_status}
- **Performance Scripts**: {performance_scripts_status}
- **Utility Commands**: {utility_commands_status}

### Process Compliance
- **Review Process Setup**: {review_process_status}
- **Quality Standards**: {quality_standards_status}
- **Documentation Process**: {doc_process_status}
- **Release Management**: {release_mgmt_status}
```

### 7. Generate validation report with actionable recommendations

**Comprehensive Validation Report:**
```markdown
# 🔍 Project Structure Validation Report

## Validation Summary
**Overall Compliance**: {overall_compliance}% | **Critical Issues**: {critical_count} | **Recommended Action**: {action_priority}

## Compliance Scorecard
| Category | Score | Status | Issues | Priority |
|----------|-------|--------|--------|----------|
| Directory Structure | {structure_score}/100 | {structure_status} | {structure_issues} | {structure_priority} |
| Naming Conventions | {naming_score}/100 | {naming_status} | {naming_issues} | {naming_priority} |
| Required Files | {files_score}/100 | {files_status} | {files_issues} | {files_priority} |
| Metadata Integrity | {metadata_score}/100 | {metadata_status} | {metadata_issues} | {metadata_priority} |
| Template Consistency | {template_score}/100 | {template_status} | {template_issues} | {template_priority} |
| Workflow Integration | {workflow_score}/100 | {workflow_status} | {workflow_issues} | {workflow_priority} |

## 🚨 Critical Issues (Immediate Attention Required)
{critical_issues_list}

## ⚠️ Errors (High Priority)
{error_issues_list}

## 📝 Warnings (Medium Priority)  
{warning_issues_list}

## 💡 Recommendations (Continuous Improvement)
{recommendation_list}

## Auto-Fix Available
{auto_fix_summary}

---

## 🔧 Detailed Action Plan

### Immediate Fixes (Critical)
- [ ] **{critical_fix_1}** - {critical_desc_1}
  - **Impact**: {critical_impact_1}
  - **Effort**: {critical_effort_1}
  - **Auto-Fix**: {critical_autofix_1}

- [ ] **{critical_fix_2}** - {critical_desc_2}
  - **Impact**: {critical_impact_2}  
  - **Effort**: {critical_effort_2}
  - **Auto-Fix**: {critical_autofix_2}

### Structure Improvements (High Priority)
- [ ] **{error_fix_1}** - {error_desc_1}
- [ ] **{error_fix_2}** - {error_desc_2}
- [ ] **{error_fix_3}** - {error_desc_3}

### Best Practice Improvements (Medium Priority)
- [ ] **{warning_fix_1}** - {warning_desc_1}
- [ ] **{warning_fix_2}** - {warning_desc_2}

### Continuous Improvement (Low Priority)
- [ ] **{improvement_1}** - {improvement_desc_1}
- [ ] **{improvement_2}** - {improvement_desc_2}

## Auto-Fix Commands

To automatically fix safe issues:
```bash
# Preview auto-fixes
claude-code "/project:simone:validate_structure --fix-mode=preview"

# Apply auto-fixes
claude-code "/project:simone:validate_structure --fix-mode=auto"

# Interactive fixing
claude-code "/project:simone:validate_structure --fix-mode=interactive"
```

## Monitoring & Prevention

### Regular Validation Schedule
- **Daily**: Automated CI validation
- **Weekly**: Team structure review
- **Monthly**: Comprehensive compliance audit
- **Quarterly**: Framework upgrade compliance

### Quality Gates
- Pre-commit structure validation
- PR merge requirements
- Release readiness checks
- Deployment validation

### Team Training
- Framework best practices
- Naming convention guidelines
- Template usage training
- Tool integration setup
```

## Validation Modes

### Quick Validation
```bash
# Fast structural check (30 seconds)
claude-code "/project:simone:validate_structure quick"
```

### Deep Validation
```bash
# Comprehensive analysis (2-5 minutes)
claude-code "/project:simone:validate_structure deep --detailed"
```

### Continuous Validation
```bash
# Set up automated validation
claude-code "/project:simone:setup_validation_hooks"
```

## Integration with Other Commands

### After Structure Changes
```bash
# Validate after major changes
claude-code "/project:simone:validate_structure"
claude-code "/project:simone:status"
```

### During Onboarding
```bash
# New team member validation checklist
claude-code "/project:simone:validate_structure onboarding"
```

### Pre-Release Validation
```bash
# Release readiness structure check
claude-code "/project:simone:validate_structure release"
```

This comprehensive validation system ensures project structure integrity while providing clear guidance for maintaining framework compliance and maximizing team productivity.