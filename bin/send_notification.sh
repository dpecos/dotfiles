#!/bin/bash

# Usage: send_notification.sh "Your message here"

MESSAGE="$1"

if [ -z "$MESSAGE" ]; then
  echo "Usage: $0 \"message\""
  exit 1
fi

# --- Read environment variables ---
# SIGNAL_NUMBER = your registered Signal number
# SIGNAL_DEST = recipient Signal number

# Example:
# export SIGNAL_NUMBER="+1234567890"
# export SIGNAL_DEST="+0987654321"

if [ -n "$SIGNAL_NUMBER" ] && [ -n "$SIGNAL_DEST" ]; then
  signal-cli -u "$SIGNAL_NUMBER" send -m "$MESSAGE" "$SIGNAL_DEST"
fi
