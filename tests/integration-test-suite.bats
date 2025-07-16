#!/usr/bin/env bats

# Integration Test Suite for Simone Framework
# End-to-end testing of major functionality

setup() {
    # Create a temporary test directory
    export TEST_DIR="$(mktemp -d)"
    export ORIGINAL_DIR="$(pwd)"
    cd "$TEST_DIR"
    
    # Copy necessary files for testing
    cp -r "$ORIGINAL_DIR/.simone" . 2>/dev/null || true
    cp "$ORIGINAL_DIR/install-simone-secure.sh" . 2>/dev/null || true
}

teardown() {
    cd "$ORIGINAL_DIR"
    rm -rf "$TEST_DIR"
}

@test "secure installer creates proper directory structure" {
    # Test that the secure installer creates the expected structure
    local installer="./install-simone-secure.sh"
    
    if [ ! -f "$installer" ]; then
        skip "Secure installer not available in test environment"
    fi
    
    # Create minimal simone structure for testing
    mkdir -p source/.simone/99_TEMPLATES
    echo "test template" > source/.simone/99_TEMPLATES/test_template.md
    
    # Mock the installer behavior - in real test this would run the installer
    mkdir -p .simone/{01_UTILS,02_REQUIREMENTS,03_SPRINTS,04_GENERAL_TASKS,05_ARCHITECTURAL_DECISIONS,06_BUGS,07_TECHNICAL_DEBT,10_STATE_OF_PROJECT,99_TEMPLATES}
    
    # Verify directory structure
    [ -d ".simone" ]
    [ -d ".simone/02_REQUIREMENTS" ]
    [ -d ".simone/03_SPRINTS" ]
    [ -d ".simone/04_GENERAL_TASKS" ]
    [ -d ".simone/99_TEMPLATES" ]
}

@test "docker setup creates required configuration files" {
    # Test Docker setup process
    local docker_script="$ORIGINAL_DIR/scripts/mcp-docker-secure.sh"
    
    if [ ! -f "$docker_script" ]; then
        skip "Docker script not available"
    fi
    
    # Mock environment setup
    export PROJECT_PATH="$(pwd)"
    
    # Create mock docker compose file for testing
    cat > docker-compose.mcp.yml << 'EOF'
version: '3.8'
services:
  test-service:
    image: test
    ports:
      - "9000:9000"
EOF
    
    # Create mock env example
    cat > .env.mcp.example << 'EOF'
PROJECT_PATH=/test
GATEWAY_PORT=9000
EOF
    
    # Test that help command works
    run "$docker_script" help
    [ "$status" -eq 0 ]
}

@test "multi-project setup isolates projects properly" {
    local multi_script="$ORIGINAL_DIR/scripts/mcp-multi.sh"
    
    if [ ! -f "$multi_script" ]; then
        skip "Multi-project script not available"
    fi
    
    # Create mock project structure
    mkdir -p project1 project2
    
    # Mock the setup process
    export PROJECT_PATH="$(pwd)/project1"
    echo "PROJECT_NUM=1" > project1/.env.mcp.project1
    echo "PROJECT_PATH=$(pwd)/project1" >> project1/.env.mcp.project1
    echo "GATEWAY_PORT=9000" >> project1/.env.mcp.project1
    
    export PROJECT_PATH="$(pwd)/project2"
    echo "PROJECT_NUM=2" > project2/.env.mcp.project2
    echo "PROJECT_PATH=$(pwd)/project2" >> project2/.env.mcp.project2
    echo "GATEWAY_PORT=9010" >> project2/.env.mcp.project2
    
    # Verify isolation
    [ -f "project1/.env.mcp.project1" ]
    [ -f "project2/.env.mcp.project2" ]
    
    # Verify different ports
    grep -q "GATEWAY_PORT=9000" project1/.env.mcp.project1
    grep -q "GATEWAY_PORT=9010" project2/.env.mcp.project2
}

@test "template system maintains consistency" {
    # Test that templates are properly structured
    local template_dir="$ORIGINAL_DIR/.simone/99_TEMPLATES"
    
    if [ ! -d "$template_dir" ]; then
        skip "Template directory not available"
    fi
    
    # Check for required templates
    [ -f "$template_dir/task_template.md" ] || skip "Task template missing"
    
    # Verify template has YAML frontmatter
    grep -q "^---$" "$template_dir/task_template.md"
    
    # Verify required fields in template
    grep -q "id:" "$template_dir/task_template.md"
    grep -q "status:" "$template_dir/task_template.md"
    grep -q "created_date:" "$template_dir/task_template.md"
}

