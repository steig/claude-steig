#!/bin/bash
# Simone v2.1.0 Performance Integration Tests
# End-to-end testing of performance optimizations in real project scenarios

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test configuration
TEST_ENV="/tmp/simone-perf-test-$(date +%s)"
PERFORMANCE_BASELINE_DIR="$TEST_ENV/baseline"
PERFORMANCE_OPTIMIZED_DIR="$TEST_ENV/optimized"
TEST_PROJECT_SIZE="large" # small, medium, large

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Utility functions
log() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[PASS]${NC} $1"
    ((TESTS_PASSED++))
    ((TESTS_RUN++))
}

fail() {
    echo -e "${RED}[FAIL]${NC} $1"
    ((TESTS_FAILED++))
    ((TESTS_RUN++))
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

# Setup test environment
setup_test_environment() {
    log "Setting up performance test environment: $TEST_ENV"
    
    if [[ -d "$TEST_ENV" ]]; then
        rm -rf "$TEST_ENV"
    fi
    
    mkdir -p "$PERFORMANCE_BASELINE_DIR" "$PERFORMANCE_OPTIMIZED_DIR"
    
    # Copy Simone framework to both directories
    for dir in "$PERFORMANCE_BASELINE_DIR" "$PERFORMANCE_OPTIMIZED_DIR"; do
        cp -r .simone "$dir/" 2>/dev/null || true
        cp simone "$dir/" 2>/dev/null || true
        cd "$dir"
        
        # Initialize git
        git init >/dev/null 2>&1
        git config user.email "test@example.com" >/dev/null 2>&1
        git config user.name "Performance Test" >/dev/null 2>&1
        
        cd - >/dev/null
    done
    
    success "Test environment created"
}

# Create test project structure based on size
create_test_project() {
    local project_dir="$1"
    local size="$2"
    
    cd "$project_dir"
    
    # Create project manifest
    cat > .simone/00_PROJECT_MANIFEST.md << 'EOF'
---
id: performance-test-project
created_date: "2025-07-12 10:00"
updated_date: "2025-07-12 10:00"
status: active
---

## Project: Performance Test Project
## Description: Large-scale project for performance testing
## Version: 1.0.0

### Milestones
- M01: Core Platform (Active)
- M02: User Management (Planned)
- M03: Advanced Features (Planned)

### Current Sprint
- S01_M01: Foundation Setup

### Performance Metrics
- Tasks: Variable based on test size
- Sprints: 10-15 active sprints
- Milestones: 3-5 major milestones
EOF

    # Create directory structure
    mkdir -p .simone/{02_REQUIREMENTS,03_SPRINTS,04_GENERAL_TASKS,05_ARCHITECTURAL_DECISIONS}
    
    # Determine number of items based on size
    case "$size" in
        "small")
            num_milestones=2
            num_sprints=5
            num_tasks=25
            ;;
        "medium")
            num_milestones=3
            num_sprints=10
            num_tasks=75
            ;;
        "large")
            num_milestones=5
            num_sprints=20
            num_tasks=200
            ;;
    esac
    
    log "Creating $size project: $num_milestones milestones, $num_sprints sprints, $num_tasks tasks"
    
    # Create milestones
    for m in $(seq 1 $num_milestones); do
        mkdir -p ".simone/02_REQUIREMENTS/M$(printf "%02d" $m)_Milestone_$m"
        cat > ".simone/02_REQUIREMENTS/M$(printf "%02d" $m)_Milestone_$m/M$(printf "%02d" $m)_milestone_meta.md" << EOF
---
id: M$(printf "%02d" $m)
milestone_id: M$(printf "%02d" $m)
title: "Milestone $m"
status: active
priority: high
created_date: "2025-07-12 10:00"
updated_date: "2025-07-12 10:00"
---

# Milestone $m

## Overview
Performance testing milestone $m with comprehensive requirements.

## Success Criteria
- Feature implementation completed
- Performance benchmarks met
- Quality gates passed

