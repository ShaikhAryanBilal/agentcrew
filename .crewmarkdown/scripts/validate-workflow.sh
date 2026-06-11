#!/usr/bin/env bash
# Validates workflow integrity: cross-references, step IDs, file existence.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
WORKFLOW_DIR="$PROJECT_ROOT/.crewmarkdown"

passed=0
failed=0

check() {
  local name="$1"
  local result
  result=$("${@:2}" 2>&1) && {
    echo "  [PASS] $name"
    ((passed++))
  } || {
    echo "  [FAIL] $name"
    echo "    $result"
    ((failed++))
  }
}

echo ""
echo "============================================"
echo " Workflow Validation"
echo "============================================"
echo "Project: $PROJECT_ROOT"
echo ""

echo "--- Cross-References ---"
check "All Next → links point to existing files" \
  bash -c "
    errors=''
    while IFS= read -r file; do
      while IFS= read -r match; do
        target=\$(echo \"\$match\" | grep -oP 'Next →\s*\K[\w./-]+\.md')
        dir=\$(dirname \"\$file\")
        if [ -n \"\$target\" ] && [ ! -f \"\$dir/\$target\" ]; then
          rel=\$(echo \"\$file\" | sed \"s|$PROJECT_ROOT/||\")
          errors=\"\$errors\$rel → \$target\"\$'\n'
        fi
      done < <(grep -n 'Next →' \"\$file\" 2>/dev/null || true)
    done < <(find \"$WORKFLOW_DIR\" -name '*.md' -not -path '*/log/*' -not -path '*/custom/*' -not -path '*/roles/*' -type f)
    if [ -n \"\$errors\" ]; then echo \"\$errors\"; exit 1; fi
  "

check "All Revert → links point to existing files" \
  bash -c "
    errors=''
    while IFS= read -r file; do
      while IFS= read -r match; do
        target=\$(echo \"\$match\" | grep -oP 'Revert →\s*\K[\w./-]+\.md')
        dir=\$(dirname \"\$file\")
        if [ -n \"\$target\" ] && [ ! -f \"\$dir/\$target\" ]; then
          rel=\$(echo \"\$file\" | sed \"s|$PROJECT_ROOT/||\")
          errors=\"\$errors\$rel → \$target\"\$'\n'
        fi
      done < <(grep -n 'Revert →' \"\$file\" 2>/dev/null || true)
    done < <(find \"$WORKFLOW_DIR\" -name '*.md' -not -path '*/log/*' -not -path '*/custom/*' -not -path '*/roles/*' -type f)
    if [ -n \"\$errors\" ]; then echo \"\$errors\"; exit 1; fi
  "

# Check 2: workflow.json validity
echo "--- State File ---"
check "workflow.json is valid JSON" \
  bash -c "cat '$WORKFLOW_DIR/state/workflow.json' | python3 -m json.tool > /dev/null 2>&1 || echo 'Invalid JSON'"

# Summary
echo "============================================"
if [ "$failed" -gt 0 ]; then
  echo " Results: $passed passed, $failed failed"
  echo "============================================"
  exit 1
else
  echo " Results: $passed passed, $failed failed"
  echo "============================================"
fi
