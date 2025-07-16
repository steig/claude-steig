#!/bin/bash

# Playwright MCP Server Entrypoint
set -e

echo "Starting Playwright MCP Server..."
echo "Server Name: ${MCP_SERVER_NAME:-playwright}"
echo "Display: ${DISPLAY:-:99}"

# Ensure data directory exists
mkdir -p /app/data

# Start virtual display for headless browsers
/app/start-xvfb.sh &

# Wait for display to be ready
sleep 2

# Verify browsers are installed
if ! playwright --version >/dev/null 2>&1; then
    echo "Installing Playwright browsers..."
    playwright install
fi

echo "Playwright MCP Server ready with browser automation support"

# Start the server with provided arguments
exec "$@"