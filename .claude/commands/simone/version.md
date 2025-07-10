# Version Management - Semantic Versioning System

Manages semantic versioning for the project with automatic version calculation and release preparation.

## Create a TODO with EXACTLY these 7 Items

1. Parse arguments and determine version operation
2. Analyze current version and project state
3. Calculate next version based on changes
4. Update version in project files
5. Create version tag and release preparation
6. Update changelog and documentation
7. Provide next steps for release process

## DETAILS on every TODO item

### 1. Parse arguments and determine version operation

**Arguments Format:** `<operation> [version]` or auto-detect

**Operations:**
- **`bump`**: Auto-calculate next version from commits
- **`major`**: Force major version bump (X.0.0)
- **`minor`**: Force minor version bump (0.X.0)
- **`patch`**: Force patch version bump (0.0.X)
- **`prerelease`**: Create pre-release version (1.0.0-alpha.1)
- **`current`**: Display current version information
- **`next`**: Show what next version would be without applying

**Auto-Detection:**
- If no operation specified, default to `bump` with auto-calculation
- Analyze commit history since last version tag
- Determine appropriate version bump based on conventional commits

### 2. Analyze current version and project state

**Version Discovery:**
- Check `package.json` for Node.js projects
- Check `pyproject.toml` or `setup.py` for Python projects
- Check `Cargo.toml` for Rust projects
- Check git tags for version history
- Fall back to `.simone/VERSION` file if no standard file found

**Project State Analysis:**
- Current branch (should be main/master for releases)
- Uncommitted changes (should be clean for releases)
- Recent commits since last version
- Open tasks and bugs
- Milestone completion status

**Version Format Validation:**
```
MAJOR.MINOR.PATCH[-prerelease][+build]
```
Examples:
- `1.0.0` (standard release)
- `1.0.0-alpha.1` (pre-release)
- `1.0.0+build.123` (with build metadata)
- `2.0.0-rc.1+sha.a1b2c3d` (release candidate with git SHA)

### 3. Calculate next version based on changes

**Conventional Commit Analysis:**
Analyze commits since last version tag to determine version bump:

**MAJOR Version (X.0.0) - Breaking Changes:**
- Any commit with `BREAKING CHANGE:` in footer
- Explicitly marked breaking changes
- API contract changes
- Database schema changes requiring migration

**MINOR Version (0.X.0) - New Features:**
- `feat:` commits (new features)
- `perf:` commits (performance improvements)
- New functionality additions
- New API endpoints

**PATCH Version (0.0.X) - Bug Fixes:**
- `fix:` commits (bug fixes)
- `hotfix:` commits (critical fixes)
- `docs:` commits (documentation)
- `style:` commits (formatting)
- `refactor:` commits (code improvements)
- `test:` commits (test additions)
- `chore:` commits (maintenance)

**Pre-release Versions:**
- `alpha`: Early development (1.0.0-alpha.1)
- `beta`: Feature complete, testing (1.0.0-beta.1)
- `rc`: Release candidate (1.0.0-rc.1)

**Version Calculation Examples:**
```bash
# Current: 1.2.3
feat: add user authentication     # → 1.3.0
fix: resolve login issue         # → 1.2.4
feat!: redesign API              # → 2.0.0 (breaking)

# With BREAKING CHANGE footer
feat: new auth system            # → 2.0.0

BREAKING CHANGE: Auth API changed
```

### 4. Update version in project files

**File Updates:**
Automatically update version in all relevant files:

**Node.js Projects:**
- `package.json`: `"version": "1.2.3"`
- `package-lock.json`: Update if exists
- `yarn.lock`: Update if exists

**Python Projects:**
- `pyproject.toml`: `version = "1.2.3"`
- `setup.py`: `version="1.2.3"`
- `__version__.py`: `__version__ = "1.2.3"`

**Rust Projects:**
- `Cargo.toml`: `version = "1.2.3"`
- `Cargo.lock`: Update dependencies

**General Files:**
- `.simone/VERSION`: `1.2.3`
- `README.md`: Update version badges
- `docs/conf.py`: Update documentation version
- `docker-compose.yml`: Update image tags

**Custom Version Files:**
Support project-specific version files through configuration:
```yaml
# .simone/version-config.yml
version_files:
  - path: "src/version.js"
    pattern: "export const VERSION = '{version}'"
  - path: "include/version.h"
    pattern: "#define VERSION \"{version}\""
```

### 5. Create version tag and release preparation

**Git Tagging:**
- Create annotated git tag: `git tag -a v1.2.3 -m "Release v1.2.3"`
- Include release notes in tag message
- Verify tag creation and push to remote

**Release Branch Strategy:**
- **Hotfixes**: Tag directly on main/master
- **Regular Releases**: Create release branch if needed
- **Pre-releases**: Tag on feature branches

