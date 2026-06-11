#!/usr/bin/env bash
# Diffs two workflow.json snapshots.
# Usage: ./state-diff.sh <old-file> [new-file]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

OLD="${1:?Usage: $0 <old-file> [new-file]}"
NEW="${2:-$PROJECT_ROOT/.crewmarkdown/state/workflow.json}"

echo ""
echo "============================================"
echo " State Diff"
echo "============================================"

old_obj=$(jq -r '.currentObjective' "$OLD")
new_obj=$(jq -r '.currentObjective' "$NEW")
if [ "$old_obj" != "$new_obj" ]; then
  echo "  [CHANGED] currentObjective"
  echo "    Old: $old_obj"
  echo "    New: $new_obj"
fi

old_count=$(jq '.completedSteps | length' "$OLD")
new_count=$(jq '.completedSteps | length' "$NEW")
if [ "$old_count" -ne "$new_count" ]; then
  diff=$((new_count - old_count))
  echo "  [CHANGED] completedSteps: $old_count → $new_count ($([ $diff -gt 0 ] && echo "+")$diff)"
fi

old_art=$(jq -r '.artifacts[]' "$OLD" 2>/dev/null | sort)
new_art=$(jq -r '.artifacts[]' "$NEW" 2>/dev/null | sort)
added=$(comm -13 <(echo "$old_art") <(echo "$new_art"))
[ -n "$added" ] && echo "  [ADDED] artifacts:" && echo "$added" | sed 's/^/    + /'

echo "============================================"
