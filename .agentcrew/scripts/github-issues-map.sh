#!/usr/bin/env bash
# Maps GitHub Issues to SDLC workflow steps via labels.
# Usage: ./github-issues-map.sh owner/repo [label-filter]
# Requires: curl, jq

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <owner/repo> [label-filter]"
  echo "Example: $0 myuser/myproject bug"
  exit 1
fi

REPO="$1"
LABEL_FILTER="${2:-}"

WORKFLOW_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUTPUT_DIR="$WORKFLOW_DIR/log"
mkdir -p "$OUTPUT_DIR"

declare -A LABEL_MAP
LABEL_MAP[bug]="qa/bugs"
LABEL_MAP[enhancement]="req/gather"
LABEL_MAP[feature]="req/gather"
LABEL_MAP[documentation]="dev/impl"
LABEL_MAP[security]="qa/pentest"
LABEL_MAP[deployment]="deploy/plan"
LABEL_MAP[hotfix]="ops/hotfix"
LABEL_MAP[test]="qa/plan"
LABEL_MAP[design]="design/arch"
LABEL_MAP[data]="obj/data-pipeline"
LABEL_MAP[ml]="obj/ml-pipeline"
LABEL_MAP[mobile]="obj/mobile-feature"
LABEL_MAP[adr]="adr/propose"
LABEL_MAP[postmortem]="postmortem"

echo "Fetching issues from $REPO ..."

API_URL="https://api.github.com/repos/$REPO/issues?state=open&per_page=100"
[ -n "$LABEL_FILTER" ] && API_URL="$API_URL&labels=$LABEL_FILTER"

if ! command -v jq &> /dev/null; then
  echo "Error: jq is required. Install with: apt install jq / brew install jq"
  exit 1
fi

ISSUES=$(curl -sf "$API_URL" 2>/dev/null || curl -sf -H "Authorization: token $GITHUB_TOKEN" "$API_URL" 2>/dev/null) || {
  echo "Failed to fetch issues. Check repo name or set GITHUB_TOKEN."
  exit 1
}

MAPPED=""
UNMAPPED=""
MAPPED_COUNT=0
UNMAPPED_COUNT=0
TOTAL=$(echo "$ISSUES" | jq length)

for row in $(echo "$ISSUES" | jq -r '.[] | @base64'); do
  _jq() { echo "$row" | base64 -d | jq -r "$1"; }
  num=$(_jq '.number')
  title=$(_jq '.title')
  url=$(_jq '.html_url')
  labels=$(_jq '[.labels[].name] | join(",")')

  matched=""
  IFS=',' read -ra LABELS <<< "$labels"
  for lbl in "${LABELS[@]}"; do
    key=$(echo "$lbl" | tr '[:upper:]' '[:lower:]')
    if [ -n "${LABEL_MAP[$key]:-}" ]; then
      matched="${LABEL_MAP[$key]}"
      break
    fi
  done

  if [ -n "$matched" ]; then
    MAPPED="$MAPPED| [#$num]($url) | $title | $matched |"$'\n'
    ((MAPPED_COUNT++))
  else
    UNMAPPED="$UNMAPPED| [#$num]($url) | $title | $labels |"$'\n'
    ((UNMAPPED_COUNT++))
  fi
done

TIMESTAMP=$(date '+%Y%m%dT%H%M%S')
REPORT_FILE="$OUTPUT_DIR/github-issues-$TIMESTAMP.md"

cat > "$REPORT_FILE" << EOF
# GitHub Issues → AgentCrew Map

**Repo:** $REPO
**Generated:** $(date '+%Y-%m-%d %H:%M')
**Total open issues:** $TOTAL
**Mapped:** $MAPPED_COUNT
**Unmapped:** $UNMAPPED_COUNT

---

## Mapped Issues

| Issue | Title | Workflow Step |
|-------|-------|--------------|
$MAPPED
---

## Unmapped Issues (no matching label)

| Issue | Title | Labels |
|-------|-------|--------|
$UNMAPPED
---

## Label → Step Mapping Reference

| Label | Workflow Step |
|-------|--------------|
$(for key in "${!LABEL_MAP[@]}"; do echo "| $key | ${LABEL_MAP[$key]} |"; done | sort)

## Instructions

Agent: For each mapped issue, route to the corresponding workflow step.
For unmapped issues, ask "Which SDLC phase does this belong to?"
EOF

echo "Report written: $REPORT_FILE"
echo "  Mapped: $MAPPED_COUNT, Unmapped: $UNMAPPED_COUNT"
