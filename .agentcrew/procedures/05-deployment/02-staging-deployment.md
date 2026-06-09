# Staging Deployment

## Need
- Build artifact (versioned, CI-verified)
- CI/CD pipeline configured for staging
- Release plan approved (scope, rollback plan, smoke tests)
- Release notes ready

## Decision Tree

```
Is this the first deploy of this build to any environment?
├── Yes → Standard staging deploy. Full smoke test.
├── No (re-deploying same build) → Skip if already tested in staging.
└── Hotfix (bypassing staging)? → Only if production is down. Exception required.

Does the build include DB migrations?
├── Yes → Run migrations FIRST, then deploy app. Migrations must be backward-compatible.
├── Yes but backward-incompatible → Blocked. Must split into phases.
└── No → Deploy app only.

CI/CD pipeline status?
├── Green → Proceed with deploy.
├── Red → Fix CI first. Never deploy from a broken pipeline.
└── Skipped CI (emergency only) → Document exception. Full manual smoke test.
```

## Do

### 1. Pre-Deploy Checks

- [ ] CI pipeline green on the tagged commit? (lint, type-check, unit tests, scans)
- [ ] Build artifact exists and matches tag? (docker image tag, binary checksum)
- [ ] Staging environment healthy? (current version running, no ongoing incidents)
- [ ] Monitoring active for staging? (logs, metrics, alerts)
- [ ] Rollback plan ready? (previous build identified, steps documented)

### 2. Deploy Steps

```
1. Run DB migrations
   - Script: `./scripts/migrate up V003__add_export_log_table`
   - Verify: migration log shows success
   - If fail → STOP. Rollback migration. Do not deploy app.

2. Deploy app
   - Trigger: pipeline deploy to staging
   - Or manual: `kubectl set image deployment/accounting-api accounting-api=v1.2.3`
   - Verify: pods roll without errors

3. Health checks
   - `GET /health` → 200
   - DB connection OK
   - Migration version matches expected

4. Smoke tests
   - Automated: run smoke test suite
   - Manual (if no automation): execute 5 smoke test cases

5. Verify
   - Staging URL: https://staging.example.com
   - Deployed version visible in app footer or /version endpoint
   - New feature accessible to test
```

- [ ] Execute in order. If any step fails, STOP.
- [ ] DB migration before app deploy (backward-compatible only)
- [ ] Health check after deploy (not assumed)

### 3. Post-Deploy Validation

```markdown
Check                        Result
/health                      200 OK
DB connection                Connected
Migration version            V003 (latest)
Smoke: login                 ✅
Smoke: create invoice         ✅
Smoke: export CSV             ✅
Error rate (5 min)           0%
CPU/Memory                   Normal baseline
```

- [ ] Run all smoke tests
- [ ] Monitor for 5 min: error rate, response time, resource usage
- [ ] If smoke test fails → rollback. If metrics degrade → investigate.

### 4. Communication

```markdown
Staging deploy complete: v1.2.3
URL: https://staging.example.com
Smoke tests: ✅ Pass
Available for: QA testing, UAT, stakeholder review
Rollback if needed: v1.2.2 (confirmed healthy)
```

- [ ] Notify: QA, PM, stakeholders
- [ ] Include: version, URL, smoke test status, rollback version
- [ ] If staging deploy fails → notify team, rollback, schedule fix

### 5. Rollback (if needed)

- [ ] Execute rollback per plan:
  1. Revert migration: `./scripts/rollback V003__add_export_log_table`
  2. Deploy previous image: `kubectl set image deployment/accounting-api accounting-api=v1.2.2`
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

## Next → `03-production-deployment.md`
Staging deploy failed? Rollback, fix, retry. Blocking bug found? Revert to dev or QA.
