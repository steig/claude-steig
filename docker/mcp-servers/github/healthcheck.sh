#!/bin/sh

# GitHub MCP Server Health Check
set -e

# Check if the server is responding
if curl -f -s "http://localhost:${MCP_SERVER_PORT:-8083}/health" >/dev/null 2>&1; then
    echo "GitHub MCP Server is healthy"
    exit 0
else
    echo "GitHub MCP Server health check failed"
    exit 1
fi