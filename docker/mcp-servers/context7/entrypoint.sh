#!/bin/sh

# Context7 MCP Server Entrypoint
set -e

echo "Starting Context7 MCP Server..."
echo "Server Name: ${MCP_SERVER_NAME:-context7}"
echo "Upstash Redis URL: ${UPSTASH_REDIS_REST_URL:-not-configured}"

# Ensure data directory exists
mkdir -p /app/data

# Validate Redis configuration if provided
if [ -n "$UPSTASH_REDIS_REST_URL" ] && [ -n "$UPSTASH_REDIS_REST_TOKEN" ]; then
    echo "Redis configuration detected - enabling persistent context storage"
else
    echo "No Redis configuration - using local storage only"
fi

# Start the server with provided arguments
exec "$@"