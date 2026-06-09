# Production Deployment

## Need
- Build verified on staging (smoke tests passed, monitored for minimum 24h)
- Signed-off release plan (PM + Tech Lead approval)
- Deploy window scheduled (off-peak hours, stakeholders notified)
- **SG4 check:** All security gates pass (SAST, secret scan, dep scan, DAST, pentest — no Critical/High)
- Rollback plan confirmed (steps tested, previous build identified)
- Monitoring + alerting active for production

## Instructions

### 1. Final Pre-Deploy Checklist

```
Pre-deploy checks (T-15 min):
☐ SG4 gate: All security scans clean — ✅
☐ Monitoring active: logs, metrics, alerts — ✅
☐ On-call engineer available for next 2h — ✅
☐ Rollback plan confirmed — ✅
☐ Stakeholders notified — ✅
☐ Deploy window confirmed — ✅
☐ DB migration verified backward-compatible — ✅
```

- [ ] Run checklist 15 min before deploy window
- [ ] If any item is ❌ → defer deploy, resolve issue

### 2. Deploy Execution

```
T+00:00 — Start deploy
  1. Run DB migrations (if any)
     - If fail → ROLLBACK migration. Do NOT deploy app.
T+00:02 — Deploy app
T+00:05 — Verify health
T+00:07 — Monitor for 15 min
T+00:22 — Announce deploy complete
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
```

- [ ] Everyone knows when to rollback. No debate during incident.
- [ ] Better to rollback fast and re-deploy later than to debug in production.

### 4. Post-Deploy Announcement

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

→ Next: `04-post-deployment.md`
Rollback triggered? Fix issue in dev, re-deploy to staging, then prod. SG4 fail before deploy? Block.
