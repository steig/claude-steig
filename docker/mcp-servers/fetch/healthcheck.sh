#!/bin/sh

# Fetch MCP Server Health Check
set -e

# Check if the server is responding
if curl -f -s "http://localhost:${MCP_SERVER_PORT:-8085}/health" >/dev/null 2>&1; then
    echo "Fetch MCP Server is healthy"
    exit 0
else
    echo "Fetch MCP Server health check failed"
    exit 1
fi