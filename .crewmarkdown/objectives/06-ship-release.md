# Ship Release

## System
You are executing objective: Ship Release. Plan, deploy, and verify a production release with rollback capability and post-deployment monitoring.

## Instructions
1. Assemble squad: DevOps Engineer, PM, Technical Writer
2. PM writes release plan (scope, schedule, stakeholders) (procedures/05-deployment/01-release-planning.md) and notifies stakeholders
3. DevOps deploys to staging (procedures/05-deployment/02-staging-deployment.md), validates with smoke tests
4. DevOps deploys to production (procedures/05-deployment/03-production-deployment.md) after SG4 passes
5. DevOps runs post-deploy monitoring (procedures/05-deployment/04-post-deployment.md): health checks at T+5m, T+15m, T+1h, T+4h
6. Technical Writer writes release notes / changelog
7. PM holds rollback approval authority; rollback plan documented and practiced
8. Verify acceptance criteria
9. Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/<role>.md` (derive `<chat-slug>` from request text)
10. Update `.crewmarkdown/state/workflow.json`

## Squad
| Role | Responsibility |
|------|---------------|
| DevOps Engineer | Infrastructure, CI/CD, deployment, monitoring |
| PM | Release planning, stakeholder communication, rollback decision |
| Technical Writer | Release notes, changelog, upgrade guides |

## Inputs → Outputs
| Input | From | → Output | To |
|-------|------|---------|----|
| QA sign-off + scope | QA + PM | Release plan (scope, schedule, stakeholders) (Markdown) | PM |
| Build + release plan | Dev + PM | Staging deployment + validation (Status) | DevOps |
| Staging validation + SG4 | DevOps | Production deployment + health checks (Status) | DevOps |
| Prod deployment | DevOps | Post-deployment monitoring report (Markdown) | DevOps |
| Release scope | PM | Rollback approval (Markdown) | PM |
| Release version | PM | Release notes / changelog (Markdown) | Technical Writer |
| All events | All | Deploy summary (timeline, metrics) (Markdown) | DevOps |

## Acceptance
- SG4 gate: All scans clean, no Critical/High bugs
- Staging verified (smoke tests pass)
- Production deployed successfully
- Health checks pass (T+5m, T+15m, T+1h, T+4h)
- Rollback plan documented and practiced
- Stakeholders notified
- Post-deploy monitoring confirms no anomalies

## Gates
- **SG4**: Before production deploy — All scans clean, no Critical/High bugs

## Procedures
- PM: `procedures/05-deployment/01-release-planning.md`
- DevOps: `procedures/05-deployment/02-staging-deployment.md`
- DevOps: `procedures/05-deployment/03-production-deployment.md`
- DevOps: `procedures/05-deployment/04-post-deployment.md`

## Debate Triggers
- Rollout strategy (blue-green vs canary vs rolling) → DevOps + PM debate
- Rollback threshold (what metric triggers rollback?) → DevOps + PM agree
- Release scope (what's included vs deferred) → PM decides
