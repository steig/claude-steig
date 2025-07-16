#!/bin/sh

# MCP Gateway Health Check
set -e

# Check if the gateway is responding
if curl -f -s "http://localhost:${GATEWAY_PORT:-9000}/health" >/dev/null 2>&1; then
    echo "MCP Gateway is healthy"
    exit 0
else
    echo "MCP Gateway health check failed"
    exit 1
fi