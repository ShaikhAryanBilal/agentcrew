# Operate & Learn

## System
You are executing objective: Operate & Learn. Maintain production health, respond to incidents, and continuously improve through feedback loops.

## Instructions
1. Assemble squad: DevOps Engineer, EM, PM
2. DevOps monitors golden signals (logs/JSON structured, metrics, traces with trace_id), configures alerts (PagerDuty immediate, Slack warning, Info dashboard) (procedures/06-maintenance/01-monitoring-and-observability.md)
3. DevOps responds to incidents; if hotfix needed, run hotfix process (procedures/06-maintenance/02-hotfix-process.md): triage < 15 min, backport + RCA within 24h
4. PM collects user feedback and analyzes (procedures/06-maintenance/03-feedback-loop.md)
5. EM runs retrospective (Went Well, Went Wrong, To Improve) and creates improvement backlog items
6. PM produces prioritized feature requests for next cycle; feedback loops back to Clarify Vision
7. Verify acceptance criteria
8. Log to `.agentcrew/log/07-operate-learn/<role>/<timestamp>.md`
9. Update `.agentcrew/state/workflow.json`

## Squad
| Role | Responsibility |
|------|---------------|
| DevOps Engineer | Monitoring, alerting, on-call, incident response |
| EM | Retrospectives, process improvement, team health |
| PM | User feedback collection, improvement backlog |

## Inputs → Outputs
| Input | From | → Output | To |
|-------|------|---------|----|
| Production system | DevOps | Monitoring dashboards (golden signals) (Dashboard) | DevOps |
| Service requirements | EM | Alert configuration + runbooks (Markdown) | DevOps |
| Incidents | Production | Incident reports (if any) (Markdown) | DevOps |
| Critical bugs | DevOps | Hotfix deploys (if needed) (Commits) | Production |
| Sprint/release data | EM | Retrospective notes (Went Well, Went Wrong, To Improve) (Markdown) | EM |
| Retro outcomes | EM | Improvement backlog items (Markdown) | Team |
| User input | Users | User feedback analysis (Markdown) | PM |
| Feedback + retro | PM + EM | Feature requests for next cycle (Markdown) | PM → Clarify Vision |

## Acceptance
- Monitoring covers: logs (JSON, structured), metrics (golden signals), traces (trace_id propagation)
- Alerts configured: PagerDuty (immediate), Slack (warning), Info (dashboard)
- Runbooks exist for top 5 incident patterns
- Retrospective held: action items assigned
- Feedback collected + prioritized for next cycle
- Hotfix process followed if applicable (triage < 15 min, backport + RCA within 24h)

## Gates
- None

## Procedures
- DevOps: `procedures/06-maintenance/01-monitoring-and-observability.md`
- DevOps: `procedures/06-maintenance/02-hotfix-process.md`
- EM/PM: `procedures/06-maintenance/03-feedback-loop.md`

## Debate Triggers
- Refactor vs. rewrite decision → Tech Lead + Architect debate
- Monitoring tooling choice → DevOps debate
- Incident severity classification → DevOps + PM resolve
- On-call rotation structure → EM + DevOps agree
