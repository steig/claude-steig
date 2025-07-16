#!/bin/sh

# MCP Gateway Entrypoint
set -e

echo "Starting MCP Gateway..."
echo "Gateway Port: ${GATEWAY_PORT:-9000}"
echo "Node Environment: ${NODE_ENV:-production}"

# Ensure logs directory exists
mkdir -p /app/logs

# Install dependencies if needed (for development)
if [ "$NODE_ENV" = "development" ] && [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install
fi

# Display service configuration
echo "Configured Services:"
echo "  Serena:              ${SERENA_URL:-http://serena:8080}"
echo "  Context7:            ${CONTEXT7_URL:-http://context7:8081}"
echo "  Playwright:          ${PLAYWRIGHT_URL:-http://playwright:8082}"
echo "  Work History:        ${WORK_HISTORY_URL:-http://work-history:8083}"
echo "  Sequential Thinking: ${SEQUENTIAL_THINKING_URL:-http://sequential-thinking:8084}"

echo "MCP Gateway ready"

# Start the server with provided arguments
exec "$@"