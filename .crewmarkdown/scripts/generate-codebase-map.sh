#!/usr/bin/env bash
# Generates codebase-map.md: full tree + file descriptions + exports.
# Agent reads this to navigate without searching.
# Language-agnostic. Bash equivalent of generate-codebase-map.ps1

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
OUT_FILE="$PROJECT_ROOT/codebase-map.md"

IGNORED_DIRS=("node_modules" ".git" ".svn" ".hg" "dist" "build" ".next" ".nuxt" ".output" "__pycache__" ".venv" "venv" ".env" "env" "coverage" ".nyc_output" ".pytest_cache" "target" "bin" "obj" ".vs" ".terraform" ".serverless" ".opencode" ".cursor" ".vscode")
IGNORED_EXTS=(".min.js" ".min.css" ".map" ".pyc" ".pyo" ".so" ".dll" ".exe" ".jpg" ".jpeg" ".png" ".gif" ".ico" ".svg" ".webp" ".woff" ".woff2" ".ttf" ".eot" ".mp4" ".mp3" ".avi" ".mov" ".zip" ".tar" ".gz" ".rar" ".7z" ".pdf" ".doc" ".docx" ".xls" ".xlsx" ".log")

should_ignore() {
  local rel="$1"
  for d in "${IGNORED_DIRS[@]}"; do
    if [[ "/$rel" == *"/$d/"* ]] || [[ "$rel" == "$d"* ]]; then
      return 0
    fi
  done
  return 1
}

should_ignore_ext() {
  local f="$1"
  for e in "${IGNORED_EXTS[@]}"; do
    if [[ "$f" == *"$e" ]]; then
      return 0
    fi
  done
  return 1
}

echo "Scanning $PROJECT_ROOT ..."

declare -A DETAILS
FILES=()
while IFS= read -r -d '' file; do
  rel="${file#"$PROJECT_ROOT/"}"
  if should_ignore "$rel"; then continue; fi
  fname=$(basename "$file")
  if should_ignore_ext "$fname"; then continue; fi
  FILES+=("$rel")
  lines=$(wc -l < "$file" 2>/dev/null || echo 0)
  size_kb=$(awk "BEGIN {printf \"%.1f\", $(stat -c%s "$file" 2>/dev/null || echo 0)/1024}")
  desc=$(head -20 "$file" 2>/dev/null | grep -E '^#' | head -3 | sed 's/^#\+\s*//' | tr '\n' ' ' | sed 's/ $//' || echo "")
  DETAILS["$rel"]="$lines|$size_kb|$desc"
done < <(find "$PROJECT_ROOT" -type f -print0 2>/dev/null)

IFS=$'\n' FILES=($(sort <<<"${FILES[*]}")); unset IFS

build_tree() {
  local -n TREE=$1
  shift
  for item in "$@"; do
    IFS='/' read -ra PARTS <<< "$item"
    local cur_ref="TREE"
    for ((i=0; i<${#PARTS[@]}-1; i++)); do
      local key="${PARTS[$i]}"
      local existing
      existing=$(declare -p "$cur_ref" 2>/dev/null || true)
      cur_ref="${cur_ref}[$key]"
    done
  done
}

echo "Writing $OUT_FILE ..."

cat > "$OUT_FILE" << EOF
# Codebase Map

Generated: $(date '+%Y-%m-%d %H:%M')
Project: $(basename "$PROJECT_ROOT")
Files: ${#FILES[@]}

Agent reads this first to navigate without searching.

---

## Directory Tree

\`\`\`
$(for f in "${FILES[@]}"; do
  depth=$(awk -F'/' '{print NF-1}' <<< "$f")
  prefix=""
  for ((i=0; i<depth; i++)); do prefix="$prefix|   "; done
  echo "$prefix|-- $f"
done)
\`\`\`

---

## File Details

EOF

for f in "${FILES[@]}"; do
  IFS='|' read -r lines size desc <<< "${DETAILS[$f]}"
  echo "### $f" >> "$OUT_FILE"
  echo "**Lines:** $lines | **Size:** ${size}KB" >> "$OUT_FILE"
  if [ -n "$desc" ]; then
    echo "**Desc:** $desc" >> "$OUT_FILE"
  fi
  echo "" >> "$OUT_FILE"
done

echo "Done: $OUT_FILE (${#FILES[@]} files)"
