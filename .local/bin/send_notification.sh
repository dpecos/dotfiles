#!/bin/bash

set -euo pipefail

# Usage: send_notification.sh "Your message here"

if [ "$#" -ne 1 ] || [ -z "$1" ]; then
  echo "Usage: $0 \"message\"" >&2
  exit 1
fi

MESSAGE="$1"

curl --fail --silent --show-error \
  --data-raw "$MESSAGE" \
  https://ntfy.sh/dpecos-logs