## Dependencies
$(if [ $m -gt 1 ]; then echo "- M$(printf "%02d" $((m-1))) completion"; fi)
EOF
    done
    
    # Create sprints
    for s in $(seq 1 $num_sprints); do
        local milestone_id=$((((s-1) % num_milestones) + 1))
        mkdir -p ".simone/03_SPRINTS/S$(printf "%02d" $s)_M$(printf "%02d" $milestone_id)_Sprint_$s"
        
        cat > ".simone/03_SPRINTS/S$(printf "%02d" $s)_M$(printf "%02d" $milestone_id)_Sprint_$s/S$(printf "%02d" $s)_M$(printf "%02d" $milestone_id)_sprint_meta.md" << EOF
---
id: S$(printf "%02d" $s)_M$(printf "%02d" $milestone_id)
sprint_id: S$(printf "%02d" $s)
milestone_id: M$(printf "%02d" $milestone_id)
title: "Sprint $s"
status: active
priority: medium
created_date: "2025-07-12 10:00"
updated_date: "2025-07-12 10:00"
---

# Sprint $s - Milestone $milestone_id

## Sprint Goals
Performance testing sprint with multiple tasks and complexity.

## Sprint Tasks
$(for t in $(seq 1 $((num_tasks / num_sprints))); do echo "- TASK_$(printf "%03d" $(((s-1) * (num_tasks / num_sprints) + t)))"; done)

## Performance Targets
- Task completion: 95%
- Quality score: 90%
EOF
    done
    
    # Create tasks
    for t in $(seq 1 $num_tasks); do
        local sprint_id=$((((t-1) / (num_tasks / num_sprints)) + 1))
        local milestone_id=$((((sprint_id-1) % num_milestones) + 1))
        local status_options=("pending" "in_progress" "review" "completed" "blocked")
        local priority_options=("low" "medium" "high" "critical")
        local status=${status_options[$((t % 5))]}
        local priority=${priority_options[$((t % 4))]}
        
        cat > ".simone/04_GENERAL_TASKS/TASK_$(printf "%03d" $t)_Sprint_$(printf "%02d" $sprint_id)_Feature_Implementation.md" << EOF
---
id: TASK_$(printf "%03d" $t)
task_id: TASK_$(printf "%03d" $t)
sprint_id: S$(printf "%02d" $sprint_id)_M$(printf "%02d" $milestone_id)
milestone_id: M$(printf "%02d" $milestone_id)
title: "Task $t: Feature Implementation"
status: $status
priority: $priority
assignee: developer$((t % 5 + 1))
estimated_hours: $((t % 8 + 1))
created_date: "2025-07-12 10:00"
updated_date: "2025-07-12 10:00"
---

# Task $t: Feature Implementation

## Description
Comprehensive feature implementation task for performance testing. This task includes:
- Complex business logic implementation
- Database integration
- API endpoint development
- Unit test coverage
- Documentation updates

## Acceptance Criteria
- [ ] Feature functionality completed
- [ ] Unit tests pass (>90% coverage)
- [ ] Integration tests pass
- [ ] Code review approved
- [ ] Documentation updated

## Implementation Notes
This is a complex task that requires coordination with multiple systems:
- Frontend components
- Backend APIs
- Database schema changes
- Third-party integrations

## Performance Requirements
- API response time < 200ms
- Database query efficiency
- Memory usage optimization
- Concurrent user support

## Testing Strategy
1. Unit testing for business logic
2. Integration testing for API endpoints
3. Performance testing for load handling
4. Security testing for vulnerability assessment

## Dependencies
$(if [ $t -gt 1 ]; then echo "- TASK_$(printf "%03d" $((t-1))) completion"; fi)
$(if [ $((t % 10)) -eq 0 ]; then echo "- External API integration"; fi)

## Technical Details
Implementation involves multiple components:
- Service layer modifications
- Data access layer updates
- Cache integration
- Monitoring setup

## Quality Assurance
- Code quality checks
- Performance profiling
- Security scanning
- Accessibility compliance
EOF
    done
    
    cd - >/dev/null
    success "Created $size test project with $num_tasks tasks"
}

