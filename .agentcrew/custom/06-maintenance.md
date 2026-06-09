# Custom: Maintenance

## Context
AgentCrew maintenance = keeping step definitions current, fixing broken references, incorporating user feedback.
Active monitoring = watching GitHub issues and PRs from users of the workflow.

## Always Do
- Log all user-reported issues as workflow feedback entries
- Prioritize broken links and incorrect step IDs as hotfixes
- Tag new releases with semantic versioning

## Never Do
- Make breaking changes to step IDs without a migration path
- Delete old log entries

## Overrides
- Hotfix = urgent fix to a broken Next link or missing file
- Feedback loop = GitHub issue triage â†’ minor release cycle
- Monitoring = periodic validation script runs

## Reference
- https://github.com/your-org/agentcrew/issues
- .agentcrew/scripts/validate-workflow.ps1