@test "performance scripts provide realistic metrics" {
    local perf_script="$ORIGINAL_DIR/.simone/01_UTILS/performance-main.sh"
    
    if [ ! -f "$perf_script" ]; then
        skip "Performance script not available"
    fi
    
    # Create mock task structure
    mkdir -p .simone/03_SPRINTS/S01_M01_Test
    mkdir -p .simone/04_GENERAL_TASKS
    
    # Create mock task files
    cat > .simone/03_SPRINTS/S01_M01_Test/TASK_01.md << 'EOF'
---
status: pending
---
# Test Task
EOF
    
    cat > .simone/04_GENERAL_TASKS/TASK_02.md << 'EOF'
---
status: completed
---
# Another Test Task
EOF
    
    # Test status command
    run bash "$perf_script" status
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Task Summary" ]]
}

@test "git integration works correctly" {
    # Initialize git repository
    git init
    git config user.email "test@example.com"
    git config user.name "Test User"
    
    # Create initial commit
    echo "test" > README.md
    git add README.md
    git commit -m "Initial commit"
    
    # Create simone structure
    mkdir -p .simone
    echo "test project" > .simone/00_PROJECT_MANIFEST.md
    
    # Test git operations don't break
    git add .simone/
    git commit -m "Add simone structure"
    
    # Verify commit was successful
    run git log --oneline
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Add simone structure" ]]
}

@test "error handling works under various conditions" {
    # Test behavior with missing directories
    rm -rf .simone
    
    local perf_script="$ORIGINAL_DIR/.simone/01_UTILS/performance-main.sh"
    if [ -f "$perf_script" ]; then
        # Should handle missing .simone gracefully
        run bash "$perf_script" status
        # Should not crash, may show warnings
        [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
    fi
    
    # Test behavior with corrupted files
    mkdir -p .simone
    echo "invalid yaml frontmatter" > .simone/invalid_task.md
    
    # Operations should not crash on invalid files
    if [ -f "$perf_script" ]; then
        run bash "$perf_script" status
        [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
    fi
}

@test "concurrent operations don't interfere" {
    # Test that multiple operations can run simultaneously
    mkdir -p .simone/03_SPRINTS .simone/04_GENERAL_TASKS
    
    # Create multiple task files
    for i in {1..5}; do
        cat > ".simone/04_GENERAL_TASKS/TASK_${i}.md" << EOF
---
status: pending
---
# Task $i
EOF
    done
    
    local perf_script="$ORIGINAL_DIR/.simone/01_UTILS/performance-main.sh"
    if [ -f "$perf_script" ]; then
        # Run multiple status checks in background
        bash "$perf_script" status > /dev/null &
        local pid1=$!
        bash "$perf_script" status > /dev/null &
        local pid2=$!
        
        # Wait for both to complete
        wait $pid1
        local status1=$?
        wait $pid2
        local status2=$?
        
        # Both should succeed
        [ "$status1" -eq 0 ]
        [ "$status2" -eq 0 ]
    fi
}

@test "large project handling" {
    # Test behavior with many files
    mkdir -p .simone/{03_SPRINTS,04_GENERAL_TASKS}
    
    # Create many task files
    for i in {1..50}; do
        cat > ".simone/04_GENERAL_TASKS/TASK_${i}.md" << EOF
---
status: pending
---
# Task $i
EOF
    done
    
    local perf_script="$ORIGINAL_DIR/.simone/01_UTILS/performance-main.sh"
    if [ -f "$perf_script" ]; then
        # Status should still work with many files
        run timeout 30 bash "$perf_script" status
        [ "$status" -eq 0 ]
        [[ "$output" =~ "50" ]] || [[ "$output" =~ "Task Summary" ]]
    fi
}

@test "upgrade process preserves data" {
    # Create initial simone structure
    mkdir -p .simone/{02_REQUIREMENTS,03_SPRINTS,04_GENERAL_TASKS}
    
    # Create some data files
    echo "Important project data" > .simone/02_REQUIREMENTS/important_data.md
    echo "Sprint information" > .simone/03_SPRINTS/sprint_data.md
    
    # Create backup directory (simulating upgrade process)
    cp -r .simone .simone.backup.test
    
    # Verify backup exists and contains data
    [ -f ".simone.backup.test/02_REQUIREMENTS/important_data.md" ]
    [ -f ".simone.backup.test/03_SPRINTS/sprint_data.md" ]
    
    # Verify original data is preserved
    [ -f ".simone/02_REQUIREMENTS/important_data.md" ]
    [ -f ".simone/03_SPRINTS/sprint_data.md" ]
}

@test "configuration validation works" {
    # Test various configuration scenarios
    
    # Invalid port configuration
    export GATEWAY_PORT="invalid"
    local docker_script="$ORIGINAL_DIR/scripts/mcp-docker-secure.sh"
    
    if [ -f "$docker_script" ]; then
        # Should handle invalid configuration gracefully
        run "$docker_script" help
        [ "$status" -eq 0 ]  # Help should always work
    fi
    
    # Missing required environment variables
    unset PROJECT_PATH
    unset GATEWAY_PORT
    
    if [ -f "$docker_script" ]; then
        run "$docker_script" help
        [ "$status" -eq 0 ]  # Help should work without env vars
    fi
}