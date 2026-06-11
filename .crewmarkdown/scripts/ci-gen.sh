#!/usr/bin/env bash
# Generates GitHub Actions CI workflow from workflow state.
# Usage: ./ci-gen.sh [output-dir]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
STATE_FILE="$PROJECT_ROOT/.crewmarkdown/state/workflow.json"
OUTPUT_DIR="${1:-$PROJECT_ROOT/.github/workflows}"

mkdir -p "$OUTPUT_DIR"

cat > "$OUTPUT_DIR/CrewMarkdown-ci.yml" << 'CIEOF'
name: CrewMarkdown CI
on: [push, pull_request]
jobs:
  validate-workflow:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Validate workflow integrity
        run: |
          chmod +x .crewmarkdown/scripts/validate-workflow.sh
          .crewmarkdown/scripts/validate-workflow.sh
CIEOF

echo "CI workflow written: $OUTPUT_DIR/CrewMarkdown-ci.yml"