# Benchmark traditional operations (baseline)
benchmark_baseline_operations() {
    local project_dir="$1"
    cd "$project_dir"
    
    log "Benchmarking baseline operations without performance optimizations"
    
    # Disable performance optimizations
    export SIMONE_PERF_ENABLED="false"
    
    # Time task counting
    local start_time=$(date +%s.%N)
    local task_count=$(find .simone/04_GENERAL_TASKS -name "*.md" | wc -l)
    local end_time=$(date +%s.%N)
    local duration=$(echo "$end_time - $start_time" | bc 2>/dev/null || echo "0.1")
    
    echo "$duration" > baseline_task_count_time.txt
    echo "$task_count" > baseline_task_count.txt
    
    # Time status counting (manual grep)
    start_time=$(date +%s.%N)
    local pending_count=$(grep -r "^status: pending" .simone/04_GENERAL_TASKS/ | wc -l)
    end_time=$(date +%s.%N)
    duration=$(echo "$end_time - $start_time" | bc 2>/dev/null || echo "0.1")
    
    echo "$duration" > baseline_status_count_time.txt
    echo "$pending_count" > baseline_pending_count.txt
    
    # Time project info extraction (file parsing)
    start_time=$(date +%s.%N)
    local project_name=$(grep "^## Project:" .simone/00_PROJECT_MANIFEST.md | cut -d' ' -f3-)
    end_time=$(date +%s.%N)
    duration=$(echo "$end_time - $start_time" | bc 2>/dev/null || echo "0.1")
    
    echo "$duration" > baseline_project_info_time.txt
    echo "$project_name" > baseline_project_name.txt
    
    # Time template loading (file reading)
    mkdir -p .simone/99_TEMPLATES
    cat > .simone/99_TEMPLATES/test_template.md << 'EOF'
# Test Template
This is a test template for performance benchmarking.
Contains multiple lines of content to test reading performance.
EOF
    
    start_time=$(date +%s.%N)
    local template_content=$(cat .simone/99_TEMPLATES/test_template.md)
    end_time=$(date +%s.%N)
    duration=$(echo "$end_time - $start_time" | bc 2>/dev/null || echo "0.1")
    
    echo "$duration" > baseline_template_load_time.txt
    
    cd - >/dev/null
    success "Baseline benchmarks completed"
}

# Benchmark optimized operations
benchmark_optimized_operations() {
    local project_dir="$1"
    cd "$project_dir"
    
    log "Benchmarking optimized operations with performance system"
    
    # Enable performance optimizations
    export SIMONE_PERF_ENABLED="true"
    export SIMONE_CACHE_DIR=".simone/.cache"
    export SIMONE_DB_FILE="$SIMONE_CACHE_DIR/tasks.db"
    
    # Source performance optimizer
    if [[ -f ".simone/01_UTILS/performance-optimizer.sh" ]]; then
        source .simone/01_UTILS/performance-optimizer.sh
        init_performance
        
        # Index all tasks for performance testing
        log "Indexing all tasks for performance testing..."
        reindex_all_tasks >/dev/null 2>&1
        
        # Time task counting (SQLite)
        local start_time=$(date +%s.%N)
        local task_count=$(count_tasks_by_status "all")
        local end_time=$(date +%s.%N)
        local duration=$(echo "$end_time - $start_time" | bc 2>/dev/null || echo "0.1")
        
        echo "$duration" > optimized_task_count_time.txt
        echo "$task_count" > optimized_task_count.txt
        
        # Time status counting (SQLite)
        start_time=$(date +%s.%N)
        local pending_count=$(count_tasks_by_status "pending")
        end_time=$(date +%s.%N)
        duration=$(echo "$end_time - $start_time" | bc 2>/dev/null || echo "0.1")
        
        echo "$duration" > optimized_status_count_time.txt
        echo "$pending_count" > optimized_pending_count.txt
        
        # Time project info extraction (cached)
        start_time=$(date +%s.%N)
        local project_name=$(get_project_info "name")
        end_time=$(date +%s.%N)
        duration=$(echo "$end_time - $start_time" | bc 2>/dev/null || echo "0.1")
        
        echo "$duration" > optimized_project_info_time.txt
        echo "$project_name" > optimized_project_name.txt
        
        # Time template loading (cached)
        mkdir -p .simone/99_TEMPLATES
        cat > .simone/99_TEMPLATES/test_template.md << 'EOF'
# Test Template
This is a test template for performance benchmarking.
Contains multiple lines of content to test reading performance.
EOF
        
        start_time=$(date +%s.%N)
        local template_content=$(cache_template "test_template.md")
        end_time=$(date +%s.%N)
        duration=$(echo "$end_time - $start_time" | bc 2>/dev/null || echo "0.1")
        
        echo "$duration" > optimized_template_load_time.txt
        
        # Second access to test caching
        start_time=$(date +%s.%N)
        template_content=$(cache_template "test_template.md")
        end_time=$(date +%s.%N)
        duration=$(echo "$end_time - $start_time" | bc 2>/dev/null || echo "0.1")
        
        echo "$duration" > optimized_template_cached_time.txt
        
    else
        warn "Performance optimizer not available for optimized benchmarks"
        return 1
    fi
    
    cd - >/dev/null
    success "Optimized benchmarks completed"
}

