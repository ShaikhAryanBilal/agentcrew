# Custom: Deployment

## Context
AgentCrew is deployed by copying .agentcrew/ directory into a target project.
No servers, no containers, no cloud infrastructure.

## Always Do
- Test that a fresh copy of .agentcrew/ works in a blank project
- Document which root-level files (AGENTS.md, .cursorrules, etc.) are optional vs required
- Keep deployment scripts idempotent

## Never Do
- Add deployment steps that require specific cloud providers
- Assume SSH, kubectl, or other infra tooling is available

## Overrides
- Production deployment = tagged release on GitHub
- Staging deployment = branch with CI validation
- Post-deployment = verify the workflow runs end-to-end after copy

## Reference
- README.md â€” quick start and per-tool setup
- SKILL.md â€” opencode skill definition
