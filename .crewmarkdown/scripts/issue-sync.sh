#!/usr/bin/env bash
# Pulls GitHub issues into workflow state.
# Usage: ./issue-sync.sh owner/repo [label]

set -euo pipefail

REPO="${1:?Usage: $0 owner/repo [label]}"
LABEL="${2:-}"
TOKEN="${GH_TOKEN:-}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
STATE_FILE="$PROJECT_ROOT/.crewmarkdown/state/workflow.json"

if [ -z "$TOKEN" ]; then
  echo "ERROR: Set GH_TOKEN env var" >&2
  exit 1
fi

page=1
issues=()
while true; do
  url="https://api.github.com/repos/$REPO/issues?state=open&per_page=100&page=$page"
  [ -n "$LABEL" ] && url="$url&labels=$(echo "$LABEL" | jq -sRr @uri)"
  resp=$(curl -s -H "Authorization: Bearer $TOKEN" "$url")
  count=$(echo "$resp" | jq 'length')
  [ "$count" -eq 0 ] && break
  while IFS= read -r item; do issues+=("$item"); done < <(echo "$resp" | jq -c '.[]')
  ((page++))
done

if [ ${#issues[@]} -eq 0 ]; then echo "No open issues found."; exit 0; fi

state=$(cat "$STATE_FILE")
added=0
for issue in "${issues[@]}"; do
  title="Issue: $(echo "$issue" | jq -r '.title')"
  if echo "$state" | jq -e ".achievedObjectives | index(\"$title\")" > /dev/null 2>&1; then continue; fi
  url=$(echo "$issue" | jq -r '.html_url')
  labels=$(echo "$issue" | jq '[.labels[].name]')
  state=$(echo "$state" | jq \
    ".achievedObjectives += [\"$title\"] | .completedSteps += [{\"step\":\"pending\",\"objective\":\"$title\",\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"source\":\"$url\",\"labels\":$labels}]")
  ((added++))
done

echo "$state" > "$STATE_FILE"
echo "Synced $added issues from $REPO."
