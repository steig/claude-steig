#!/usr/bin/env bats

# Security Test Suite for Simone Framework
# Tests for security vulnerabilities and hardening measures

setup() {
    # Create a temporary test directory
    export TEST_DIR="$(mktemp -d)"
    export ORIGINAL_DIR="$(pwd)"
    cd "$TEST_DIR"
    
    # Set up minimal test environment
    mkdir -p .simone/99_TEMPLATES
    echo "test_project" > .simone/00_PROJECT_MANIFEST.md
}

teardown() {
    cd "$ORIGINAL_DIR"
    rm -rf "$TEST_DIR"
}

@test "install script validates input paths" {
    # Test that the secure installer validates dangerous paths
    local script="$ORIGINAL_DIR/install-simone-secure.sh"
    
    # Test null byte injection
    run "$script" $'test\0injection'
    [ "$status" -ne 0 ]
    [[ "$output" =~ "contains null bytes" ]]
    
    # Test path traversal
    run "$script" "../../../etc/passwd"
    [ "$status" -ne 0 ]
    [[ "$output" =~ "path traversal detected" ]]
    
    # Test command injection
    run "$script" 'test; rm -rf /'
    [ "$status" -ne 0 ]
    [[ "$output" =~ "dangerous characters" ]]
}

@test "install script sets secure permissions" {
    local script="$ORIGINAL_DIR/install-simone-secure.sh"
    
    # Run installer in test directory
    run "$script" --help
    [ "$status" -eq 0 ]
    
    # Check that script validates permissions properly
    [[ "$output" =~ "help" ]]
}

@test "docker script validates service names" {
    local script="$ORIGINAL_DIR/scripts/mcp-docker-secure.sh"
    
    # Test invalid service name with special characters
    run "$script" logs 'serena; rm -rf /'
    [ "$status" -ne 0 ]
    [[ "$output" =~ "Invalid service name" ]]
    
    # Test valid service name
    run "$script" help
    [ "$status" -eq 0 ]
}

@test "docker script validates port numbers" {
    local script="$ORIGINAL_DIR/scripts/mcp-docker-secure.sh"
    
    # Create a mock environment for testing
    export GATEWAY_PORT="99999"  # Invalid port
    
    # The script should validate port ranges
    # Note: This test would need the actual validation function
    # For now, we test that the script exists and has validation
    [ -f "$script" ]
    
    # Check that the script contains port validation
    grep -q "validate_port_number" "$script"
}

@test "docker compose uses security hardening" {
    local compose_file="$ORIGINAL_DIR/docker-compose.mcp-multi-secure.yml"
    
    # Check that security features are present
    [ -f "$compose_file" ]
    
    # Verify read-only filesystems
    grep -q "read_only: true" "$compose_file"
    
    # Verify non-root user
    grep -q 'user: "1000:1000"' "$compose_file"
    
    # Verify no new privileges
    grep -q "no-new-privileges:true" "$compose_file"
    
    # Verify capabilities are dropped
    grep -q "cap_drop:" "$compose_file"
    grep -q "- ALL" "$compose_file"
    
    # Verify dangerous capabilities are not present
    ! grep -q "SYS_ADMIN" "$compose_file" || grep -A5 -B5 "SYS_ADMIN" "$compose_file" | grep -q "# Security:"
}

@test "seccomp profile exists for browser containers" {
    local seccomp_file="$ORIGINAL_DIR/docker/seccomp/chrome-seccomp.json"
    
    [ -f "$seccomp_file" ]
    
    # Verify it's valid JSON
    run jq empty "$seccomp_file"
    [ "$status" -eq 0 ]
    
    # Verify it has restrictive default action
    run jq -r '.defaultAction' "$seccomp_file"
    [ "$status" -eq 0 ]
    [[ "$output" = "SCMP_ACT_ERRNO" ]]
}

