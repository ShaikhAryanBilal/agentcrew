# Production Deployment

## Need
- Build verified on staging (smoke tests passed, monitored for minimum 24h)
- Signed-off release plan (PM + Tech Lead approval)
- Deploy window scheduled (off-peak hours, stakeholders notified)
- **SG4 check:** All security gates pass (SAST, secret scan, dep scan, DAST, pentest — no Critical/High)
- Rollback plan confirmed (steps tested, previous build identified)
- Monitoring + alerting active for production

## Decision Tree

```
SG4 status?
├── Pass (all scans clean, no Critical/High bugs) → Deploy
├── Pass with known Medium/Low (accepted by PM) → Deploy with noted risks
└── Fail (Critical/High security findings) → DO NOT DEPLOY. Block.

Staging verification status?
├── Green (all tests passed, 24h stable) → Deploy
├── Green but < 24h in staging → Acceptable for patches. Full monitoring for major.
└── Yellow (minor issues, no blockers) → PM decides: deploy with watch list.

Downtime expected?
├── None (rolling/blue-green) → Deploy anytime in window
├── < 1 min → Scheduled within window, notify users
└── > 1 min → Schedule carefully, communicate clearly
```

## Do

### 1. Final Pre-Deploy Checklist

```markdown
Pre-deploy checks (T-15 min):

☐ SG4 gate: All security scans clean — ✅
☐ Monitoring active: logs, metrics, alerts — ✅
☐ On-call engineer available for next 2h — ✅
☐ Rollback plan confirmed (build: v1.2.2, ETA: 5 min) — ✅
☐ Stakeholders notified (PM, support, eng) — ✅
☐ Deploy window confirmed (02:00 UTC, June 14) — ✅
☐ DB migration verified backward-compatible (tested on staging) — ✅
☐ Feature flags disabled? (if launching gated feature, keep disabled) — ✅
☐ Caches warmed? (if applicable) — N/A
```

- [ ] Run checklist 15 min before deploy window
- [ ] If any item is ❌ → defer deploy, resolve issue

### 2. Deploy Execution

```markdown
T+00:00 — Start deploy
  1. Run DB migrations (if any)
     - Execute: `./scripts/migrate up V003__add_export_log_table`
     - Verify: migration successful, no errors
     - If fail → ROLLBACK migration. Do NOT deploy app.

T+00:02 — Deploy app
  2. Trigger CD pipeline: prod deploy
     - Or manual: `kubectl set image deployment/accounting-api accounting-api=v1.2.3`
     - Rolling update: 2 new pods start, 2 old pods drain
     - Verify: all pods healthy (readiness probe passes)

T+00:05 — Verify health
  3. Check health endpoint: `GET /health` → 200
  4. Check metrics: error rate, latency, CPU, memory
  5. Run smoke tests (automated):
     - Login, create invoice, list, export, logout
     - All pass ✅

T+00:07 — Monitor
  6. Monitor for 15 min:
     - Error rate: 0% (baseline)
     - P95 latency: within baseline ±20%
     - CPU/Memory: stable
     - Alerts: none firing

T+00:22 — Announce
  7. Announce deploy complete
```

- [ ] Execute steps in sequence. If any step fails, decide: fix forward or rollback.
- [ ] Never leave partial deploy (migration applied, app not deployed).

### 3. Rollback Decision

```
Rollback if:
  - Error rate spike > 5% in any 1-min window (first 15 min)
  - P95 latency > 2x baseline for 2+ min
  - Critical bug: data loss, auth broken, payment processing incorrect
  - Smoke test fails

Rollback steps:
  1. Revert migration: `./scripts/rollback V003__add_export_log_table`
  2. Deploy previous: `kubectl set image deployment/accounting-api accounting-api=v1.2.2`
  3. Verify health → 200
  4. Monitor 15 min
  5. Announce rollback

Rollback trigger authority:
  - DevOps: automatic (error rate, latency thresholds)
  - QA: manual (smoke test failure, bug discovery)
  - PM: manual (business impact decision)
```

- [ ] Everyone knows when to rollback. No debate during incident.
- [ ] Better to rollback fast and re-deploy later than to debug in production.

### 4. Post-Deploy Announcement

```markdown
Deploy Complete: v1.2.3 — Invoice Export
Time: 02:15 UTC, June 14
Duration: 15 min
Downtime: 0 (rolling update)
Smoke tests: ✅ Pass
Monitoring: Stable (15 min)

Included:
  - Invoice CSV export
  - Bug fixes: BUG-012, BUG-015

Next:
  - Post-deploy monitoring: 24h hyper-care
  - On-call: [Name]
  - Report: tomorrow
```

- [ ] Send to: team channel, stakeholders, support
- [ ] Include: version, duration, downtime, smoke test result, on-call contact

## Anti-Patterns

| Don't | Instead |
|-------|---------|
| Deploy on Friday afternoon | Early week, off-peak hours. Never before weekend without coverage. |
| Skip SG4 check | Security scans must pass before production. No exceptions. |
| Deploy without rollback plan | Assume deploy will fail. Have rollback ready. |
| Skip monitoring during deploy | Watch dashboards. Don't walk away. |
| Ignore small errors | 0.5% error rate increase is a signal. Investigate. |
| Manual deploy steps | Automate everything. Hands-off deploys = fewer errors. |

## Time Budget

| Deploy Type | Pre-Checks | Deploy | Smoke | Monitor | Total |
|-------------|-----------|--------|-------|---------|-------|
| Automated pipeline | 10 min | 2-5 min | 2 min | 15 min | 30 min |
| Manual (no pipeline) | 15 min | 10-15 min | 5 min | 15 min | 45-50 min |

## Done
- Build deployed to production
- DB migrations run (if applicable)
- Health checks passing
- Smoke tests green
- Monitoring stable (15 min)
- Deploy announcement sent
- Rollback plan available (not executed)

## Next → `04-post-deployment.md`
Rollback triggered? Fix issue in dev, re-deploy to staging, then prod. SG4 fail before deploy? Block.
