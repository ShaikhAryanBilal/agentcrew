#!/usr/bin/env bash
# Promotes meeting decisions to formal ADRs.
# Usage: ./adr-gen.sh [source-log]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
LOG_DIR="$PROJECT_ROOT/.crewmarkdown/logs"
OUTPUT_DIR="$PROJECT_ROOT/.crewmarkdown/procedures/adr"
SOURCE_LOG="${1:-}"

mkdir -p "$OUTPUT_DIR"

if [ -z "$SOURCE_LOG" ]; then
  SOURCE_LOG=$(find "$LOG_DIR" -name '*.md' -type f -printf '%T@ %p\n' 2>/dev/null | sort -rn | head -1 | awk '{print $2}')
  [ -z "$SOURCE_LOG" ] && { echo "No log files found." >&2; exit 0; }
fi

content=$(cat "$SOURCE_LOG")
adr_num=$(find "$OUTPUT_DIR" -name '*.md' -type f | wc -l)
((adr_num++))

# Extract decision blocks
echo "$content" | awk '
  /^- Question:/ { q=$0; sub(/^- Question: */,"",q); in_block=1; d=""; r=""; a=""; next }
  /^- Decision:/ && in_block { d=$0; sub(/^- Decision: */,"",d) }
  /^- Rationale:/ && in_block { r=$0; sub(/^- Rationale: */,"",r) }
  /^- Alternatives Considered:/ && in_block { a=$0; sub(/^- Alternatives Considered: */,"",a) }
  /^- Consensus/ && in_block {
    if (q && d) {
      num=adr_num
      slug=$(echo "$q" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9 -]//g' | sed 's/ /-/g' | cut -c1-40)
      cat > "$OUTPUT_DIR/$(printf "%03d" $num)-$slug.md" << ADR
# ADR $num: $q
- **Date**: $(date +%Y-%m-%d)
- **Status**: Proposed
## Context
$q
## Decision
$d
## Rationale
$r
## Alternatives Considered
$a
## Consequences
- (to be filled)
---
*Source: $SOURCE_LOG*
ADR
      echo "  ADR written: $(printf "%03d" $num)-$slug.md"
      ((adr_num++))
    }
    q=""; d=""; r=""; a=""; in_block=0
  }
' adr_num="$adr_num" OUTPUT_DIR="$OUTPUT_DIR" SOURCE_LOG="$SOURCE_LOG"

echo "ADR generation complete."
