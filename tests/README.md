# Simone Install Script Tests

This directory contains comprehensive tests for the `install-simone.sh` script to ensure it works correctly across different environments and scenarios.

## Test Structure

### GitHub Workflow Tests (`.github/workflows/test-install.yml`)
Automated tests that run on every push and pull request:

- **Multi-OS Testing**: Tests on Ubuntu and macOS
- **Multiple Scenarios**: Fresh install, upgrade, force reinstall, target directory, project detection
- **Security Tests**: Validates script safety and backup behavior
- **Command Verification**: Ensures all Simone commands are properly installed

### Shell Script Tests (`tests/`)

#### Verification Scripts
- `verify-installation.sh`: Verifies a complete Simone installation
- `verify-upgrade.sh`: Verifies upgrade behavior and data preservation  
- `verify-commands.sh`: Verifies all Simone commands are properly installed

#### Unit Tests
- `test-install-unit.bats`: BATS unit tests for individual script functions

## Running Tests Locally

### Prerequisites
```bash
# Install BATS (for unit tests)
# On macOS:
brew install bats-core

# On Ubuntu:
sudo apt-get install bats
```

### Run All Tests
```bash
# Run verification tests on a fresh installation
cd your-project-directory
echo "y" | ./install-simone.sh
./tests/verify-installation.sh

# Run unit tests
bats tests/test-install-unit.bats
```

### Run Specific Test Scenarios

#### Test Fresh Installation
```bash
mkdir test-fresh && cd test-fresh
echo '{"name": "test-project"}' > package.json
echo "y" | path/to/install-simone.sh
path/to/tests/verify-installation.sh
```

#### Test Upgrade Scenario
```bash
mkdir test-upgrade && cd test-upgrade
echo '{"name": "test-project"}' > package.json

# Create fake old installation
mkdir -p .simone/01_PROJECT_DOCS
echo "# Old Doc" > .simone/01_PROJECT_DOCS/important.md
echo "1.0.0" > .simone/.version

# Run upgrade
echo "y" | path/to/install-simone.sh
path/to/tests/verify-upgrade.sh
```

#### Test Target Directory Installation
```bash
echo "y" | ./install-simone.sh /path/to/target/directory
cd /path/to/target/directory
path/to/tests/verify-installation.sh
```

## Test Coverage

### Installation Scenarios
- ✅ Fresh installation in project directory
- ✅ Upgrade from previous version
- ✅ Force reinstall over existing installation
- ✅ Installation to specific target directory
- ✅ Installation in different project types (Node.js, Python, Rust, Git)

### Project Detection
- ✅ Node.js projects (`package.json`)
- ✅ Python projects (`requirements.txt`)
- ✅ Rust projects (`Cargo.toml`)
- ✅ Git repositories (`.git`)
- ✅ Generic directories

### Error Handling
- ✅ Invalid command line arguments
- ✅ Missing source files
- ✅ Permission issues
- ✅ Backup creation and restoration

### Security Validation
- ✅ No dangerous operations (`rm -rf /`, `sudo`, etc.)
- ✅ Proper backup behavior
- ✅ User data preservation during upgrades
- ✅ Script permissions and safety

### Component Verification
- ✅ All required directories created
- ✅ Templates properly copied
- ✅ All Simone commands installed
- ✅ CLAUDE.md instruction files copied
- ✅ Version file created correctly
- ✅ Project manifest generated

## Adding New Tests

### For New Installation Features
1. Add test case to `test-install.yml` workflow
2. Update verification scripts if needed
3. Add unit tests to `test-install-unit.bats`

### For New Commands
1. Update expected commands list in `verify-commands.sh`
2. Add command-specific verification if needed

### Test Guidelines
- Each test should be independent and not affect others
- Use temporary directories for file system tests
- Clean up test artifacts in teardown
- Test both success and failure scenarios
- Verify exact behavior, not just "it works"

## Continuous Integration

Tests run automatically on:
- Push to main/master/develop branches
- Pull requests modifying install script or related files
- Manual workflow dispatch

Test results are available in GitHub Actions, with artifacts uploaded for failed tests to aid debugging.

## Troubleshooting Tests

### Common Issues
1. **Permission denied**: Ensure test scripts are executable (`chmod +x tests/*.sh`)
2. **BATS not found**: Install BATS testing framework
3. **Path issues**: Tests assume install script is in repository root
4. **Timeout in CI**: Project detection tests may timeout on input prompts

### Debugging Failed Tests
1. Check GitHub Actions logs for detailed error output
2. Download test artifacts for examination
3. Run tests locally with same conditions
4. Add debug output to scripts if needed

### Local Testing Tips
```bash
# Run with debug output
bash -x tests/verify-installation.sh

# Test specific scenarios
TEST_DEBUG=1 bats tests/test-install-unit.bats

# Clean test environment
rm -rf test-* && mkdir test-clean && cd test-clean
```