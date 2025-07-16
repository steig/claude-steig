#!/bin/sh

# Fetch MCP Server Entrypoint
set -e

echo "Starting Fetch MCP Server..."
echo "Server Name: ${MCP_SERVER_NAME:-fetch}"
echo "User Agent: ${USER_AGENT:-Mozilla/5.0 (compatible; MCPFetch/1.0)}"

# Ensure data directory exists
mkdir -p /app/data

# Configure user agent for web requests
if [ -n "$USER_AGENT" ]; then
    echo "Using custom User-Agent: $USER_AGENT"
    export FETCH_USER_AGENT="$USER_AGENT"
fi

# Start the server with provided arguments
exec "$@"