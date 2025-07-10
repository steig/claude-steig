#!/usr/bin/env bats
# Unit tests for individual install script functions

# Setup and teardown
setup() {
    # Create temporary test directory
    export TEST_DIR="$(mktemp -d)"
    export ORIGINAL_DIR="$(pwd)"
    cd "$TEST_DIR"
    
    # Copy install script to test directory
    cp "$ORIGINAL_DIR/install-simone.sh" .
    cp -r "$ORIGINAL_DIR/.simone" . 2>/dev/null || true
    cp -r "$ORIGINAL_DIR/.claude" . 2>/dev/null || true
    
    # Source the script to access functions
    source install-simone.sh
}

teardown() {
    cd "$ORIGINAL_DIR"
    rm -rf "$TEST_DIR"
}

@test "check_project_directory detects Node.js project" {
    echo '{"name": "test-project"}' > package.json
    run check_project_directory
    [ "$status" -eq 0 ]
}

@test "check_project_directory detects Python project" {
    echo "requests==2.28.0" > requirements.txt
    run check_project_directory
    [ "$status" -eq 0 ]
}

@test "check_project_directory detects Rust project" {
    echo '[package]' > Cargo.toml
    echo 'name = "test-project"' >> Cargo.toml
    run check_project_directory
    [ "$status" -eq 0 ]
}

@test "check_project_directory detects Git repository" {
    git init
    git config user.email "test@example.com"
    git config user.name "Test User"
    run check_project_directory
    [ "$status" -eq 0 ]
}

@test "detect_installation returns false for fresh directory" {
    run detect_installation
    [ "$status" -eq 1 ]
    [ "$INSTALLED_VERSION" = "" ]
}

@test "detect_installation detects existing installation with version" {
    mkdir -p .simone
    echo "2.0.1" > .simone/.version
    run detect_installation
    [ "$status" -eq 0 ]
    [ "$INSTALLED_VERSION" = "2.0.1" ]
}

@test "detect_installation detects legacy installation without version" {
    mkdir -p .simone
    run detect_installation
    [ "$status" -eq 0 ]
    [ "$INSTALLED_VERSION" = "legacy" ]
}

@test "backup_installation creates backup directory" {
    mkdir -p .simone
    echo "test content" > .simone/test.md
    
    run backup_installation
    [ "$status" -eq 0 ]
    
    # Check backup was created
    backup_dirs=($(ls -d .simone.backup.* 2>/dev/null || true))
    [ ${#backup_dirs[@]} -eq 1 ]
    [ -f "${backup_dirs[0]}/test.md" ]
}

@test "install_core_structure creates required directories" {
    # Mock source directory
    mkdir -p mock-source/.simone/99_TEMPLATES
    echo "# Template" > mock-source/.simone/99_TEMPLATES/test_template.md
    
    run install_core_structure "mock-source"
    [ "$status" -eq 0 ]
    
    # Check directories were created
    [ -d .simone/01_PROJECT_DOCS ]
    [ -d .simone/02_REQUIREMENTS ]
    [ -d .simone/03_SPRINTS ]
    [ -d .simone/04_GENERAL_TASKS ]
    [ -d .simone/05_ARCHITECTURAL_DECISIONS ]
    [ -d .simone/10_STATE_OF_PROJECT ]
    [ -d .simone/99_TEMPLATES ]
    
    # Check template was copied
    [ -f .simone/99_TEMPLATES/test_template.md ]
}

@test "install_commands creates .claude structure" {
    # Mock source directory with commands
    mkdir -p mock-source/.claude/commands/simone
    echo "# Command" > mock-source/.claude/commands/simone/test_command.md
    
    run install_commands "mock-source"
    [ "$status" -eq 0 ]
    
    # Check structure was created
    [ -d .claude/commands ]
    [ -d .claude/commands/simone ]
    [ -f .claude/commands/simone/test_command.md ]
}

@test "install_commands handles missing source gracefully" {
    run install_commands "non-existent-source"
    [ "$status" -eq 0 ]
    
    # Should still create basic structure
    [ -d .claude ]
    [ -d .claude/commands ]
}

@test "set_version creates correct version file" {
    mkdir -p .simone
    run set_version
    [ "$status" -eq 0 ]
    [ -f .simone/.version ]
    
    version=$(cat .simone/.version)
    [ "$version" = "2.0.2" ]
}

@test "create_initial_manifest detects project name from package.json" {
    echo '{"name": "my-awesome-project"}' > package.json
    mkdir -p .simone/99_TEMPLATES
    
    # Create a simple template
    cat > .simone/99_TEMPLATES/project_manifest_template.md << 'EOF'
# {PROJECT_NAME}
Created: {CREATED_DATE}
Updated: {UPDATED_DATE}
EOF
    
    run create_initial_manifest
    [ "$status" -eq 0 ]
    [ -f .simone/00_PROJECT_MANIFEST.md ]
    
    # Check project name was substituted
    grep -q "my-awesome-project" .simone/00_PROJECT_MANIFEST.md
}

@test "create_initial_manifest detects project name from Cargo.toml" {
    cat > Cargo.toml << 'EOF'
[package]
name = "rust-project"
version = "0.1.0"
EOF
    
    mkdir -p .simone/99_TEMPLATES
    cat > .simone/99_TEMPLATES/project_manifest_template.md << 'EOF'
# {PROJECT_NAME}
EOF
    
    run create_initial_manifest
    [ "$status" -eq 0 ]
    
    grep -q "rust-project" .simone/00_PROJECT_MANIFEST.md
}

@test "create_initial_manifest uses directory name as fallback" {
    # No project files, should use directory name
    mkdir -p .simone/99_TEMPLATES
    cat > .simone/99_TEMPLATES/project_manifest_template.md << 'EOF'
# {PROJECT_NAME}
EOF
    
    run create_initial_manifest
    [ "$status" -eq 0 ]
    
    # Should contain the temp directory name (or at least not the placeholder)
    ! grep -q "{PROJECT_NAME}" .simone/00_PROJECT_MANIFEST.md
}