**Commit Version Updates:**
```bash
git add .
git commit -m "chore: bump version to v1.2.3

- Update package.json version
- Update documentation
- Prepare for release"
```

**Release Preparation:**
- Generate release notes from templates
- Create GitHub release draft
- Prepare deployment artifacts
- Update milestone status

### 6. Update changelog and documentation

**Changelog Generation:**
Auto-generate changelog from commit history and templates:

```markdown
# Changelog

## [1.2.3] - 2024-12-01

### Added
- User authentication system (T01_S02)
- Password reset functionality (T02_S02)

### Fixed
- Login validation error (BUG001)
- Session timeout issue (BUG002)

### Changed
- Improved error messaging
- Updated dependencies

### Breaking Changes
- Authentication API endpoints changed

### Migration Guide
- Update API calls to use new endpoints
- Regenerate authentication tokens
```

**Documentation Updates:**
- Update API documentation with version
- Update installation instructions
- Update compatibility information
- Regenerate documentation if automated

**Project Manifest Updates:**
- Update current version in manifest
- Update milestone completion status
- Record release date and notes

### 7. Provide next steps for release process

**Release Information Display:**
```markdown
🏷️ **Version Updated Successfully**

📊 **Version Details**:
- **Previous**: v{previous_version}
- **New**: v{new_version}
- **Type**: {version_type} (major/minor/patch)
- **Branch**: {current_branch}

📋 **Changes Included**:
- **Features**: {feature_count} new features
- **Fixes**: {fix_count} bug fixes
- **Breaking**: {breaking_count} breaking changes

🚀 **Next Steps**:

### Immediate Actions
1. **Review Changes**: Verify all version files updated correctly
2. **Test Build**: Run full test suite with new version
3. **Create Release**: Use `/project:simone:release v{new_version}`

### Release Process
1. **Push Tag**: `git push origin v{new_version}`
2. **Deploy Staging**: Test deployment in staging environment
3. **Create Release**: Generate GitHub release with notes
4. **Deploy Production**: Deploy to production when ready

### Quality Checklist
- [ ] All tests passing
- [ ] Documentation updated
- [ ] Changelog reviewed
- [ ] Breaking changes documented
- [ ] Migration guide prepared (if needed)

🔧 **Commands Available**:
- **Create Release**: `/project:simone:release v{new_version}`
- **Deploy**: `/project:simone:deploy v{new_version}`
- **Rollback**: `/project:simone:rollback v{previous_version}` (if needed)
```

## Versioning Strategies

### Semantic Versioning (SemVer)
**Format**: `MAJOR.MINOR.PATCH`

**Rules**:
- **MAJOR**: Incompatible API changes
- **MINOR**: Backward-compatible functionality additions
- **PATCH**: Backward-compatible bug fixes

### Calendar Versioning (CalVer)
**Format**: `YYYY.MM.DD` or `YYYY.MM.MICRO`

**Use Cases**:
- Projects with time-based releases
- Products with regular release schedules
- Marketing-driven version numbers

### Hybrid Versioning
**Format**: `MAJOR.YYYY.MM.PATCH`

**Benefits**:
- Combines semantic meaning with time information
- Clear indication of when features were added
- Maintains compatibility semantics

## Pre-release Management

### Alpha Releases
- **Purpose**: Early development, internal testing
- **Format**: `1.0.0-alpha.1`
- **Stability**: Unstable, breaking changes expected

### Beta Releases
- **Purpose**: Feature complete, external testing
- **Format**: `1.0.0-beta.1`
- **Stability**: Feature-stable, bug fixes only

### Release Candidates
- **Purpose**: Final testing before release
- **Format**: `1.0.0-rc.1`
- **Stability**: Production-ready, critical fixes only

### Pre-release Workflow
```bash
# Create alpha for feature development
/project:simone:version prerelease alpha

# Promote to beta when features complete
/project:simone:version prerelease beta

# Create release candidate
/project:simone:version prerelease rc

# Final release
/project:simone:version bump
```

## Integration Features

### Task/Bug Integration
- Link version changes to completed tasks
- Include task/bug references in changelog
- Validate all milestone tasks complete before major releases

### CI/CD Integration
- Automatic version bumping on merge to main
- Automated testing with version tags
- Deployment triggers based on version tags

### Milestone Integration
- Version releases tied to milestone completion
- Automatic milestone closure on release
- Next milestone planning based on version roadmap

### Quality Gates
- Require clean working directory
- Validate all tests passing
- Ensure documentation is current
- Check for security vulnerabilities

This versioning system provides automated, consistent, and traceable version management that integrates seamlessly with the Simone task management system and supports modern development workflows.