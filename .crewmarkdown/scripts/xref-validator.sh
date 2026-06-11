#!/usr/bin/env bash
# Validates all cross-references to .md files across .crewmarkdown/
# Usage: ./xref-validator.sh [path]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SEARCH_PATH="${1:-$PROJECT_ROOT/.crewmarkdown}"

passed=0
failed=0

check_xref() {
  local name="$1"
  local pattern="$2"
  local errors=""
  while IFS= read -r file; do
    while IFS= read -r match; do
      target=$(echo "$match" | grep -oP "$pattern" || true)
      [ -z "$target" ] && continue
      dir=$(dirname "$file")
      if [ ! -f "$dir/$target" ]; then
        rel="${file#$PROJECT_ROOT/}"
        errors+="$rel → $target"$'\n'
      fi
    done < <(grep -Pn '→|\.md\)' "$file" 2>/dev/null || true)
  done < <(find "$SEARCH_PATH" -name '*.md' -not -path '*/log/*' -type f)

  if [ -n "$errors" ]; then
    echo "  [FAIL] $name"
    echo -n "$errors" | sed 's/^/    /'
    ((failed++))
  else
    echo "  [PASS] $name"
    ((passed++))
  fi
}

echo ""
echo "============================================"
echo " Cross-Reference Validator"
echo "============================================"

check_xref "Next → links" '(?<=Next →\s*)[\w./-]+\.md'
check_xref "Revert → links" '(?<=Revert →\s*)[\w./-]+\.md'

echo "============================================"
echo " Results: $passed passed, $failed failed"
echo "============================================"
[ "$failed" -eq 0 ] || exit 1
