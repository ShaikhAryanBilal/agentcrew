#!/usr/bin/env bash
# Writes workflow step log to date-hierarchy path:
# .agentcrew/log/<year>/<month>/<day>/<index>-<stepId>-<timestamp>.md
# Usage: ./write-workflow-log.sh -s "req/gather" -t "completed" -i "input" -o "output" -n "notes"

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
LOGS_ROOT="$PROJECT_ROOT/.agentcrew/log"

usage() {
  echo "Usage: $0 -s <stepId> [-t status] [-i input] [-o output] [-n notes]"
  echo "  -s  Step ID (e.g. req/gather, dev/impl)"
  echo "  -t  Status: completed|failed|reverted (default: completed)"
  echo "  -i  Input text"
  echo "  -o  Output text / artifacts"
  echo "  -n  Notes"
  exit 1
}

STEP_ID=""
STATUS="completed"
INPUT_TEXT=""
OUTPUT_TEXT=""
NOTES=""

while getopts "s:t:i:o:n:" opt; do
  case "$opt" in
    s) STEP_ID="$OPTARG" ;;
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

DAY_DIR="$LOGS_ROOT/$year/$month/$day"
mkdir -p "$DAY_DIR"

existing=("$DAY_DIR"/*.md 2>/dev/null)
index=$((${#existing[@]} + 1))

safe_step=$(echo "$STEP_ID" | sed 's/[\\/:]/-/g')
filename=$(printf "%04d-%s-%s.md" "$index" "$safe_step" "$now")
filepath="$DAY_DIR/$filename"

cat > "$filepath" << LOGEOF
# Step: $STEP_ID
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
