#!/usr/bin/env bash
# Bumps version, generates changelog from logs, creates git tag.
# Usage: ./release-prep.sh [major|minor|patch]

set -euo pipefail

BUMP="${1:-patch}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
LOG_DIR="$PROJECT_ROOT/.crewmarkdown/logs"
VERSION_FILE="$PROJECT_ROOT/VERSION"

if [ -f "$VERSION_FILE" ]; then
  version=$(cat "$VERSION_FILE" | tr -d ' \n')
else
  last_tag=$(git -C "$PROJECT_ROOT" describe --tags --abbrev=0 2>/dev/null || echo "")
  if [ -n "$last_tag" ]; then
    version="${last_tag#v}"
  else
    version="0.1.0"
  fi
fi

IFS='.' read -ra parts <<< "$version"
case "$BUMP" in
  major) ((parts[0]++)); parts[1]=0; parts[2]=0 ;;
  minor) ((parts[1]++)); parts[2]=0 ;;
  patch) ((parts[2]++)) ;;
esac
new_version="${parts[0]}.${parts[1]}.${parts[2]}"

changelog="## v${new_version}\n\n"
if [ -d "$LOG_DIR" ]; then
  while IFS= read -r f; do
    rel="${f#$PROJECT_ROOT/}"
    changelog+="- $rel\n"
  done < <(find "$LOG_DIR" -name '*.md' -type f | sort -r | head -20)
fi

echo "$new_version" > "$VERSION_FILE"
echo -e "$changelog\n" | cat - "$PROJECT_ROOT/CHANGELOG.md" 2>/dev/null > "$PROJECT_ROOT/CHANGELOG.md" || true

git -C "$PROJECT_ROOT" add "$VERSION_FILE" "$PROJECT_ROOT/CHANGELOG.md"
git -C "$PROJECT_ROOT" commit -m "chore: bump to v${new_version}"
git -C "$PROJECT_ROOT" tag "v${new_version}"

echo "Released v${new_version}"
echo "Tag: v${new_version}"
