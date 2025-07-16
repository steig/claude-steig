#!/bin/bash

# Start Xvfb (X Virtual Framebuffer) for headless browser automation
set -e

DISPLAY_NUM=${DISPLAY:-:99}
SCREEN_NUM=${SCREEN:-0}
RESOLUTION=${RESOLUTION:-1920x1080x24}

echo "Starting Xvfb on display $DISPLAY_NUM with resolution $RESOLUTION"

# Start Xvfb
Xvfb $DISPLAY_NUM -screen $SCREEN_NUM $RESOLUTION -ac +extension GLX +render -noreset &

# Wait for Xvfb to start
sleep 1

echo "Xvfb started successfully"