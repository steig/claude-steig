# Deprecated Utility Scripts

This directory contains utility scripts that have been deprecated in favor of integrated automation capabilities.

## Deprecated Scripts

### `quality-gate-validator.sh.deprecated`
**Deprecated**: 2025-01-14  
**Reason**: Functionality integrated into automated task execution workflows  
**Replacement**: Quality validation is now built into:
- `/project:simone:do_task_auto` - Includes comprehensive quality validation
- GitHub Actions workflow - Automated CI/CD quality gates
- Built-in validation pipeline in automated commands

**Migration**: Remove references to this script and use automated task execution instead.

### `command-validator.sh`
**Status**: Under review for deprecation  
**Reason**: Framework has matured with native validation capabilities  
**Recommendation**: Monitor usage, likely to be deprecated in v3.0.0 if usage is minimal

## Active Scripts (Maintained)

The following scripts remain active and are essential to the framework:

- `git-automation.sh` - Core Git automation functionality
- `hooks-integration.sh` - Essential Claude Code integration  
- `fast-commands.sh` - Core performance optimizations
- `metadata-manager.sh` - Essential metadata handling
- `performance-main.sh` - Central performance dispatcher
- `upgrade-manager.sh` - Framework upgrade management

## Migration Guide

If you have custom scripts or workflows that reference deprecated utilities:

1. **For quality validation**: Use the automated task execution commands instead
2. **For command validation**: Rely on framework's built-in validation
3. **For custom integrations**: Migrate to use the maintained utility scripts

## Future Deprecations

Scripts under consideration for future deprecation:
- `command-validator.sh` - Low usage, redundant with framework validation
- `upgrade-manager.sh` - May be simplified in future versions

Check this file regularly for updates on deprecated utilities.