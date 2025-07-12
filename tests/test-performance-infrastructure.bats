#!/usr/bin/env bats
# Performance Infrastructure Tests for Simone v2.1.0
# Tests new performance optimization features including SQLite database, caching, and batch operations

# Setup and teardown
setup() {
    export TEST_DIR="$(mktemp -d)"
    export ORIGINAL_DIR="$(pwd)"
    cd "$TEST_DIR"
    
    # Copy Simone structure and performance scripts
    cp -r "$ORIGINAL_DIR/.simone" . 2>/dev/null || true
    
    # Initialize performance system
    export SIMONE_CACHE_DIR=".simone/.cache"
    export SIMONE_CACHE_TTL="300"
    export SIMONE_DB_FILE="$SIMONE_CACHE_DIR/tasks.db"
    export SIMONE_PERF_ENABLED="true"
    
    # Source performance optimizer
    source "$ORIGINAL_DIR/.simone/01_UTILS/performance-optimizer.sh" 2>/dev/null || true
}

teardown() {
    cd "$ORIGINAL_DIR"
    rm -rf "$TEST_DIR"
}

# Performance System Initialization Tests
@test "performance system initializes correctly" {
    run init_performance
    [ "$status" -eq 0 ]
    [ -d "$SIMONE_CACHE_DIR" ]
}

@test "task database is created with correct schema" {
    init_performance
    
    # Check if database file exists
    [ -f "$SIMONE_DB_FILE" ]
    
    # Verify tables exist
    run sqlite3 "$SIMONE_DB_FILE" "SELECT name FROM sqlite_master WHERE type='table';"
    [ "$status" -eq 0 ]
    [[ "$output" == *"tasks"* ]]
    [[ "$output" == *"cache_meta"* ]]
    
    # Verify indexes exist
    run sqlite3 "$SIMONE_DB_FILE" "SELECT name FROM sqlite_master WHERE type='index';"
    [ "$status" -eq 0 ]
    [[ "$output" == *"idx_status"* ]]
    [[ "$output" == *"idx_sprint"* ]]
    [[ "$output" == *"idx_priority"* ]]
}

# Caching System Tests
@test "cache_set and cache_get work correctly" {
    init_performance
    
    # Set a cache value
    run cache_set "test_key" "test_value" 3600
    [ "$status" -eq 0 ]
    
    # Get the cached value
    run cache_get "test_key"
    [ "$status" -eq 0 ]
    [ "$output" = "test_value" ]
}

