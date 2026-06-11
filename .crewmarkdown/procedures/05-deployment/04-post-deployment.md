# Post-Deployment

## Need
- Production deploy complete and announced
- Monitoring + alerting active (logs, metrics, traces, alerts)
- On-call engineer assigned for hyper-care period
- Deploy report template / format from previous releases

## Instructions

### 1. Hyper-Care Monitoring

```
### First 15 min (active watch)
☐ Error rate: 0% (steady, no spikes)
☐ P95 latency: within 20% tolerance
☐ CPU/Memory: stable
☐ Alerts: 0 firing
→ Status: Green

### First 4h (periodic check — every 30 min)
☐ Error rate: ≤ 0.1%
☐ No memory leak
☐ No slow query regressions

### 24h (final check)
☐ Error rate returned to baseline
☐ Latency stable
☐ No incidents logged
```

- [ ] Check interval: every 5 min for first hour, every 30 min for next 4h, at 24h
- [ ] Compare to pre-deploy baseline (not absolute numbers)
- [ ] Watch for gradual degradation (memory leak, connection leak)

### 2. Incident Response (if needed)

If critical alert fires:
1. Acknowledge alert (within 5 min SLA)
2. Assess: is this a deploy-related issue?
3. If deploy-related and severity ≥ High:
   - Option A: Rollback (fastest path, recommended if unsure)
   - Option B: Fix forward (only if root cause known, fix < 30 min)
4. Log incident: timeline, impact, root cause, resolution
5. Post-mortem within 48h

- [ ] Rollback is default action for deploy-related incidents
- [ ] "Fix forward" only when: root cause known, fix is small, fix < 30 min

### 3. Business Metrics (optional, if available)

- [ ] Track feature-specific metrics (if this release introduces a trackable metric)
- [ ] Compare to pre-release baseline
- [ ] Report to PM for feature success evaluation

### 4. Ops Handoff

- [ ] Handoff includes: metrics, known issues, dashboards, alerts, rollback info
- [ ] On-call engineer acknowledges handoff

### 5. Deploy Summary Report

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
- 24h hyper-care monitoring completed
- Incident log (if any incidents occurred, with timeline and resolution)
- Business metrics recorded (feature adoption, if applicable)
- Ops handoff complete
- Deploy summary report shared with team + stakeholders

→ Next: `06-maintenance/01-monitoring-and-observability.md`
Incident during hyper-care? Route to hotfix process. Feature adoption below expectations? Route to feedback loop.
