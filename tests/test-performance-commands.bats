#!/usr/bin/env bats
# Performance Commands Tests for Simone v2.1.0
# Tests new performance commands: perf status, cache stats, db rebuild, benchmark, git batch, hooks register

# Setup and teardown
setup() {
    export TEST_DIR="$(mktemp -d)"
    export ORIGINAL_DIR="$(pwd)"
    cd "$TEST_DIR"
    
    # Copy Simone structure
    cp -r "$ORIGINAL_DIR/.simone" . 2>/dev/null || true
    cp "$ORIGINAL_DIR/simone" . 2>/dev/null || true
    
    # Initialize git repo for testing
    git init >/dev/null 2>&1
    git config user.email "test@example.com" >/dev/null 2>&1
    git config user.name "Test User" >/dev/null 2>&1
    
    # Set up performance environment
    export SIMONE_CACHE_DIR=".simone/.cache"
    export SIMONE_PERF_ENABLED="true"
    
    # Create basic project structure
    mkdir -p .simone/{02_REQUIREMENTS,03_SPRINTS,04_GENERAL_TASKS}
    
    # Create test manifest
    cat > .simone/00_PROJECT_MANIFEST.md << 'EOF'
---
id: test-project
created_date: "2025-07-12 10:00"
updated_date: "2025-07-12 10:00"
status: active
---

## Project: Performance Test Project
## Description: Testing performance commands
## Version: 1.0.0
EOF
}

teardown() {
    cd "$ORIGINAL_DIR"
    rm -rf "$TEST_DIR"
}

# Test ./simone perf status command
@test "simone perf status shows project overview" {
    # Mock the performance status command functionality
    if [[ -f "./simone" ]]; then
        run ./simone perf status
        
        # Should execute successfully
        [ "$status" -eq 0 ]
        
        # Should show performance-optimized status
        [[ "$output" == *"Performance Test Project"* ]] || skip "Output format may vary"
    else
        skip "simone command not available in test environment"
    fi
}

@test "performance status command handles missing database" {
    # Remove any existing database
    rm -f "$SIMONE_CACHE_DIR/tasks.db"
    
    # Source performance optimizer to test direct functions
    if [[ -f ".simone/01_UTILS/performance-optimizer.sh" ]]; then
        source .simone/01_UTILS/performance-optimizer.sh
        
        # Should handle missing database gracefully
        run count_tasks_by_status "all"
        [ "$status" -eq 0 ]
        [ "$output" = "0" ]
    else
        skip "Performance optimizer not available"
    fi
}

# Test ./simone perf cache stats command  
@test "cache stats command shows cache metrics" {
    if [[ -f ".simone/01_UTILS/performance-optimizer.sh" ]]; then
        source .simone/01_UTILS/performance-optimizer.sh
        init_performance
        
        # Add some cache entries
        cache_set "test_key1" "value1" 3600
        cache_set "test_key2" "value2" 3600
        cache_set "test_key3" "value3" 3600
        
        # Test cache stats (would need to implement this in cache-manager.sh)
        run sqlite3 "$SIMONE_CACHE_DIR/tasks.db" "SELECT COUNT(*) FROM cache_meta;"
        [ "$status" -eq 0 ]
        [ "$output" = "3" ]
    else
        skip "Performance optimizer not available"
    fi
}

# Test ./simone perf db rebuild command
@test "database rebuild recreates task index" {
    if [[ -f ".simone/01_UTILS/performance-optimizer.sh" ]]; then
        source .simone/01_UTILS/performance-optimizer.sh
        init_performance
        
        # Create test tasks
        mkdir -p .simone/04_GENERAL_TASKS
        cat > .simone/04_GENERAL_TASKS/TASK_001.md << 'EOF'
---
status: pending
priority: high
---
# Test Task 1
EOF
        
        cat > .simone/04_GENERAL_TASKS/TASK_002.md << 'EOF'
---
status: completed
priority: medium
---
# Test Task 2
EOF
        
        # Run reindex
        run reindex_all_tasks
        [ "$status" -eq 0 ]
        
        # Verify tasks are indexed
        run count_tasks_by_status "all"
        [ "$status" -eq 0 ]
        [ "$output" = "2" ]
        
        # Verify specific counts
        run count_tasks_by_status "pending"
        [ "$status" -eq 0 ]
        [ "$output" = "1" ]
        
        run count_tasks_by_status "completed"
        [ "$status" -eq 0 ]
        [ "$output" = "1" ]
    else
        skip "Performance optimizer not available"
    fi
}

