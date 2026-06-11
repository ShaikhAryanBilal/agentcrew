# Sprint Planning

## Need
- Prioritized backlog (P0/P1/P2 from requirements)
- Design artifacts (tech spec, architecture, API contracts)
- Team capacity (available dev-hours, PTO, ceremonies)
- Velocity data from last 3 sprints (if available)

## Instructions

### 1. Capacity Calculation

```
Team members: 4
Sprint days: 10 (2 weeks)
Hours per day: 6 (after meetings, context-switching, breaks)
Gross capacity: 4 × 10 × 6 = 240 hours
Subtract ceremonies: ~26h
Net capacity: 214 hours
Buffer (20% for unexpected): 171 hours
```

- [ ] Calculate net capacity
- [ ] Account for PTO, training, support rotation
- [ ] If velocity data exists: use rolling average, not raw capacity

### 2. Break Features Into Tasks

Rules:
- Each task ≤ 1 dev-day (8 hours). Bigger = split.
- Each task is independently deliverable
- Each task maps to a concrete artifact (code, test, docs, migration)

- [ ] Break each P0/P1 into tasks
- [ ] Each task has: estimate (hours), owner (once assigned), dependencies

### 3. Commitment

- [ ] Total tasked hours ≤ net capacity
- [ ] Sprint goal written: 1 sentence, outcome-focused
- [ ] Capacity buffer: leave 20% unplanned for bugs, support, discovery
- [ ] Team commits as a group (not top-down assignment)
- [ ] Flag external dependencies

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| Plan to 100% capacity | Leave 20% buffer. Always. |
| Assign tasks before planning | Team commits together. No top-down assignments. |
| Accept vague tasks ("work on export") | Break down. "Implement CSV generator" is a task. |
| Ignore dependencies | Map them. "Can't start FEAT-2 until payment service releases." |
| Change scope mid-sprint | New work = next sprint. Unless production down. |
| Skip sprint goal | Goal gives focus. Without it, any work fits "in sprint." |

## Time Budget
| Backlog size | Priority review | Task breakdown | Capacity check | Total |
|-------------|----------------|---------------|---------------|-------|
| < 10 items | 15 min | 20 min | 10 min | 45 min |
| 10-20 items | 20 min | 40 min | 15 min | 1.25 hr |
| 20+ items | 30 min | 1 hr | 20 min | 1.75 hr |

## Done
- Sprint backlog (tasks, estimates, owners, dependencies)
- Sprint goal (1 sentence, outcome-focused)
- Capacity plan (net hours, 20% buffer)
- External dependencies flagged
- Team commitment obtained

→ Next: `02-codebase-analysis.md`
Over capacity? Remove lowest-priority P2 items. Under capacity? Pull in P2, don't add P0.