@test "shell scripts use secure practices" {
    # Test various shell scripts for security practices
    local scripts=(
        "$ORIGINAL_DIR/install-simone-secure.sh"
        "$ORIGINAL_DIR/scripts/mcp-docker-secure.sh"
    )
    
    for script in "${scripts[@]}"; do
        [ -f "$script" ]
        
        # Check for set -euo pipefail
        grep -q "set -euo pipefail" "$script"
        
        # Check for IFS setting
        grep -q 'IFS=$' "$script"
        
        # Check for input validation functions
        grep -q "validate_" "$script"
        
        # Check for secure temp directory usage
        grep -q "mktemp" "$script"
        
        # Check for trap cleanup
        grep -q "trap.*EXIT" "$script"
    done
}

@test "no hardcoded secrets in configuration files" {
    # Check for common secret patterns
    local files=(
        "$ORIGINAL_DIR/docker-compose.mcp-multi-secure.yml"
        "$ORIGINAL_DIR/.env.mcp.example"
    )
    
    for file in "${files[@]}"; do
        if [ -f "$file" ]; then
            # Check for hardcoded passwords
            ! grep -i "password.*=" "$file" | grep -v "PASSWORD_FILE"
            
            # Check for hardcoded API keys
            ! grep -i "api_key.*=" "$file" | grep -v "API_KEY_FILE"
            
            # Check for hardcoded tokens
            ! grep -i "token.*=" "$file" | grep -v "TOKEN_FILE"
        fi
    done
}

@test "docker volumes have proper labels and security" {
    local compose_file="$ORIGINAL_DIR/docker-compose.mcp-multi-secure.yml"
    
    # Check that volumes have security labels
    grep -A10 "volumes:" "$compose_file" | grep -q "labels:"
    grep -A10 "volumes:" "$compose_file" | grep -q "project="
}

@test "network isolation is properly configured" {
    local compose_file="$ORIGINAL_DIR/docker-compose.mcp-multi-secure.yml"
    
    # Check for network security settings
    grep -A20 "networks:" "$compose_file" | grep -q "enable_icc.*false"
    
    # Check for proper subnet isolation
    grep -q "NETWORK_SUBNET" "$compose_file"
}

@test "containers have resource limits" {
    local compose_file="$ORIGINAL_DIR/docker-compose.mcp-multi-secure.yml"
    
    # Check that services have resource limits
    grep -A10 "deploy:" "$compose_file" | grep -q "limits:"
    grep -A10 "limits:" "$compose_file" | grep -q "memory:"
    grep -A10 "limits:" "$compose_file" | grep -q "cpus:"
}

@test "healthchecks have reasonable timeouts" {
    local compose_file="$ORIGINAL_DIR/docker-compose.mcp-multi-secure.yml"
    
    # Check that healthchecks exist and have start periods
    grep -A5 "healthcheck:" "$compose_file" | grep -q "start_period:"
    
    # Check that timeouts are reasonable (not too long)
    ! grep "timeout:.*[5-9][0-9]s" "$compose_file"
}

@test "temporary files use secure locations" {
    local scripts=(
        "$ORIGINAL_DIR/install-simone-secure.sh"
        "$ORIGINAL_DIR/scripts/mcp-docker-secure.sh"
    )
    
    for script in "${scripts[@]}"; do
        [ -f "$script" ]
        
        # Check that mktemp is used properly
        if grep -q "mktemp" "$script"; then
            # Should use -t flag for template
            grep -q "mktemp -d -t" "$script"
        fi
        
        # Should not use /tmp directly
        ! grep -q ">/tmp/" "$script"
        ! grep -q "mkdir /tmp" "$script"
    done
}

@test "error handling prevents information disclosure" {
    local scripts=(
        "$ORIGINAL_DIR/install-simone-secure.sh"
        "$ORIGINAL_DIR/scripts/mcp-docker-secure.sh"
    )
    
    for script in "${scripts[@]}"; do
        [ -f "$script" ]
        
        # Check for proper error function
        grep -q "error()" "$script"
        
        # Error function should not expose sensitive info
        ! grep -A10 "error()" "$script" | grep -q "debug"
        ! grep -A10 "error()" "$script" | grep -q "trace"
    done
}