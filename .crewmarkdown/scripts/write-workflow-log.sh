#!/usr/bin/env bash
# Writes workflow step log to request-hierarchy path:
# .crewmarkdown/logs/<year>/<month>/<day>/<time>/<chatName>-[<time>]/<stepId>.md
# Usage: ./write-workflow-log.sh -s "req/gather" -c "build-login" -t "completed" -i "input" -o "output" -n "notes"

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
LOGS_ROOT="$PROJECT_ROOT/.crewmarkdown/logs"

usage() {
  echo "Usage: $0 -s <stepId> [-c chatName] [-t status] [-i input] [-o output] [-n notes]"
  echo "  -s  Step ID (e.g. req/gather, dev/impl)"
  echo "  -c  Chat name slug derived from request (kebab-case, 5 words max). Default: request"
  echo "  -t  Status: completed|failed|reverted (default: completed)"
  echo "  -i  Input text"
  echo "  -o  Output text / artifacts"
  echo "  -n  Notes"
  exit 1
}

STEP_ID=""
CHAT_NAME="request"
STATUS="completed"
INPUT_TEXT=""
OUTPUT_TEXT=""
NOTES=""

while getopts "s:c:t:i:o:n:" opt; do
  case "$opt" in
    s) STEP_ID="$OPTARG" ;;
    c) CHAT_NAME="$OPTARG" ;;
    t) STATUS="$OPTARG" ;;
    i) INPUT_TEXT="$OPTARG" ;;
    o) OUTPUT_TEXT="$OPTARG" ;;
    n) NOTES="$OPTARG" ;;
    *) usage ;;
  esac
done

if [ -z "$STEP_ID" ]; then usage; fi
if [[ ! "$STATUS" =~ ^(completed|failed|reverted)$ ]]; then
  echo "Error: status must be completed, failed, or reverted"
  exit 1
fi

now=$(date '+%Y-%m-%dT%H:%M:%S')
year=$(date '+%Y')
month=$(date '+%m')
day=$(date '+%d')
time=$(date '+%H%M%S')

safe_chat=$(echo "$CHAT_NAME" | sed 's/[^a-z0-9-]//g')
REQUEST_DIR="$LOGS_ROOT/$year/$month/$day/$time/$safe_chat-[$time]"
mkdir -p "$REQUEST_DIR"

safe_step=$(echo "$STEP_ID" | sed 's/[\\/:]/-/g')
filename="$safe_step-$now.md"
filepath="$REQUEST_DIR/$filename"

cat > "$filepath" << LOGEOF
# Step: $STEP_ID
**Request:** $safe_chat
**Started:** $now
**Completed:** $now
**Status:** $STATUS

## Input
$INPUT_TEXT

## Output
$OUTPUT_TEXT

## Notes
$NOTES
LOGEOF

echo "Log written: $filepath"
