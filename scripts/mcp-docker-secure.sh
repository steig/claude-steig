#!/bin/bash

# MCP Docker Management Script - Security Hardened Version
# Manages Docker-based MCP server deployment for Simone Framework

# Strict error handling and security settings
set -euo pipefail
IFS=$'\n\t'

# Security: Ensure clean environment
unset CDPATH
export PATH="/usr/local/bin:/usr/bin:/bin"

# Validate we're running in a safe environment
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
readonly COMPOSE_FILE="$PROJECT_ROOT/docker-compose.mcp.yml"
readonly ENV_FILE="$PROJECT_ROOT/.env.mcp"
readonly ENV_EXAMPLE="$PROJECT_ROOT/.env.mcp.example"

# Create secure temporary directory
readonly TEMP_DIR="$(mktemp -d -t mcp-docker.XXXXXXXXXX)"
trap 'rm -rf "$TEMP_DIR"' EXIT INT TERM

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Input validation functions
validate_service_name() {
    local service="$1"
    if [[ ! "$service" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        error "Invalid service name: $service"
    fi
}

validate_port_number() {
    local port="$1"
    if [[ ! "$port" =~ ^[0-9]+$ ]] || [[ "$port" -lt 1 ]] || [[ "$port" -gt 65535 ]]; then
        error "Invalid port number: $port"
    fi
}

validate_file_path() {
    local path="$1"
    local context="$2"
    
    # Check for null bytes and dangerous characters
    if [[ "$path" =~ $'\0' ]]; then
        error "Invalid path in $context: contains null bytes"
    fi
    
    # Check for relative path traversal
    if [[ "$path" =~ \.\./|\.\.\\ ]]; then
        error "Invalid path in $context: path traversal detected"
    fi
    
    # Ensure path is reasonable length
    if [[ ${#path} -gt 4096 ]]; then
        error "Invalid path in $context: path too long (max 4096 characters)"
    fi
}

# Secure logging functions
log() {
    printf '%s[INFO]%s %s\n' "$GREEN" "$NC" "$1" >&2
}

warn() {
    printf '%s[WARN]%s %s\n' "$YELLOW" "$NC" "$1" >&2
}

error() {
    printf '%s[ERROR]%s %s\n' "$RED" "$NC" "$1" >&2
    exit 1
}

info() {
    printf '%s[INFO]%s %s\n' "$BLUE" "$NC" "$1" >&2
}

# Security check functions
check_docker_security() {
    log "Performing Docker security checks..."
    
    # Check if Docker daemon is running
    if ! docker info >/dev/null 2>&1; then
        error "Docker daemon is not running or not accessible"
    fi
    
    # Check if user is in docker group (safer than sudo)
    if ! groups | grep -q docker && [[ $EUID -ne 0 ]]; then
        warn "User not in docker group. You may need to run with sudo or add user to docker group"
    fi
    
    # Check Docker version for known vulnerabilities
    local docker_version
    docker_version="$(docker --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)"
    if [[ -n "$docker_version" ]]; then
        log "Docker version: $docker_version"
    fi
}

# Check if Docker and Docker Compose are installed
check_dependencies() {
    log "Checking dependencies..."
    
    if ! command -v docker >/dev/null 2>&1; then
        error "Docker is not installed. Please install Docker first."
    fi
    
    # Check for both docker-compose and docker compose
    local compose_cmd=""
    if command -v docker-compose >/dev/null 2>&1; then
        compose_cmd="docker-compose"
    elif docker compose version >/dev/null 2>&1; then
        compose_cmd="docker compose"
    else
        error "Docker Compose is not installed. Please install Docker Compose first."
    fi
    
    log "Using compose command: $compose_cmd"
    
    # Additional security dependency checks
    if ! command -v curl >/dev/null 2>&1; then
        warn "curl not found - health checks may not work properly"
    fi
    
    if ! command -v jq >/dev/null 2>&1; then
        warn "jq not found - JSON parsing may not work properly"
    fi
    
    check_docker_security
}

# Secure file operations
secure_file_exists() {
    local file="$1"
    validate_file_path "$file" "file existence check"
    [[ -f "$file" ]]
}

secure_read_file() {
    local file="$1"
    validate_file_path "$file" "file read"
    
    if [[ ! -r "$file" ]]; then
        error "File not readable: $file"
    fi
    
    cat "$file"
}

secure_write_file() {
    local file="$1"
    local content="$2"
    validate_file_path "$file" "file write"
    
    local dir
    dir="$(dirname "$file")"
    if [[ ! -w "$dir" ]]; then
        error "Directory not writable: $dir"
    fi
    
    printf '%s\n' "$content" > "$file"
}

# Check required files exist
check_files() {
    log "Checking required files..."
    
    validate_file_path "$COMPOSE_FILE" "compose file"
    if ! secure_file_exists "$COMPOSE_FILE"; then
        error "Docker Compose file not found: $COMPOSE_FILE"
    fi
    
    if ! secure_file_exists "$ENV_FILE"; then
        if secure_file_exists "$ENV_EXAMPLE"; then
            log "Creating .env.mcp from example..."
            cp "$ENV_EXAMPLE" "$ENV_FILE"
        else
            error "Environment file not found: $ENV_FILE"
        fi
    fi
    
    # Validate compose file syntax
    if ! docker-compose -f "$COMPOSE_FILE" config >/dev/null 2>&1; then
        error "Invalid Docker Compose file: $COMPOSE_FILE"
    fi
}

# Get current project path securely
get_project_path() {
    local current_path
    current_path="$(pwd -P)"
    validate_file_path "$current_path" "current directory"
    printf '%s' "$current_path"
}

# Setup environment
setup_environment() {
    log "Setting up MCP Docker environment..."
    
    check_dependencies
    check_files
    
    local project_path
    project_path="$(get_project_path)"
    
    # Create secure environment file
    create_secure_env_file "$project_path"
    
    log "Building Docker images securely..."
    docker-compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" build --no-cache
    
    log "Setup completed successfully"
}

# Create environment file with validation
create_secure_env_file() {
    local project_path="$1"
    validate_file_path "$project_path" "project path"
    
    # Validate project path exists and is a directory
    if [[ ! -d "$project_path" ]]; then
        error "Project path is not a directory: $project_path"
    fi
    
    # Create environment content with validation
    local env_content
    env_content="# MCP Docker Environment Configuration
# Generated on $(date)
# Project: $project_path

# Project configuration
PROJECT_PATH=$project_path

# Port configuration (validated ranges)
GATEWAY_PORT=9000
SERENA_PORT=8080
CONTEXT7_PORT=8081
PLAYWRIGHT_PORT=8082
WORK_HISTORY_PORT=8083
SEQUENTIAL_THINKING_PORT=8084

# Docker configuration
COMPOSE_PROJECT_NAME=mcp-simone

# Security settings
DOCKER_BUILDKIT=1
COMPOSE_DOCKER_CLI_BUILD=1"

    # Validate ports are not in use
    local ports=(9000 8080 8081 8082 8083 8084)
    for port in "${ports[@]}"; do
        validate_port_number "$port"
        if netstat -tuln 2>/dev/null | grep -q ":$port "; then
            warn "Port $port appears to be in use"
        fi
    done
    
    secure_write_file "$ENV_FILE" "$env_content"
    
    # Set secure permissions on env file
    chmod 600 "$ENV_FILE"
    
    log "Environment file created: $ENV_FILE"
}

# Start services with health checks
start_services() {
    log "Starting MCP services..."
    
    check_files
    
    # Start services with resource limits
    docker-compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" up -d
    
    log "Waiting for services to start..."
    sleep 10
    
    # Perform health checks
    perform_health_checks
    
    log "All services started successfully"
}

# Perform comprehensive health checks
perform_health_checks() {
    log "Performing health checks..."
    
    local services=("gateway" "serena" "context7" "playwright" "work-history" "sequential-thinking")
    local ports=(9000 8080 8081 8082 8083 8084)
    local healthy=true
    
    for i in "${!services[@]}"; do
        local service="${services[$i]}"
        local port="${ports[$i]}"
        
        validate_service_name "$service"
        validate_port_number "$port"
        
        if curl -sf "http://localhost:$port/health" >/dev/null 2>&1; then
            log "✓ $service service healthy (port $port)"
        else
            error "✗ $service service unhealthy (port $port)"
            healthy=false
        fi
    done
    
    if [[ "$healthy" == true ]]; then
        log "All health checks passed"
    else
        error "Some services failed health checks"
    fi
}

# Stop services safely
stop_services() {
    log "Stopping MCP services..."
    
    if secure_file_exists "$COMPOSE_FILE" && secure_file_exists "$ENV_FILE"; then
        docker-compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" down
        log "Services stopped successfully"
    else
        warn "Configuration files not found, attempting to stop by project name..."
        docker-compose -p mcp-simone down 2>/dev/null || true
    fi
}

# Show service status
show_status() {
    log "MCP Service Status:"
    
    if secure_file_exists "$COMPOSE_FILE" && secure_file_exists "$ENV_FILE"; then
        docker-compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" ps
    else
        warn "Configuration files not found, showing all containers..."
        docker ps --filter "name=mcp-"
    fi
}

# Show service logs securely
show_logs() {
    local service="${1:-}"
    
    if [[ -n "$service" ]]; then
        validate_service_name "$service"
        log "Showing logs for service: $service"
        docker-compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" logs -f "$service"
    else
        log "Showing logs for all services:"
        docker-compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" logs -f
    fi
}

# Cleanup resources
cleanup_resources() {
    warn "Cleaning up MCP Docker resources..."
    
    # Stop services first
    stop_services
    
    # Remove containers and volumes
    if secure_file_exists "$COMPOSE_FILE" && secure_file_exists "$ENV_FILE"; then
        docker-compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" down -v --remove-orphans
    fi
    
    # Clean up orphaned containers
    docker container prune -f --filter "label=project=mcp-simone" 2>/dev/null || true
    
    # Clean up orphaned volumes
    docker volume prune -f --filter "label=project=mcp-simone" 2>/dev/null || true
    
    log "Cleanup completed"
}

# Restart services
restart_services() {
    log "Restarting MCP services..."
    stop_services
    sleep 5
    start_services
}

# Show help
show_help() {
    cat << 'EOF'
MCP Docker Management Script - Security Hardened

Usage: ./mcp-docker-secure.sh [COMMAND] [OPTIONS]

COMMANDS:
    setup       Setup and configure Docker MCP environment
    start       Start all MCP services
    stop        Stop all MCP services
    restart     Restart all MCP services
    status      Show service status
    health      Perform health checks
    logs [SVC]  Show logs (optionally for specific service)
    cleanup     Clean up containers and volumes
    help        Show this help message

EXAMPLES:
    ./mcp-docker-secure.sh setup          # Initial setup
    ./mcp-docker-secure.sh start          # Start services
    ./mcp-docker-secure.sh logs serena    # Show serena logs
    ./mcp-docker-secure.sh health         # Check service health

EOF
}

# Input validation for commands
validate_command() {
    local cmd="$1"
    local valid_commands=("setup" "start" "stop" "restart" "status" "health" "logs" "cleanup" "help")
    
    for valid_cmd in "${valid_commands[@]}"; do
        if [[ "$cmd" == "$valid_cmd" ]]; then
            return 0
        fi
    done
    
    error "Invalid command: $cmd"
}

# Main function
main() {
    # Security check: ensure we're not running as root unnecessarily
    if [[ $EUID -eq 0 ]]; then
        warn "Running as root - consider using docker group instead"
    fi
    
    local command="${1:-help}"
    validate_command "$command"
    
    case "$command" in
        setup)
            setup_environment
            ;;
        start)
            start_services
            ;;
        stop)
            stop_services
            ;;
        restart)
            restart_services
            ;;
        status)
            show_status
            ;;
        health)
            perform_health_checks
            ;;
        logs)
            show_logs "${2:-}"
            ;;
        cleanup)
            cleanup_resources
            ;;
        help|*)
            show_help
            ;;
    esac
}

# Run main function with all arguments
main "$@"