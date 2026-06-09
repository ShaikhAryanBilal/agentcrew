# Post-Deployment

## Need
- Production deploy complete and announced
- Monitoring + alerting active (logs, metrics, traces, alerts)
- On-call engineer assigned for hyper-care period
- Deploy report template / format from previous releases

## Decision Tree

```
Is this a major release or patch?
├── Major → 24h hyper-care: active monitoring, on-call focused
├── Minor → 4h hyper-care: active monitoring, then standard
└── Patch → 1h hyper-care: quick check, then standard

Any deploy-time anomalies?
├── Yes (rollback considered but not executed) → Extended hyper-care (48h). Document near-miss.
├── Yes (minor blip, auto-recovered) → Standard hyper-care. Note in report.
└── No → Standard hyper-care.

Critical alert fires during hyper-care?
├── Yes → Incident response. Enter hotfix process.
├── Yes but auto-resolved → Investigate root cause. Log as incident.
└── No → Normal handoff.
```

## Do

### 1. Hyper-Care Monitoring

```markdown
### First 15 min (active watch)
☐ Error rate: 0% (steady, no spikes)
☐ P95 latency: 320ms (baseline: 300ms, within 20% tolerance)
☐ CPU: 35% (baseline: 30%)
☐ Memory: 340MB (baseline: 320MB)
☐ DB connections: 8 active (baseline: 6)
☐ Alerts: 0 firing
→ Status: Green

### First 4h (periodic check — every 30 min)
☐ Error rate: ≤ 0.1%
☐ No error spikes concurrent with deploy
☐ No memory leak (flat or decreasing after initial warm-up)
☐ No slow query regressions

### 24h (final check)
☐ Error rate returned to baseline (0.05%)
☐ Latency stable
☐ No incidents logged
→ 24h report: All clear
```

- [ ] Check interval: every 5 min for first hour, every 30 min for next 4h, at 24h
- [ ] Compare to pre-deploy baseline (not absolute numbers)
- [ ] Watch for gradual degradation (memory leak, connection leak)

### 2. Incident Response (if needed)

```markdown
If critical alert fires:
  1. Acknowledge alert (within 5 min SLA)
  2. Assess: is this a deploy-related issue?
     - Check deploy time vs alert start time
     - Check if feature flag enables new code path
     - Compare to pre-deploy baseline
  3. If deploy-related and severity ≥ High:
     - Option A: Rollback (fastest path, recommended if unsure)
     - Option B: Fix forward (only if root cause known, fix < 30 min)
  4. Log incident: timeline, impact, root cause, resolution
  5. Post-mortem within 48h
```

- [ ] Rollback is default action for deploy-related incidents
- [ ] "Fix forward" only when: root cause known, fix is small, fix < 30 min
- [ ] No blame. Post-mortem is about process, not people.

### 3. Business Metrics (optional, if available)

```markdown
| Metric | Before | After | Change |
|--------|--------|-------|--------|
| Monthly active users | 5,000 | — | Measure in 1 week |
| Export completion rate | N/A (new feature) | 98% | Baseline established |
| Average export size | N/A | 2,300 rows | Baseline established |
| Support tickets (related) | — | 0 in first 24h | Feature seems understood |
```

- [ ] Track feature-specific metrics (if this release introduces a trackable metric)
- [ ] Compare to pre-release baseline
- [ ] Report to PM for feature success evaluation

### 4. Ops Handoff

```markdown
OPS HANDOFF REPORT — v1.2.3

Deploy Date: June 14, 2026
Hyper-care period: June 14 02:00 UTC → June 15 02:00 UTC (24h)
On-call during hyper-care: [Name]
On-call after hyper-care: [Ops Team]

Key metrics at handoff:
  - Error rate: 0.05% (baseline)
  - Latency P95: 320ms (baseline: 300ms)
  - No incidents logged
  - No alerts firing

Known issues in production:
  - BUG-016: Date filter edge case (low risk, PM accepted)
    → No action needed unless user reports

Related dashboards:
  - Accounts API: https://grafana.example.com/d/accounting-api
  - Export feature: https://grafana.example.com/d/export-feature

Related alerts:
  - accounting-api-error-rate (warning: >1%, critical: >5%)
  - accounting-api-latency-p95 (warning: >1s, critical: >2s)

Rollback info:
  - Previous build: v1.2.2 (confirmed healthy)
  - Rollback steps: see release-plan.md
```

- [ ] Handoff includes: metrics, known issues, dashboards, alerts, rollback info
- [ ] On-call engineer acknowledges handoff

### 5. Deploy Summary Report

```markdown
DEPLOY REPORT — v1.2.3 — Invoice Export

Date: June 14, 2026
Duration: 15 min (01:55 UTC — 02:10 UTC)
Downtime: 0 (rolling update)
Rollback: Not required

Smoke tests: ✅ All passed
Hyper-care: 24h (no incidents)
Incidents: 0

Summary:
  - Error rate stable at 0.05% (baseline)
  - P95 latency 320ms (within threshold)
  - No memory leak or resource degradation
  - New feature (CSV export) generating expected usage
  - Zero support tickets related to release

Verdict: ✅ Successful deploy
```

- [ ] Write report within 24h of deploy
- [ ] Share with team + stakeholders
- [ ] Archive in release documentation

## Anti-Patterns

| Don't | Instead |
|-------|---------|
| Deploy and walk away | 24h hyper-care. Monitor actively. |
| Ignore small anomalies | 0.5% error rate increase = investigate. Don't wait for it to grow. |
| Skip business metrics | Did the feature work? Measure adoption, not just uptime. |
| No ops handoff | Ops team needs context. Dashboards, alerts, known issues. |
| Deploy report once and forget | Archive. Use for retrospective and next release planning. |

## Time Budget

| Hyper-care | Active Monitoring | Periodic Checks | Report | Handoff | Total |
|-----------|-----------------|----------------|--------|---------|-------|
| 1h (patch) | 15 min | 15 min | 15 min | 10 min | 55 min |
| 4h (minor) | 30 min | 30 min | 20 min | 15 min | 1.5 hr |
| 24h (major) | 1 hr (total) | 1 hr (total) | 30 min | 15 min | 2.75 hr |

## Done
- 24h hyper-care monitoring completed (error rate, latency, resources stable)
- Incident log (if any incidents occurred, with timeline and resolution)
- Business metrics recorded (feature adoption, if applicable)
- Ops handoff complete (dashboards, alerts, known issues, rollback info)
- Deploy summary report shared with team + stakeholders

## Next → `06-maintenance/01-monitoring-and-observability.md`
Incident during hyper-care? Route to hotfix process. Feature adoption below expectations? Route to feedback loop.