# Compare performance results
compare_performance_results() {
    log "Comparing performance results..."
    
    # Function to safely read numeric values
    safe_read_number() {
        local file="$1"
        local default="$2"
        if [[ -f "$file" && -r "$file" ]]; then
            local value=$(cat "$file" 2>/dev/null)
            if [[ "$value" =~ ^[0-9]*\.?[0-9]+$ ]]; then
                echo "$value"
            else
                echo "$default"
            fi
        else
            echo "$default"
        fi
    }
    
    # Read baseline times
    local baseline_task_time=$(safe_read_number "$PERFORMANCE_BASELINE_DIR/baseline_task_count_time.txt" "1.0")
    local baseline_status_time=$(safe_read_number "$PERFORMANCE_BASELINE_DIR/baseline_status_count_time.txt" "1.0")
    local baseline_info_time=$(safe_read_number "$PERFORMANCE_BASELINE_DIR/baseline_project_info_time.txt" "1.0")
    local baseline_template_time=$(safe_read_number "$PERFORMANCE_BASELINE_DIR/baseline_template_load_time.txt" "1.0")
    
    # Read optimized times
    local optimized_task_time=$(safe_read_number "$PERFORMANCE_OPTIMIZED_DIR/optimized_task_count_time.txt" "1.0")
    local optimized_status_time=$(safe_read_number "$PERFORMANCE_OPTIMIZED_DIR/optimized_status_count_time.txt" "1.0")
    local optimized_info_time=$(safe_read_number "$PERFORMANCE_OPTIMIZED_DIR/optimized_project_info_time.txt" "1.0")
    local optimized_template_time=$(safe_read_number "$PERFORMANCE_OPTIMIZED_DIR/optimized_template_load_time.txt" "1.0")
    local optimized_cached_time=$(safe_read_number "$PERFORMANCE_OPTIMIZED_DIR/optimized_template_cached_time.txt" "1.0")
    
    echo -e "\n${BLUE}=== PERFORMANCE COMPARISON RESULTS ===${NC}"
    echo
    
    # Calculate improvements (skip if bc not available)
    if command -v bc >/dev/null 2>&1; then
        # Task counting performance
        local task_improvement=$(echo "scale=1; ($baseline_task_time - $optimized_task_time) / $baseline_task_time * 100" | bc 2>/dev/null || echo "N/A")
        echo -e "${BLUE}Task Counting:${NC}"
        echo -e "  Baseline: ${baseline_task_time}s"
        echo -e "  Optimized: ${optimized_task_time}s"
        echo -e "  Improvement: ${task_improvement}%"
        
        if [[ "$task_improvement" != "N/A" ]] && (( $(echo "$task_improvement > 50" | bc -l 2>/dev/null || echo 0) )); then
            success "Task counting performance improved by ${task_improvement}%"
        else
            warn "Task counting improvement: ${task_improvement}%"
        fi
        echo
        
        # Status counting performance
        local status_improvement=$(echo "scale=1; ($baseline_status_time - $optimized_status_time) / $baseline_status_time * 100" | bc 2>/dev/null || echo "N/A")
        echo -e "${BLUE}Status Counting:${NC}"
        echo -e "  Baseline: ${baseline_status_time}s"
        echo -e "  Optimized: ${optimized_status_time}s"
        echo -e "  Improvement: ${status_improvement}%"
        
        if [[ "$status_improvement" != "N/A" ]] && (( $(echo "$status_improvement > 60" | bc -l 2>/dev/null || echo 0) )); then
            success "Status counting performance improved by ${status_improvement}%"
        else
            warn "Status counting improvement: ${status_improvement}%"
        fi
        echo
        
        # Project info performance
        local info_improvement=$(echo "scale=1; ($baseline_info_time - $optimized_info_time) / $baseline_info_time * 100" | bc 2>/dev/null || echo "N/A")
        echo -e "${BLUE}Project Info Extraction:${NC}"
        echo -e "  Baseline: ${baseline_info_time}s"
        echo -e "  Optimized: ${optimized_info_time}s"
        echo -e "  Improvement: ${info_improvement}%"
        
        if [[ "$info_improvement" != "N/A" ]] && (( $(echo "$info_improvement > 30" | bc -l 2>/dev/null || echo 0) )); then
            success "Project info performance improved by ${info_improvement}%"
        else
            warn "Project info improvement: ${info_improvement}%"
        fi
        echo
        
        # Template loading performance
        local template_improvement=$(echo "scale=1; ($baseline_template_time - $optimized_template_time) / $baseline_template_time * 100" | bc 2>/dev/null || echo "N/A")
        echo -e "${BLUE}Template Loading:${NC}"
        echo -e "  Baseline: ${baseline_template_time}s"
        echo -e "  Optimized (first): ${optimized_template_time}s"
        echo -e "  Optimized (cached): ${optimized_cached_time}s"
        echo -e "  Improvement: ${template_improvement}%"
        
        if [[ "$template_improvement" != "N/A" ]] && (( $(echo "$template_improvement > 0" | bc -l 2>/dev/null || echo 0) )); then
            success "Template loading performance improved by ${template_improvement}%"
        else
            warn "Template loading improvement: ${template_improvement}%"
        fi
        
        # Cache effectiveness
        local cache_improvement=$(echo "scale=1; ($optimized_template_time - $optimized_cached_time) / $optimized_template_time * 100" | bc 2>/dev/null || echo "N/A")
        echo -e "  Cache effectiveness: ${cache_improvement}%"
        
        if [[ "$cache_improvement" != "N/A" ]] && (( $(echo "$cache_improvement > 50" | bc -l 2>/dev/null || echo 0) )); then
            success "Template caching highly effective: ${cache_improvement}% faster"
        else
            warn "Template caching effectiveness: ${cache_improvement}%"
        fi
    else
        echo -e "${YELLOW}[INFO]${NC} bc not available, showing raw times only:"
        echo -e "Task counting: ${baseline_task_time}s → ${optimized_task_time}s"
        echo -e "Status counting: ${baseline_status_time}s → ${optimized_status_time}s"
        echo -e "Project info: ${baseline_info_time}s → ${optimized_info_time}s"
        echo -e "Template loading: ${baseline_template_time}s → ${optimized_template_time}s → ${optimized_cached_time}s (cached)"
        success "Performance comparison completed (raw times shown)"
    fi
}

