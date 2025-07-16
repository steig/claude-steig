#!/bin/sh

# Sequential Thinking MCP Server Entrypoint
set -e

echo "Starting Sequential Thinking MCP Server..."
echo "Server Name: ${MCP_SERVER_NAME:-sequential-thinking}"
echo "Thinking Mode: ${THINKING_MODE:-structured}"

# Ensure data directory exists
mkdir -p /app/data

# Configure thinking mode
case "$THINKING_MODE" in
    "structured"|"analytical"|"creative"|"debug")
        echo "Using thinking mode: $THINKING_MODE"
        ;;
    *)
        echo "Unknown thinking mode '$THINKING_MODE', using 'structured'"
        export THINKING_MODE="structured"
        ;;
esac

# Start the server with provided arguments
exec "$@"