@test "cache respects TTL expiration" {
    init_performance
    
    # Set a cache value with very short TTL
    export SIMONE_CACHE_TTL="1"
    cache_set "expire_test" "value" 1
    
    # Should get value immediately
    run cache_get "expire_test"
    [ "$status" -eq 0 ]
    [ "$output" = "value" ]
    
    # Wait for expiration
    sleep 2
    
    # Should return empty after expiration
    run cache_get "expire_test"
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "template caching works correctly" {
    init_performance
    
    # Create a test template
    mkdir -p ".simone/99_TEMPLATES"
    echo "# Test Template Content" > ".simone/99_TEMPLATES/test_template.md"
    
    # Cache the template
    run cache_template "test_template.md"
    [ "$status" -eq 0 ]
    [[ "$output" == *"Test Template Content"* ]]
    
    # Verify it's cached in database
    run sqlite3 "$SIMONE_DB_FILE" "SELECT value FROM cache_meta WHERE key='template_test_template.md';"
    [ "$status" -eq 0 ]
    [[ "$output" == *"Test Template Content"* ]]
}

# Task Database Tests
@test "task indexing works correctly" {
    init_performance
    
    # Create test task directory
    mkdir -p ".simone/04_GENERAL_TASKS"
    
    # Create a test task file
    cat > ".simone/04_GENERAL_TASKS/TASK_001_test_task.md" << 'EOF'
---
status: pending
priority: high
assignee: test-user
---

# Test Task Implementation

This is a test task for performance testing.
EOF
    
    # Index the task
    run index_task_file ".simone/04_GENERAL_TASKS/TASK_001_test_task.md" "general"
    [ "$status" -eq 0 ]
    
    # Verify task is in database
    run sqlite3 "$SIMONE_DB_FILE" "SELECT title FROM tasks WHERE id='TASK_001_test_task';"
    [ "$status" -eq 0 ]
    [[ "$output" == *"Test Task Implementation"* ]]
    
    # Verify metadata is correct
    run sqlite3 "$SIMONE_DB_FILE" "SELECT status, priority, assignee FROM tasks WHERE id='TASK_001_test_task';"
    [ "$status" -eq 0 ]
    [[ "$output" == *"pending"* ]]
    [[ "$output" == *"high"* ]]
    [[ "$output" == *"test-user"* ]]
}

@test "task counting by status works" {
    init_performance
    
    # Create multiple test tasks with different statuses
    mkdir -p ".simone/04_GENERAL_TASKS"
    
    # Pending task
    cat > ".simone/04_GENERAL_TASKS/TASK_001.md" << 'EOF'
---
status: pending
priority: medium
---
# Pending Task
EOF
    
    # In progress task
    cat > ".simone/04_GENERAL_TASKS/TASK_002.md" << 'EOF'
---
status: in_progress
priority: high
---
# In Progress Task
EOF
    
    # Completed task
    cat > ".simone/04_GENERAL_TASKS/TASK_003.md" << 'EOF'
---
status: completed
priority: low
---
# Completed Task
EOF
    
    # Index all tasks
    index_task_file ".simone/04_GENERAL_TASKS/TASK_001.md" "general"
    index_task_file ".simone/04_GENERAL_TASKS/TASK_002.md" "general"
    index_task_file ".simone/04_GENERAL_TASKS/TASK_003.md" "general"
    
    # Test counting
    run count_tasks_by_status "pending"
    [ "$status" -eq 0 ]
    [ "$output" = "1" ]
    
    run count_tasks_by_status "in_progress"
    [ "$status" -eq 0 ]
    [ "$output" = "1" ]
    
    run count_tasks_by_status "completed"
    [ "$status" -eq 0 ]
    [ "$output" = "1" ]
    
    run count_tasks_by_status "all"
    [ "$status" -eq 0 ]
    [ "$output" = "3" ]
}

@test "task listing by status works with priority ordering" {
    init_performance
    
    mkdir -p ".simone/04_GENERAL_TASKS"
    
    # Create tasks with different priorities
    cat > ".simone/04_GENERAL_TASKS/TASK_LOW.md" << 'EOF'
---
status: pending
priority: low
assignee: user1
---
# Low Priority Task
EOF
    
    cat > ".simone/04_GENERAL_TASKS/TASK_HIGH.md" << 'EOF'
---
status: pending
priority: high
assignee: user2
---
# High Priority Task
EOF
    
    cat > ".simone/04_GENERAL_TASKS/TASK_MED.md" << 'EOF'
---
status: pending
priority: medium
assignee: user3
---
# Medium Priority Task
EOF
    
    # Index tasks
    index_task_file ".simone/04_GENERAL_TASKS/TASK_LOW.md" "general"
    index_task_file ".simone/04_GENERAL_TASKS/TASK_HIGH.md" "general"
    index_task_file ".simone/04_GENERAL_TASKS/TASK_MED.md" "general"
    
    # List tasks by status - should be ordered by priority (high, medium, low)
    run list_tasks_by_status "pending" 10
    [ "$status" -eq 0 ]
    
    # High priority should come first
    [[ "$output" == *"TASK_HIGH"* ]]
    [[ "$output" == *"High Priority Task"* ]]
    [[ "$output" == *"user2"* ]]
}

# Git Batching Tests
@test "git operation batching works" {
    init_performance
    
    # Test batch add
    run batch_git_add "test_file1.txt"
    [ "$status" -eq 0 ]
    
    run batch_git_add "test_file2.txt"
    [ "$status" -eq 0 ]
    
    # Check batch file exists with correct content
    [ -f "$SIMONE_CACHE_DIR/git_batch_add" ]
    run cat "$SIMONE_CACHE_DIR/git_batch_add"
    [[ "$output" == *"test_file1.txt"* ]]
    [[ "$output" == *"test_file2.txt"* ]]
    
    # Test batch commit message
    run batch_git_commit "Test batch commit message"
    [ "$status" -eq 0 ]
    
    # Check commit file exists
    [ -f "$SIMONE_CACHE_DIR/git_batch_commit" ]
    run cat "$SIMONE_CACHE_DIR/git_batch_commit"
    [ "$output" = "Test batch commit message" ]
}

# Project Info Caching Tests
@test "project info caching works" {
    init_performance
    
    # Create test manifest
    mkdir -p ".simone"
    cat > ".simone/00_PROJECT_MANIFEST.md" << 'EOF'
---
project_name: "Test Project Name"
project_version: "1.0.0"
project_description: "A test project for performance testing"
---

# Test Project Name - Project Manifest

## Description
A test project for performance testing

## Version: 1.0.0
EOF
    
    # Test project info extraction and caching
    run get_project_info "name"
    [ "$status" -eq 0 ]
    [[ "$output" == *"Test Project Name"* ]]
    
    # Verify it's cached
    run cache_get "project_name"
    [ "$status" -eq 0 ]
    [[ "$output" == *"Test Project Name"* ]]
    
    # Test other fields
    run get_project_info "description"
    [ "$status" -eq 0 ]
    [[ "$output" == *"A test project for performance testing"* ]]
    
    run get_project_info "version"
    [ "$status" -eq 0 ]
    [[ "$output" == *"1.0.0"* ]]
}

# Batch File Operations Tests
@test "batch file operations work correctly" {
    init_performance
    
    # Create test files
    mkdir -p "test_files"
    echo "Content 1" > "test_files/file1.txt"
    echo "Content 2" > "test_files/file2.txt"
    echo "Content 3" > "test_files/file3.txt"
    
    # Create file list
    files_list=$(printf "test_files/file1.txt\ntest_files/file2.txt\ntest_files/file3.txt")
    
    # Test batch read
    run batch_read_files "$files_list" "output_dir"
    [ "$status" -eq 0 ]
    
    # Verify output directory and files
    [ -d "output_dir" ]
    [ -f "output_dir/file1.txt" ]
    [ -f "output_dir/file2.txt" ]
    [ -f "output_dir/file3.txt" ]
    
    # Verify content
    run cat "output_dir/file1.txt"
    [ "$output" = "Content 1" ]
}

# Complete Reindexing Tests
@test "complete task reindexing works" {
    init_performance
    
    # Create sprint and general task structures
    mkdir -p ".simone/03_SPRINTS/S01_M01_Sprint/tasks"
    mkdir -p ".simone/04_GENERAL_TASKS"
    
    # Create sprint task
    cat > ".simone/03_SPRINTS/S01_M01_Sprint/TASK_S01_001.md" << 'EOF'
---
status: in_progress
priority: high
---
# Sprint Task
EOF
    
    # Create general task
    cat > ".simone/04_GENERAL_TASKS/TASK_GEN_001.md" << 'EOF'
---
status: pending
priority: medium
---
# General Task
EOF
    
    # Run reindexing
    run reindex_all_tasks
    [ "$status" -eq 0 ]
    
    # Verify both tasks are indexed
    run count_tasks_by_status "all"
    [ "$status" -eq 0 ]
    [ "$output" = "2" ]
    
    # Verify cache metadata is updated
    run sqlite3 "$SIMONE_DB_FILE" "SELECT value FROM cache_meta WHERE key='last_index';"
    [ "$status" -eq 0 ]
    [ "$output" = "complete" ]
}

# Performance Timing Tests
@test "performance timing works" {
    init_performance
    
    # Enable debug mode for timing
    export SIMONE_DEBUG="true"
    
    # Test timing a simple operation
    run time_operation "test_sleep" sleep 0.1
    [ "$status" -eq 0 ]
}

# Performance System Disable Tests
@test "performance system can be disabled" {
    init_performance
    
    # Verify database exists
    [ -f "$SIMONE_DB_FILE" ]
    
    # Disable performance system  
    source .simone/01_UTILS/performance-main.sh
    perf_command "disable"
    
    # Database should be removed after disable
    [ ! -f "$SIMONE_DB_FILE" ]
    [ ! -d ".simone/.cache" ]
}

# Error Handling Tests
@test "performance system handles missing files gracefully" {
    init_performance
    
    # Try to cache non-existent template
    run cache_template "non_existent_template.md"
    [ "$status" -eq 1 ]
    
    # Try to index non-existent task file
    run index_task_file "non_existent_task.md" "general"
    [ "$status" -eq 1 ]
}

@test "performance system handles SQL injection safely" {
    init_performance
    
    # Try to inject SQL in cache operations
    run cache_set "test'; DROP TABLE tasks; --" "malicious_value"
    [ "$status" -eq 0 ]
    
    # Verify tables still exist
    run sqlite3 "$SIMONE_DB_FILE" "SELECT name FROM sqlite_master WHERE type='table';"
    [ "$status" -eq 0 ]
    [[ "$output" == *"tasks"* ]]
    [[ "$output" == *"cache_meta"* ]]
}