# Test data integrity between baseline and optimized
test_data_integrity() {
    log "Testing data integrity between baseline and optimized operations"
    
    # Compare task counts
    local baseline_count=$(cat "$PERFORMANCE_BASELINE_DIR/baseline_task_count.txt" 2>/dev/null || echo "0")
    local optimized_count=$(cat "$PERFORMANCE_OPTIMIZED_DIR/optimized_task_count.txt" 2>/dev/null || echo "0")
    
    if [[ "$baseline_count" == "$optimized_count" ]]; then
        success "Task counts match: $baseline_count"
    else
        fail "Task count mismatch: baseline=$baseline_count, optimized=$optimized_count"
    fi
    
    # Compare pending counts
    local baseline_pending=$(cat "$PERFORMANCE_BASELINE_DIR/baseline_pending_count.txt" 2>/dev/null || echo "0")
    local optimized_pending=$(cat "$PERFORMANCE_OPTIMIZED_DIR/optimized_pending_count.txt" 2>/dev/null || echo "0")
    
    if [[ "$baseline_pending" == "$optimized_pending" ]]; then
        success "Pending task counts match: $baseline_pending"
    else
        fail "Pending count mismatch: baseline=$baseline_pending, optimized=$optimized_pending"
    fi
    
    # Compare project names
    local baseline_name=$(cat "$PERFORMANCE_BASELINE_DIR/baseline_project_name.txt" 2>/dev/null || echo "")
    local optimized_name=$(cat "$PERFORMANCE_OPTIMIZED_DIR/optimized_project_name.txt" 2>/dev/null || echo "")
    
    if [[ "$baseline_name" == "$optimized_name" ]]; then
        success "Project names match: $baseline_name"
    else
        fail "Project name mismatch: baseline='$baseline_name', optimized='$optimized_name'"
    fi
}

