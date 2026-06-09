# Objective: Ship Release

## Goal
Plan, deploy, and verify a production release with rollback capability and post-deployment monitoring.

## Squad
| Role | Responsibility |
|------|---------------|
| DevOps Engineer | Infrastructure, CI/CD, deployment, monitoring |
| PM | Release planning, stakeholder communication, rollback decision |

## Schedule
```
PM:   Release plan ──> Stakeholder notification ──> Rollback decision authority
DevOps:              Staging deploy ──> Prod deploy ──> Post-deploy monitoring
```

**Sequential**: Plan → Staging → Prod → Post-deploy.  
**Parallel**: PM plans + notifies while DevOps prepares infrastructure.

## Dependencies
- **Needs**: QA sign-off (from Verify Quality)
- **Blocks**: Operate & Learn
- **Also needs**: Secrets, access, rollback approval

## Artifacts
| Role | Produces | Format |
|------|----------|--------|
| PM | Release plan (scope, schedule, stakeholders) | Markdown |
| PM | Release notes | Markdown |
| PM | Rollback approval | Markdown |
| DevOps | Staging deployment + validation | Status |
| DevOps | Production deployment + health checks | Status |
| DevOps | Post-deployment monitoring report | Markdown |
| DevOps | Deploy summary (timeline, metrics) | Markdown |

## Acceptance
- SG4 gate: All scans clean, no Critical/High bugs
- Staging verified (smoke tests pass)
- Production deployed successfully
- Health checks pass (T+5m, T+15m, T+1h, T+4h)
- Rollback plan documented and practiced
- Stakeholders notified
- Post-deploy monitoring confirms no anomalies

## Procedure References
- PM: `procedures/05-deployment/01-release-planning.md`
- DevOps: `procedures/05-deployment/02-staging-deployment.md`
- DevOps: `procedures/05-deployment/03-production-deployment.md`
- DevOps: `procedures/05-deployment/04-post-deployment.md`

## Security Gates
- **SG4**: Before production deploy — All scans clean, no Critical/High bugs

## Debate Triggers
- Rollout strategy (blue-green vs canary vs rolling) → DevOps + PM debate
- Rollback threshold (what metric triggers rollback?) → DevOps + PM agree
- Release scope (what's included vs deferred) → PM decides

## Solo Invocation
- "DevOps, deploy [build] to staging" → DevOps runs staging deploy only
- "DevOps, deploy [build] to production" → DevOps runs prod deploy only
- "PM, write release notes for version [x]" → PM writes notes only
- "DevOps, run post-deploy monitoring for [release]" → DevOps monitors only
