#!/usr/bin/env bash
# Verifies every referenced file in objectives, procedures, and role contracts exists.
# Usage: ./step-integrity.sh [path]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SEARCH_PATH="${1:-$PROJECT_ROOT/.crewmarkdown}"

passed=0
failed=0

echo ""
echo "============================================"
echo " Step Integrity Check"
echo "============================================"

check_refs() {
  local name="$1"
  local file="$2"
  local pattern="$3"
  local missing=""
  while IFS= read -r ref; do
    [ -z "$ref" ] && continue
    target="$SEARCH_PATH/$ref"
    if [ ! -f "$target" ]; then
      missing+="  $ref (in $file)"$'\n'
    fi
  done < <(grep -oP "$pattern" "$file" 2>/dev/null || true)

  if [ -n "$missing" ]; then
    echo "  [FAIL] $name"
    echo -n "$missing"
    ((failed++))
  else
    echo "  [PASS] $name"
    ((passed++))
  fi
}

check_refs "Objectives in 00-objectives.md" "$SEARCH_PATH/00-objectives.md" '(?<=file:\s)[\w./-]+\.md'
check_refs "Role contracts/workflows in 00-team.md" "$SEARCH_PATH/00-team.md" '(?<=contract:|workflow:)\s*[\w./-]+\.md'
check_refs "Procedures in 00-roles.md" "$SEARCH_PATH/00-roles.md" '(?<=procedures/)[\w./-]+\.md'

echo "============================================"
echo " Results: $passed passed, $failed failed"
echo "============================================"
[ "$failed" -eq 0 ] || exit 1