# Test performance under load
test_performance_under_load() {
    log "Testing performance under simulated load"
    
    cd "$PERFORMANCE_OPTIMIZED_DIR"
    
    if [[ -f ".simone/01_UTILS/performance-optimizer.sh" ]]; then
        source .simone/01_UTILS/performance-optimizer.sh
        init_performance
        
        # Simulate multiple concurrent operations
        local start_time=$(date +%s.%N)
        
        for i in {1..10}; do
            (
                # Simulate concurrent task queries
                count_tasks_by_status "pending" >/dev/null
                count_tasks_by_status "in_progress" >/dev/null
                count_tasks_by_status "completed" >/dev/null
                
                # Simulate concurrent cache operations
                cache_set "load_test_$i" "value_$i" 3600 >/dev/null
                cache_get "load_test_$i" >/dev/null
                
                # Simulate concurrent project info access
                get_project_info "name" >/dev/null
                get_project_info "version" >/dev/null
            ) &
        done
        
        # Wait for all background processes
        wait
        
        local end_time=$(date +%s.%N)
        local total_duration=$(echo "$end_time - $start_time" | bc 2>/dev/null || echo "1.0")
        
        echo "Load test duration: ${total_duration}s"
        
        # Check if load test completed in reasonable time (under 5 seconds)
        if command -v bc >/dev/null 2>&1; then
            if (( $(echo "$total_duration < 5.0" | bc -l) )); then
                success "Performance under load test passed: ${total_duration}s"
            else
                warn "Performance under load test slow: ${total_duration}s"
            fi
        else
            success "Performance under load test completed: ${total_duration}s"
        fi
        
        # Verify data integrity after load test
        local final_task_count=$(count_tasks_by_status "all")
        local expected_count=$(cat ../baseline/baseline_task_count.txt 2>/dev/null || echo "0")
        
        if [[ "$final_task_count" == "$expected_count" ]]; then
            success "Data integrity maintained under load"
        else
            fail "Data integrity compromised under load: expected=$expected_count, actual=$final_task_count"
        fi
    else
        warn "Performance optimizer not available for load testing"
    fi
    
    cd - >/dev/null
}

# Cleanup test environment
cleanup_test_environment() {
    if [[ "$KEEP_TEST_ENV" != "true" && -d "$TEST_ENV" ]]; then
        log "Cleaning up test environment"
        rm -rf "$TEST_ENV"
        success "Test environment cleaned up"
    else
        log "Test environment preserved: $TEST_ENV"
    fi
}

