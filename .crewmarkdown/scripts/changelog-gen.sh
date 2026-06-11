#!/usr/bin/env bash
# Generates CHANGELOG.md from .crewmarkdown/logs and git log.
# Usage: ./changelog-gen.sh [since]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
LOG_DIR="$PROJECT_ROOT/.crewmarkdown/logs"
SINCE="${1:-}"
OUTPUT="$PROJECT_ROOT/CHANGELOG.md"

[ -z "$SINCE" ] && SINCE=$(git -C "$PROJECT_ROOT" describe --tags --abbrev=0 2>/dev/null || echo "HEAD~10")

entries=()
while IFS= read -r line; do
  entries+=("- $line")
done < <(git -C "$PROJECT_ROOT" log "$SINCE..HEAD" --oneline --no-decorate 2>/dev/null || true)

if [ -d "$LOG_DIR" ]; then
  while IFS= read -r f; do
    rel="${f#$PROJECT_ROOT/}"
    entries+=("- $rel")
  done < <(find "$LOG_DIR" -name '*.md' -type f | sort -r | head -30)
fi

{
  echo "# Changelog"
  echo ""
  echo "## $(date +%Y-%m-%d)"
  echo ""
  if [ ${#entries[@]} -gt 0 ]; then
    printf '%s\n' "${entries[@]}" | sort -u
  else
    echo "- No changes since $SINCE"
  fi
  echo ""
} > "$OUTPUT"

echo "Changelog written: $OUTPUT (${#entries[@]} entries)"
