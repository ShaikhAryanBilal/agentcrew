# Staging Deployment

## Need
- Build artifact (versioned, CI-verified)
- CI/CD pipeline configured for staging
- Release plan approved (scope, rollback plan, smoke tests)
- Release notes ready

## Instructions

### 1. Pre-Deploy Checks

- [ ] CI pipeline green on the tagged commit?
- [ ] Build artifact exists and matches tag?
- [ ] Staging environment healthy?
- [ ] Monitoring active for staging?
- [ ] Rollback plan ready?

### 2. Deploy Steps

```
1. Run DB migrations
   - If fail → STOP. Rollback migration. Do not deploy app.
2. Deploy app
3. Health checks
4. Smoke tests
5. Verify staging URL and deployed version
```

- [ ] Execute in order. If any step fails, STOP.
- [ ] DB migration before app deploy (backward-compatible only)
- [ ] Health check after deploy (not assumed)

### 3. Post-Deploy Validation

- [ ] Run all smoke tests
- [ ] Monitor for 5 min: error rate, response time, resource usage
- [ ] If smoke test fails → rollback. If metrics degrade → investigate.

### 4. Communication

- [ ] Notify: QA, PM, stakeholders
- [ ] Include: version, URL, smoke test status, rollback version
- [ ] If staging deploy fails → notify team, rollback, schedule fix

### 5. Rollback (if needed)

- [ ] Execute rollback per plan:
  1. Revert migration
  2. Deploy previous image
  3. Verify health checks pass
  4. Monitor 5 min
- [ ] Log rollback reason and findings
- [ ] Notify team: deployment reverted

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| Deploy without health checks | Health check first. If it fails, fix or rollback. |
| Skip smoke tests | 5 min of smoke tests. Every deploy. |
| Deploy migration after app | Migration first, app second. Never reverse. |
| Assume staging = production | Staging catches most issues. Still test prod separately. |
| Ignore staging deploy failure | Staging failed = prod will fail too. Fix first. |

## Time Budget
| Steps | Pre-Deploy | Deploy | Smoke Tests | Verify | Total |
|-------|-----------|--------|-------------|--------|-------|
| Automated pipeline | 5 min | 5-10 min | 5 min | 5 min | 20-25 min |
| Manual deploy | 10 min | 15 min | 10 min | 10 min | 45 min |

## Done
- Build deployed to staging
- DB migrations run (if applicable)
- Health checks passing
- Smoke tests green (automated or manual)
- Staging URL available and communicated
- Monitoring stable (5 min)
- Rollback ready if needed

→ Next: `03-production-deployment.md`
Staging deploy failed? Rollback, fix, retry. Blocking bug found? Revert to dev or QA.