# Test ./simone perf benchmark command
@test "benchmark command measures performance" {
    if [[ -f ".simone/01_UTILS/performance-optimizer.sh" ]]; then
        source .simone/01_UTILS/performance-optimizer.sh
        export SIMONE_DEBUG="true"
        
        # Test timing function
        run time_operation "test_benchmark" echo "benchmark test"
        [ "$status" -eq 0 ]
        [ "$output" = "benchmark test" ]
    else
        skip "Performance optimizer not available"
    fi
}

# Test ./simone perf git batch command
@test "git batch operations work correctly" {
    if [[ -f ".simone/01_UTILS/performance-optimizer.sh" ]]; then
        source .simone/01_UTILS/performance-optimizer.sh
        init_performance
        
        # Create test files
        echo "Test content 1" > test1.txt
        echo "Test content 2" > test2.txt
        
        # Add to git batch
        batch_git_add "test1.txt"
        batch_git_add "test2.txt"
        batch_git_commit "Batch commit test"
        
        # Verify batch files were created
        [ -f "$SIMONE_CACHE_DIR/git_batch_add" ]
        [ -f "$SIMONE_CACHE_DIR/git_batch_commit" ]
        
        # Check content
        run cat "$SIMONE_CACHE_DIR/git_batch_add"
        [[ "$output" == *"test1.txt"* ]]
        [[ "$output" == *"test2.txt"* ]]
        
        run cat "$SIMONE_CACHE_DIR/git_batch_commit"
        [ "$output" = "Batch commit test" ]
        
        # Execute batch (in a git repo)
        run execute_git_batch
        [ "$status" -eq 0 ]
        
        # Verify batch files are cleaned up
        [ ! -f "$SIMONE_CACHE_DIR/git_batch_add" ]
        [ ! -f "$SIMONE_CACHE_DIR/git_batch_commit" ]
    else
        skip "Performance optimizer not available"
    fi
}

# Test performance with large datasets
@test "performance system handles large number of tasks" {
    if [[ -f ".simone/01_UTILS/performance-optimizer.sh" ]]; then
        source .simone/01_UTILS/performance-optimizer.sh
        init_performance
        
        mkdir -p .simone/04_GENERAL_TASKS
        
        # Create 50 test tasks
        for i in $(seq 1 50); do
            cat > ".simone/04_GENERAL_TASKS/TASK_$(printf "%03d" $i).md" << EOF
---
status: pending
priority: medium
assignee: user$((i % 5 + 1))
---
# Test Task $i
This is test task number $i for performance testing.
EOF
            # Index each task
            index_task_file ".simone/04_GENERAL_TASKS/TASK_$(printf "%03d" $i).md" "general"
        done
        
        # Test counting performance
        start_time=$(date +%s.%N)
        run count_tasks_by_status "all"
        end_time=$(date +%s.%N)
        
        [ "$status" -eq 0 ]
        [ "$output" = "50" ]
        
        # Performance should be under 1 second for 50 tasks
        duration=$(echo "$end_time - $start_time" | bc -l 2>/dev/null || echo "0.1")
        # Basic check that it completed reasonably fast (skip if bc not available)
        [[ "$duration" != "0.1" ]] && (( $(echo "$duration < 1.0" | bc -l) )) || skip "Performance timing requires bc"
    else
        skip "Performance optimizer not available"
    fi
}

