#!/usr/bin/env bash
# Bootstraps CrewMarkdown .crewmarkdown/ directory in a target project.
# Usage: ./scaffold-init.sh [target-dir] [--force]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="${1:-$SCRIPT_DIR/..}"
TARGET="${2:-.}"
FORCE="${3:-}"

[ "$TARGET" = "--force" ] && FORCE="--force" && TARGET="."
[ "$SOURCE" = "--force" ] && FORCE="--force" && SOURCE="$SCRIPT_DIR/.."

SOURCE="$(cd "$SOURCE" && pwd)"
TARGET_DIR="$TARGET/.crewmarkdown"
mkdir -p "$TARGET_DIR"

COPY_DIRS=("objectives" "roles" "procedures" "scripts" "config" "meeting" "debate" "custom" "state")
COPY_FILES=("00-objectives.md" "00-team.md" "00-roles.md")

for dir in "${COPY_DIRS[@]}"; do
  if [ -d "$SOURCE/$dir" ]; then
    cp -r${FORCE:+f} "$SOURCE/$dir" "$TARGET_DIR/" 2>/dev/null || true
    echo "  Copied: $dir"
  fi
done

for file in "${COPY_FILES[@]}"; do
  if [ -f "$SOURCE/$file" ]; then
    cp ${FORCE:+-f} "$SOURCE/$file" "$TARGET_DIR/" 2>/dev/null || true
    echo "  Copied: $file"
  fi
done

echo ""
echo "CrewMarkdown scaffolded at: $TARGET_DIR"
echo "Next: Copy AGENTS.md or .cursorrules to project root."
