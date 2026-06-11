#!/usr/bin/env bash
# Validates .crewmarkdown/ directory structure and required files.
# Usage: ./health-check.sh [-q]

set -euo pipefail

QUIET=false
[ "${1:-}" = "-q" ] && QUIET=true

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
WORKFLOW_DIR="$PROJECT_ROOT/.crewmarkdown"

REQUIRED_DIRS=("objectives" "roles" "procedures" "custom" "state" "scripts" "log" "meeting" "debate" "config")
REQUIRED_FILES=("00-objectives.md" "00-team.md" "00-roles.md" "state/workflow.json")

passed=0
failed=0

check() {
  local name="$1"
  shift
  if "$@" 2>/dev/null; then
    $QUIET || echo "  [PASS] $name"
    ((passed++))
  else
    echo "  [FAIL] $name"
    ((failed++))
  fi
}

$QUIET || {
  echo ""
  echo "============================================"
  echo " CrewMarkdown Health Check"
  echo "============================================"
}

check ".crewmarkdown directory exists" test -d "$WORKFLOW_DIR"
for dir in "${REQUIRED_DIRS[@]}"; do
  check "Directory: $dir" test -d "$WORKFLOW_DIR/$dir"
done
for file in "${REQUIRED_FILES[@]}"; do
  check "File: $file" test -f "$WORKFLOW_DIR/$file"
done
check "workflow.json is valid JSON" python3 -m json.tool "$WORKFLOW_DIR/state/workflow.json" > /dev/null 2>&1

$QUIET || {
  echo "============================================"
  echo " Results: $passed passed, $failed failed"
  echo "============================================"
}
[ "$failed" -eq 0 ] || exit 1