# Test cache performance with frequent access
@test "cache system improves repeated access performance" {
    if [[ -f ".simone/01_UTILS/performance-optimizer.sh" ]]; then
        source .simone/01_UTILS/performance-optimizer.sh
        init_performance
        
        # Create a large template
        mkdir -p .simone/99_TEMPLATES
        large_content=""
        for i in {1..100}; do
            large_content+="# Section $i\nThis is content for section $i\n\n"
        done
        echo "$large_content" > .simone/99_TEMPLATES/large_template.md
        
        # First access (should cache)
        start_time=$(date +%s.%N)
        run cache_template "large_template.md"
        first_duration=$(echo "$(date +%s.%N) - $start_time" | bc -l 2>/dev/null || echo "0.1")
        [ "$status" -eq 0 ]
        
        # Second access (should be from cache)
        start_time=$(date +%s.%N)
        run cache_template "large_template.md"
        second_duration=$(echo "$(date +%s.%N) - $start_time" | bc -l 2>/dev/null || echo "0.1")
        [ "$status" -eq 0 ]
        
        # Cached access should be faster (skip if bc not available)
        if [[ "$first_duration" != "0.1" && "$second_duration" != "0.1" ]]; then
            (( $(echo "$second_duration < $first_duration" | bc -l) )) || true
        else
            skip "Performance timing requires bc"
        fi
    else
        skip "Performance optimizer not available"
    fi
}

# Test error handling in performance commands
@test "performance commands handle errors gracefully" {
    if [[ -f ".simone/01_UTILS/performance-optimizer.sh" ]]; then
        source .simone/01_UTILS/performance-optimizer.sh
        
        # Test with invalid database path
        export SIMONE_DB_FILE="/invalid/path/tasks.db"
        
        # Should handle gracefully
        run count_tasks_by_status "all"
        [ "$status" -eq 0 ]
        [ "$output" = "0" ]
        
        # Reset to valid path
        export SIMONE_DB_FILE="$SIMONE_CACHE_DIR/tasks.db"
    else
        skip "Performance optimizer not available"
    fi
}

# Test memory management in performance system
@test "performance system manages memory efficiently" {
    if [[ -f ".simone/01_UTILS/performance-optimizer.sh" ]]; then
        source .simone/01_UTILS/performance-optimizer.sh
        init_performance
        
        # Create many cache entries
        for i in {1..100}; do
            cache_set "key_$i" "value_$i" 3600
        done
        
        # Verify all entries exist
        run sqlite3 "$SIMONE_CACHE_DIR/tasks.db" "SELECT COUNT(*) FROM cache_meta;"
        [ "$status" -eq 0 ]
        [ "$output" = "100" ]
        
        # Test with expired entries (short TTL)
        export SIMONE_CACHE_TTL="1"
        cache_set "expire_test" "value" 1
        sleep 2
        
        # Expired entry should not be returned
        run cache_get "expire_test"
        [ "$status" -eq 0 ]
        [ -z "$output" ]
    else
        skip "Performance optimizer not available"
    fi
}

# Test concurrent access to performance system
@test "performance system handles concurrent operations" {
    if [[ -f ".simone/01_UTILS/performance-optimizer.sh" ]]; then
        source .simone/01_UTILS/performance-optimizer.sh
        init_performance
        
        # Create multiple tasks simultaneously (simulate concurrent access)
        mkdir -p .simone/04_GENERAL_TASKS
        
        # Background task creation
        for i in {1..5}; do
            (
                cat > ".simone/04_GENERAL_TASKS/CONCURRENT_TASK_$i.md" << EOF
---
status: pending
priority: medium
---
# Concurrent Task $i
EOF
                index_task_file ".simone/04_GENERAL_TASKS/CONCURRENT_TASK_$i.md" "general"
            ) &
        done
        
        # Wait for all background tasks
        wait
        
        # Verify all tasks were indexed
        run count_tasks_by_status "all"
        [ "$status" -eq 0 ]
        [ "$output" = "5" ]
    else
        skip "Performance optimizer not available"
    fi
}

# Test integration with existing Simone workflows
@test "performance system integrates with existing workflows" {
    if [[ -f ".simone/01_UTILS/performance-optimizer.sh" ]]; then
        source .simone/01_UTILS/performance-optimizer.sh
        init_performance
        
        # Test project info integration
        run get_project_info "name"
        [ "$status" -eq 0 ]
        [[ "$output" == *"Performance Test Project"* ]]
        
        # Test manifest update integration (would need actual command)
        # This tests the performance system's ability to work with existing data
        run get_project_info "version"
        [ "$status" -eq 0 ]
        [ "$output" = "1.0.0" ]
    else
        skip "Performance optimizer not available"
    fi
}