#!/usr/bin/env bash
# Template generator: Interactive scaffold for custom/*.md files.
# Prompts user for project-specific context, then fills custom templates.
# Usage: ./init-workflow.sh
# Or non-interactive: ./init-workflow.sh --project "MyApp" --stack "node,react,postgres"

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKFLOW_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CUSTOM_DIR="$WORKFLOW_DIR/custom"

echo "============================================"
echo " CrewMarkdown — Project Initializer"
echo "============================================"
echo "This will scaffold custom/*.md with your project context."
echo ""

# Parse args or prompt
PROJECT=""
STACK=""
CI_TOOL=""
TICKET_TRACKER=""
DEPLOY_TARGET=""
MONITORING=""

if [ "$#" -gt 0 ] && [ "$1" = "--project" ]; then
  shift
  while [ "$#" -gt 0 ]; do
    case "$1" in
      --project) PROJECT="$2"; shift 2 ;;
      --stack) STACK="$2"; shift 2 ;;
      --ci) CI_TOOL="$2"; shift 2 ;;
      --tickets) TICKET_TRACKER="$2"; shift 2 ;;
      --deploy) DEPLOY_TARGET="$2"; shift 2 ;;
      --monitoring) MONITORING="$2"; shift 2 ;;
      *) echo "Unknown option: $1"; exit 1 ;;
    esac
  done
else
  read -r -p "Project name: " PROJECT
  read -r -p "Tech stack (comma-sep, e.g. node,react,postgres): " STACK
  read -r -p "CI/CD tool (e.g. GitHub Actions, GitLab CI): " CI_TOOL
  read -r -p "Ticket tracker (e.g. GitHub Issues, Jira, Linear): " TICKET_TRACKER
  read -r -p "Deploy target (e.g. Vercel, AWS, Docker): " DEPLOY_TARGET
  read -r -p "Monitoring tool (e.g. Datadog, Sentry, Grafana): " MONITORING
fi

STACK="${STACK:-Not specified}"
CI_TOOL="${CI_TOOL:-Not specified}"
TICKET_TRACKER="${TICKET_TRACKER:-Not specified}"
DEPLOY_TARGET="${DEPLOY_TARGET:-Not specified}"
MONITORING="${MONITORING:-Not specified}"

FILLED=0

fill_template() {
  local phase="$1"
  local file="$CUSTOM_DIR/$phase.md"
  local context="$2"
  local always="$3"
  local never="$4"
  local overrides="$5"
  local reference="$6"

  cat > "$file" << EOF
# Custom: $(echo "$phase" | sed 's/^[0-9]*-//' | sed 's/.md$//' | tr '-' ' ' | sed 's/\b\(.\)/\u\1/g')

## Context
Project: $PROJECT
$context

## Always Do
$always

## Never Do
$never

## Overrides
$overrides

## Reference
$reference
EOF
  ((FILLED++))
}

# Requirements
fill_template "01-requirements" \
  "Tech stack: $STACK
Ticket tracker: $TICKET_TRACKER" \
  "- Write user stories in format: As a... I want... So that...
- Link every requirement to a ticket in $TICKET_TRACKER
- Include acceptance criteria for each story" \
  "- Write technical implementation details in requirements
- Skip non-functional requirements" \
  "(default procedure)" \
  "- $TICKET_TRACKER project board
- Product docs (link)"

# Design
fill_template "02-design" \
  "Tech stack: $STACK
Deploy target: $DEPLOY_TARGET" \
  "- Include architecture decision records (ADR) for major choices
- Use Mermaid diagrams for system architecture
- Document API contracts before implementation" \
  "- Over-engineer — design only what's needed for current sprint
- Skip security considerations" \
  "(default procedure)" \
  "- ADR template in docs/adr/
- API style guide (link)"

# Development
fill_template "03-development" \
  "CI/CD: $CI_TOOL
Deploy target: $DEPLOY_TARGET" \
  "- Follow Conventional Commits (feat:, fix:, chore:, docs:)
- All PRs must pass $CI_TOOL checks before merge
- Include tests with every feature" \
  "- Commit directly to main/master
- Leave TODO/FIXME without a linked ticket" \
  "- Code analysis step skips if codebase-map.md exists and is current" \
  "- Coding standards: link
- PR template: link"

# QA
fill_template "04-qa" \
  "CI/CD: $CI_TOOL" \
  "- All tests must pass in $CI_TOOL before merge
- Classify bugs by severity: Critical/Major/Minor
- Write regression tests for every bug fix" \
  "- Skip non-functional testing for MVP features
- Mark tests as passed without evidence" \
  "(default procedure)" \
  "- Test dashboard: link
- Bug tracker: $TICKET_TRACKER"

# Deployment
fill_template "05-deployment" \
  "CI/CD: $CI_TOOL
Deploy target: $DEPLOY_TARGET
Monitoring: $MONITORING" \
  "- Deployments go through $CI_TOOL pipeline — no manual deploys
- Use feature flags for risky releases
- Monitor $MONITORING dashboards for 30min post-deploy" \
  "- Deploy on Fridays
- Skip staging for 'small' changes" \
  "(default procedure)" \
  "- $MONITORING dashboard: link
- Runbook: link
- On-call schedule: link"

# Maintenance
fill_template "06-maintenance" \
  "Monitoring: $MONITORING" \
  "- All alerts from $MONITORING route to on-call channel
- Hotfixes bypass the full pipeline but still need review
- Post-incident RCA within 48 hours" \
  "- Apply hotfixes without testing in staging first
- Ignore deprecation warnings" \
  "(default procedure)" \
  "- $MONITORING alerts: link
- Incident response runbook: link"

echo ""
echo "============================================"
echo " Done! $FILLED custom files scaffolded."
echo " Edit them anytime: $CUSTOM_DIR"
echo "============================================"
