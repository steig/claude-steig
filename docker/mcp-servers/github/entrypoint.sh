#!/bin/sh

# GitHub MCP Server Entrypoint
set -e

echo "Starting GitHub MCP Server..."
echo "Server Name: ${MCP_SERVER_NAME:-github}"
echo "Read Only: ${GITHUB_READ_ONLY:-false}"

# Ensure data directory exists
mkdir -p /app/data

# Validate required environment variables
if [ -z "$GITHUB_PERSONAL_ACCESS_TOKEN" ]; then
    echo "Warning: GITHUB_PERSONAL_ACCESS_TOKEN not set. GitHub MCP server may have limited functionality."
fi

# Configure read-only mode
if [ "$GITHUB_READ_ONLY" = "true" ]; then
    echo "GitHub MCP server running in read-only mode"
    export GITHUB_TOOLSETS="readonly"
fi

# Start the server with provided arguments
exec "$@"