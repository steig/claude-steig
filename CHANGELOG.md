# Changelog

All notable changes to the Simone framework will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Added
- Initial release of Simone framework
- Core directory structure (`.simone/` and `.claude/commands/simone/`)
- Project management commands:
  - `initialize` - Set up Simone in a project
  - `do_task` - Execute tasks with automatic review
  - `code_review` - Zero-tolerance specification compliance checking
  - `commit` - Smart git commits with logical grouping
  - `project_review` - Comprehensive project health assessment
  - `plan_milestone` - Create milestone structures
  - `create_sprint` - Organize work into sprints
  - `create_task` - Define individual tasks
  - `discuss_review` - Analyze review results
- Template system for consistent documentation
- Example project demonstrating framework usage
- MIT License for open source release

### Framework Structure
- `00_PROJECT_MANIFEST.md` - Central project state tracker
- `01_PROJECT_DOCS/` - Architecture and technical documentation
- `02_REQUIREMENTS/` - Milestone-organized requirements
- `03_SPRINTS/` - Sprint plans and tasks
- `04_GENERAL_TASKS/` - Non-sprint tasks
- `05_ARCHITECTURAL_DECISIONS/` - ADR tracking
- `10_STATE_OF_PROJECT/` - Project health snapshots
- `99_TEMPLATES/` - Reusable templates

## Future Releases

When syncing from Synapsa, document changes here before pushing to GitHub.