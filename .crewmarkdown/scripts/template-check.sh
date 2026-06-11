#!/usr/bin/env bash
# Validates procedure files follow Need → Instructions → Done pattern.
# Usage: ./template-check.sh [procedures-path]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SEARCH_PATH="${1:-$PROJECT_ROOT/.crewmarkdown/procedures}"

passed=0
failed=0

echo ""
echo "============================================"
echo " Template Structure Check"
echo "============================================"

while IFS= read -r file; do
  rel="${file#$PROJECT_ROOT/}"
  content=$(cat "$file")
  missing=""

  echo "$content" | grep -q '^## Need' || missing+="Need "
  echo "$content" | grep -q '^## Instructions' || missing+="Instructions "
  echo "$content" | grep -q '^## Done' || missing+="Done "

  if [ -n "$missing" ]; then
    echo "  [FAIL] $rel - missing: $missing"
    ((failed++))
  else
    echo "  [PASS] $rel"
    ((passed++))
  fi
done < <(find "$SEARCH_PATH" -name '*.md' -not -name '.step.json' -not -name 'README.md' -type f)

echo "============================================"
echo " Results: $passed clean, $failed with issues"
echo "============================================"
[ "$failed" -eq 0 ] || exit 1
