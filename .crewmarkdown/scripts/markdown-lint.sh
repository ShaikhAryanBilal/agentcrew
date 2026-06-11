#!/usr/bin/env bash
# Lints Markdown files for frontmatter and heading structure.
# Usage: ./markdown-lint.sh [path] [--fix]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SEARCH_PATH="${1:-$PROJECT_ROOT/.crewmarkdown}"
FIX="${2:-}"

passed=0
failed=0

echo ""
echo "============================================"
echo " Markdown Lint"
echo "============================================"

while IFS= read -r file; do
  rel="${file#$PROJECT_ROOT/}"
  issues=""
  content=$(cat "$file")

  # Check frontmatter
  if [[ "$content" == ---* ]]; then
    rest="${content#---}"
    if [[ "$rest" != *---* ]]; then
      issues+="  Unclosed frontmatter"$'\n'
    fi
  fi

  # Check heading hierarchy
  prev=0
  line_num=0
  while IFS= read -r line; do
    ((line_num++))
    if [[ "$line" =~ ^(#{1,6})\  ]]; then
      level=${#BASH_REMATCH[1]}
      if (( level > prev + 1 )) && (( prev > 0 )); then
        issues+="  Line $line_num: Heading jump from H$prev to H$level"$'\n'
      fi
      prev=$level
    fi
  done < "$file"

  if [ -n "$issues" ]; then
    echo "[ISSUE] $rel"
    echo -n "$issues"
    ((failed++))
  else
    ((passed++))
  fi
done < <(find "$SEARCH_PATH" -name '*.md' -not -path '*/node_modules/*' -not -path '*/.git/*' -type f)

echo "============================================"
echo " Results: $passed clean, $failed with issues"
echo "============================================"
[ "$failed" -eq 0 ] || [ -n "$FIX" ] || exit 1
