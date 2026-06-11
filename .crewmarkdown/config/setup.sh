#!/usr/bin/env bash
# Setup AI agent config files for this project.
# Copies from .crewmarkdown/config/ to project root with correct filenames.
# Usage: .crewmarkdown/config/setup.sh [--all] [--tool <name>] [--force]

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../../" && pwd)"
CONFIG_DIR="$REPO_ROOT/.crewmarkdown/config"
FORCE=false
ALL=false
TOOL=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force|-f) FORCE=true; shift ;;
    --all|-a) ALL=true; shift ;;
    --tool|-t) TOOL="$2"; shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

declare -A CONFIGS
CONFIGS=(
  ["opencode.AGENTS.md"]="AGENTS.md:opencode"
  ["opencode.opencode.jsonc"]="opencode.jsonc:opencode"
  ["opencode.SKILL.md"]="SKILL.md:opencode"
  ["cursor.rules"]=".cursorrules:cursor"
  ["claude.MD"]="CLAUDE.md:claude"
  ["copilot.instructions"]="copilot-instructions.md:copilot"
)

detect_tools() {
  local tools=()
  if $ALL; then
    echo "opencode cursor claude copilot"
    return
  fi
  if [[ -n "$TOOL" ]]; then
    echo "$TOOL"
    return
  fi
  command -v opencode &>/dev/null && tools+=("opencode")
  [[ -d "$HOME/.config/Cursor" ]] && tools+=("cursor")
  [[ -d "$HOME/.config/Claude" ]] && tools+=("claude")
  command -v gh &>/dev/null && tools+=("copilot")
  [[ ${#tools[@]} -eq 0 ]] && tools=("opencode" "cursor" "claude" "copilot")
  echo "${tools[@]}"
}

echo ""
echo "=== CrewMarkdown — Config Setup ==="
DETECTED=$(detect_tools)
echo "Detected tools: $DETECTED"
echo ""

copied=0
skipped=0

for src_name in "${!CONFIGS[@]}"; do
  IFS=':' read -r dest_name tool <<< "${CONFIGS[$src_name]}"
  if ! echo "$DETECTED" | grep -qw "$tool"; then
    continue
  fi

  src_path="$CONFIG_DIR/$src_name"
  dest_path="$REPO_ROOT/$dest_name"

  if [[ ! -f "$src_path" ]]; then
    echo "  [WARN] Source not found: $src_name"
    continue
  fi

  # Ensure parent dir exists (e.g., .github/)
  dest_parent=$(dirname "$dest_path")
  mkdir -p "$dest_parent"

  if [[ -f "$dest_path" && "$FORCE" != "true" ]]; then
    echo "  [SKIP] $dest_name already exists (use --force to overwrite)"
    ((skipped++))
    continue
  fi

  cp "$src_path" "$dest_path"
  echo "  [OK]   Copied $src_name → $dest_name"
  ((copied++))
done

echo ""
echo "Done: $copied copied, $skipped skipped."
echo ""
echo "To direct your AI tool to the team config:"
echo "  opencode:   AGENTS.md + opencode.jsonc + SKILL.md"
echo "  Cursor:     .cursorrules"
echo "  Claude:     CLAUDE.md"
echo "  Copilot:    copilot-instructions.md"
