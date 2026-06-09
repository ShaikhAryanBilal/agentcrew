# Objective: Operate & Learn

## Goal
Maintain production health, respond to incidents, and continuously improve through feedback loops.

## Squad
| Role | Responsibility |
|------|---------------|
| DevOps Engineer | Monitoring, alerting, on-call, incident response |
| EM | Retrospectives, process improvement, team health |
| PM | User feedback collection, improvement backlog |

## Schedule
```
DevOps: Monitor ──> Alert ──> Respond ──> (ongoing)
                            └──> Hotfix process (if needed)
EM:                                    Retrospective ──> Backlog
PM:   Feedback collection ──> Improvement prioritization
```

**Parallel**: DevOps monitors + responds. PM collects feedback. EM prepares retro.  
**Sequential**: Hotfix needs incident detection first. Improvement needs feedback + retro.

## Dependencies
- **Needs**: Deployed release (from Ship Release)
- **Blocks**: Future requirements cycle (feedback loops back to Clarify Vision)

## Artifacts
| Role | Produces | Format |
|------|----------|--------|
| DevOps | Monitoring dashboards (golden signals) | Dashboard |
| DevOps | Alert configuration + runbooks | Markdown |
| DevOps | Incident reports (if any) | Markdown |
| DevOps | Hotfix deploys (if needed) | Commits |
| EM | Retrospective notes (Went Well, Went Wrong, To Improve) | Markdown |
| EM | Improvement backlog items | Markdown |
| PM | User feedback analysis | Markdown |
| PM | Feature requests for next cycle | Markdown |

## Acceptance
- Monitoring covers: logs (JSON, structured), metrics (golden signals), traces (trace_id propagation)
- Alerts configured: PagerDuty (immediate), Slack (warning), Info (dashboard)
- Runbooks exist for top 5 incident patterns
- Retrospective held: action items assigned
- Feedback collected + prioritized for next cycle
- Hotfix process followed if applicable (triage < 15 min, backport + RCA within 24h)

## Procedure References
- DevOps: `procedures/06-maintenance/01-monitoring-and-observability.md`
- DevOps: `procedures/06-maintenance/02-hotfix-process.md`
- EM/PM: `procedures/06-maintenance/03-feedback-loop.md`

## Loop Back
Feedback and improvement items feed into the next Clarify Vision objective:
```
Operate & Learn ──> (feedback) ──> Clarify Vision (next cycle)
```

## Debate Triggers
- Refactor vs. rewrite decision → Tech Lead + Architect debate
- Monitoring tooling choice → DevOps debate
- Incident severity classification → DevOps + PM resolve
- On-call rotation structure → EM + DevOps agree

## Solo Invocation
- "DevOps, set up monitoring for [service]" → DevOps sets up dashboards + alerts
- "DevOps, handle this hotfix" → DevOps runs hotfix process
- "EM, run retrospective for [sprint/release]" → EM runs retro
- "PM, collect user feedback on [feature]" → PM collects + analyzes feedback