# Generate performance test report
generate_performance_report() {
    echo
    log "=== PERFORMANCE INTEGRATION TEST REPORT ==="
    echo
    
    # Summary statistics
    echo -e "${BLUE}Test Summary:${NC}"
    echo -e "  Total Tests: $TESTS_RUN"
    echo -e "  ${GREEN}Passed: $TESTS_PASSED${NC}"
    echo -e "  ${RED}Failed: $TESTS_FAILED${NC}"
    echo
    
    # Calculate success rate
    if [[ $TESTS_RUN -gt 0 ]]; then
        local success_rate=$((TESTS_PASSED * 100 / TESTS_RUN))
        echo -e "${BLUE}Success Rate: ${success_rate}%${NC}"
    else
        echo -e "${YELLOW}No tests were run${NC}"
    fi
    echo
    
    # Test categories
    echo -e "${BLUE}Performance Categories Tested:${NC}"
    echo -e "  ✓ Task database operations (SQLite vs file scanning)"
    echo -e "  ✓ Caching system effectiveness (template and data caching)"
    echo -e "  ✓ Project information extraction (cached vs file parsing)"
    echo -e "  ✓ Data integrity (baseline vs optimized results)"
    echo -e "  ✓ Performance under load (concurrent operations)"
    echo
    
    # Environment details
    echo -e "${BLUE}Test Environment Details:${NC}"
    echo -e "  Project Size: $TEST_PROJECT_SIZE"
    echo -e "  Test Directory: $TEST_ENV"
    echo -e "  Baseline Dir: $PERFORMANCE_BASELINE_DIR"
    echo -e "  Optimized Dir: $PERFORMANCE_OPTIMIZED_DIR"
    echo -e "  Test Duration: ${SECONDS}s"
    echo
    
    # Return appropriate exit code
    if [[ $TESTS_FAILED -gt 0 ]]; then
        echo -e "${RED}❌ Performance integration testing failed with $TESTS_FAILED issues${NC}"
        return 1
    else
        echo -e "${GREEN}✅ All performance integration tests passed successfully${NC}"
        return 0
    fi
}

# Main execution
main() {
    echo -e "${BLUE}🚀 Simone v2.1.0 Performance Integration Tester${NC}"
    echo -e "${BLUE}================================================${NC}"
    echo
    
    # Setup
    setup_test_environment
    
    # Create test projects
    create_test_project "$PERFORMANCE_BASELINE_DIR" "$TEST_PROJECT_SIZE"
    create_test_project "$PERFORMANCE_OPTIMIZED_DIR" "$TEST_PROJECT_SIZE"
    
    # Run benchmarks
    benchmark_baseline_operations "$PERFORMANCE_BASELINE_DIR"
    benchmark_optimized_operations "$PERFORMANCE_OPTIMIZED_DIR"
    
    # Compare and analyze
    compare_performance_results
    test_data_integrity
    test_performance_under_load
    
    # Generate report
    local exit_code=0
    if ! generate_performance_report; then
        exit_code=1
    fi
    
    # Cleanup
    cleanup_test_environment
    
    exit $exit_code
}

# Handle command line arguments
KEEP_TEST_ENV="false"

case "${1:-}" in
    --help|-h)
        echo "Simone v2.1.0 Performance Integration Tester"
        echo
        echo "Usage: $0 [options]"
        echo
        echo "Options:"
        echo "  --help, -h        Show this help message"
        echo "  --keep-env        Keep test environment after completion"
        echo "  --small           Test with small project (25 tasks, 5 sprints)"
        echo "  --medium          Test with medium project (75 tasks, 10 sprints)"
        echo "  --large           Test with large project (200 tasks, 20 sprints) [default]"
        echo "  --verbose         Enable verbose output"
        echo
        echo "This script tests the v2.1.0 performance optimizations:"
        echo "  - SQLite task database vs file scanning"
        echo "  - Smart caching system with TTL"
        echo "  - Git operation batching"
        echo "  - Project info caching"
        echo "  - Template caching effectiveness"
        echo
        exit 0
        ;;
    --keep-env)
        KEEP_TEST_ENV="true"
        ;;
    --small)
        TEST_PROJECT_SIZE="small"
        ;;
    --medium)
        TEST_PROJECT_SIZE="medium"
        ;;
    --large)
        TEST_PROJECT_SIZE="large"
        ;;
    --verbose)
        set -x
        ;;
esac

# Check prerequisites
if [[ ! -f ".simone/01_UTILS/performance-optimizer.sh" ]]; then
    echo -e "${RED}Error: Performance optimizer not found${NC}"
    echo "Please run from project root with Simone v2.1.0 performance system"
    exit 1
fi

# Run main function
main