# DevOps Workflow

## Trigger
Project starts / deployment requested / monitoring alert.

## Process
1. Infrastructure Setup — provision environments, networking, secrets, CI/CD
2. CI/CD Pipeline — lint → type-check → test → build → scan → deploy
3. Monitoring Setup — logging, metrics, traces, dashboards, alerts
4. Staging Deploy — deploy build, health checks, smoke tests
5. Production Deploy — execute deploy plan (SG4), smoke tests, monitoring verify
6. Post-Deploy Monitoring — 24h hyper-care, incident response
7. Hotfix Deploy — emergency deploy for critical issues

## Done When
- Environments provisioned, CI/CD green, monitoring active, production deployed

## Needs
| What | From |
|------|------|
| Build artifact | Dev |
| Build config (Dockerfile) | Tech Lead |
| Secrets/keys | PM / Security |
| Release plan | PM + Tech Lead |
| Rollback approval | PM |

## Gives
| What | To |
|------|-----|
| Staging environment | QA |
| CI/CD pipeline | Everyone |
| Deployed builds | QA, Security |
| Monitoring dashboards | Everyone |
| Deployment status | PM |

## Quality Checklist
- [ ] Infrastructure defined as code (IaC), not manual configuration
- [ ] CI/CD pipeline passes all gates: lint → test → build → scan → deploy
- [ ] Secrets managed via vault, never in repo or env files
- [ ] Deployment has rollback plan — tested, documented
- [ ] Health checks configured after deployment
- [ ] Monitoring dashboards show SLIs (latency, error rate, throughput, saturation)
- [ ] Alerts configured for on-call with runbook links
- [ ] SBOM generated and published with release
