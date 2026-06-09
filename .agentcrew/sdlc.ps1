# AgentCrew Step Index
# Usage: .\sdlc.ps1 -List | -Step <id>
#
# AI agents: use .agentcrew/00-router.md for routing logic.
# This script is a human-readable step index, not the instruction source.

param(
  [switch]$List,
  [string]$Step
)

$steps = @{
  "req/gather"      = "procedures/01-requirements/01-requirements-gathering.md"
  "req/analysis"    = "procedures/01-requirements/02-requirements-analysis.md"
  "req/prd"         = "procedures/01-requirements/03-prd.md"
  "req/signoff"     = "procedures/01-requirements/04-requirements-review-and-signoff.md"
  "design/arch"     = "procedures/02-design/01-system-architecture.md"
  "design/spec"     = "procedures/02-design/02-technical-specification.md"
  "design/db"       = "procedures/02-design/03-database-design.md"
  "design/api"      = "procedures/02-design/04-api-design.md"
  "design/threat"   = "procedures/02-design/06-threat-modeling.md"
  "design/review"   = "procedures/02-design/05-design-review.md"
  "dev/planning"    = "procedures/03-development/01-sprint-planning.md"
  "dev/analysis"    = "procedures/03-development/02-codebase-analysis.md"
  "dev/standards"   = "procedures/03-development/03-coding-standards.md"
  "dev/impl"        = "procedures/03-development/04-implementation.md"
  "dev/review"      = "procedures/03-development/05-code-review.md"
  "dev/unit"        = "procedures/03-development/06-unit-testing.md"
  "dev/integration" = "procedures/03-development/07-integration.md"
  "qa/plan"         = "procedures/04-qa/01-test-planning.md"
  "qa/cases"        = "procedures/04-qa/02-test-case-development.md"
  "qa/functional"   = "procedures/04-qa/03-functional-testing.md"
  "qa/nonfunctional"= "procedures/04-qa/04-non-functional-testing.md"
  "qa/regression"   = "procedures/04-qa/05-regression-testing.md"
  "qa/bugs"         = "procedures/04-qa/06-bug-tracking.md"
  "qa/uat"          = "procedures/04-qa/07-uat.md"
  "qa/pentest"      = "procedures/04-qa/09-security-pentest.md"
  "qa/signoff"      = "procedures/04-qa/08-qa-signoff.md"
  "deploy/plan"     = "procedures/05-deployment/01-release-planning.md"
  "deploy/staging"  = "procedures/05-deployment/02-staging-deployment.md"
  "deploy/prod"     = "procedures/05-deployment/03-production-deployment.md"
  "deploy/post"     = "procedures/05-deployment/04-post-deployment.md"
  "ops/monitor"     = "procedures/06-maintenance/01-monitoring-and-observability.md"
  "ops/hotfix"      = "procedures/06-maintenance/02-hotfix-process.md"
  "ops/feedback"    = "procedures/06-maintenance/03-feedback-loop.md"
}

if ($List) {
  Write-Host "SDLC Steps:" -ForegroundColor Cyan
  $steps.Keys | Sort-Object | ForEach-Object {
    Write-Host "  $_ -> $($steps[$_])"
  }
  exit 0
}

if ($Step) {
  if ($steps.ContainsKey($Step)) {
    Write-Host "Step: $_ -> $($steps[$Step])" -ForegroundColor Green
  } else {
    Write-Host "Unknown step: $Step" -ForegroundColor Red
    Write-Host "Use -List to see available steps"
  }
  exit 0
}

Write-Host "AgentCrew Index"
Write-Host "  .\sdlc.ps1 -List    (show all steps)"
Write-Host "  .\sdlc.ps1 -Step id (show step path)"
Write-Host "`nAI agents: read .agentcrew/00-router.md instead." -ForegroundColor Yellow
