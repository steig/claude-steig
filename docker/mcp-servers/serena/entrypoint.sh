#!/bin/sh

# Serena MCP Server Entrypoint
set -e

echo "Starting Serena MCP Server..."
echo "Project Path: ${PROJECT_PATH:-/workspace}"
echo "Context: ${CONTEXT:-ide-assistant}"
echo "Server Name: ${MCP_SERVER_NAME:-serena}"

# Ensure data directory exists
mkdir -p /app/data

# Set project path if workspace is mounted
if [ -d "/workspace" ]; then
    export PROJECT_PATH="/workspace"
fi

# Start the server with provided arguments
exec "$@"