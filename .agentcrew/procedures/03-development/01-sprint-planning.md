# Sprint Planning

## Need
- Prioritized backlog (P0/P1/P2 from requirements)
- Design artifacts (tech spec, architecture, API contracts)
- Team capacity (available dev-hours, PTO, ceremonies)
- Velocity data from last 3 sprints (if available)

## Decision Tree

```
New team vs established?
├── New → Use 60% of available hours for first sprint (buffer for unknowns)
└── Established → Use avg velocity from last 3 sprints

Sprint length?
├── 1 week → Best for focused, low-uncertainty work
├── 2 weeks → Standard. Default if unsure.
└── 3-4 weeks → Only for high-certainty, well-defined projects

Feature size?
├── All tasks fit in sprint → Normal planning
├── Feature too large → Split into multiple sprints. Define milestones.
└── Unknown size → Add research spike (time-boxed, max 2 days)
```

## Do

### 1. Capacity Calculation

```
Team members: 4
Sprint days: 10 (2 weeks)
Hours per day: 6 (after meetings, context-switching, breaks)

Gross capacity: 4 × 10 × 6 = 240 hours

Subtract ceremonies:
  Sprint planning: 2h × 4 people = 8h
  Daily standup: (15min × 10 days) × 4 = 10h
  Review + retro: 2h × 4 people = 8h

Net capacity: 240 - 26 = 214 hours

Buffer (20% for unexpected): 214 × 0.8 = 171 hours
```

- [ ] Calculate net capacity
- [ ] Account for PTO, training, support rotation
- [ ] If velocity data exists: use rolling average, not raw capacity

### 2. Break Features Into Tasks

Rules:
- Each task ≤ 1 dev-day (8 hours). Bigger = split.
- Each task is independently deliverable (not "depends on task 3 to test")
- Each task maps to a concrete artifact (code, test, docs, migration)

```
Feature: CSV Export (P0, estimate: M)

Tasks:
  1. [3h] Invoice Service: implement CSV generation logic
  2. [2h] API: add GET /api/v1/invoices/export endpoint
  3. [2h] API: add date range filter, pagination
  4. [3h] Tests: unit tests for CSV generation
  5. [2h] Tests: integration test for export endpoint
  6. [1h] Docs: update API spec with export endpoint
  Total: 13h (within estimate)
```

- [ ] Break each P0/P1 into tasks
- [ ] Each task has: estimate (hours), owner (once assigned), dependencies

### 3. Commitment

- [ ] Total tasked hours ≤ net capacity
- [ ] Sprint goal written: 1 sentence, outcome-focused
  ```
  Good: "Ship invoice CSV export so accounting can close month-end"
  Bad:  "Implement export feature" (too vague)
  ```
- [ ] Capacity buffer: leave 20% unplanned for bugs, support, discovery
- [ ] Team commits as a group (not top-down assignment)
- [ ] Flag external dependencies ("waiting on design team for mockups")

### 4. Output Format

```
SPRINT PLAN — Sprint 12 (Jun 8 - Jun 19)
Goal: Ship invoice CSV export for month-end close

Capacity:
  Available: 171h (4 devs × 10 days, minus ceremonies, 20% buffer)
  Planned: 145h
  Buffer: 26h

Backlog:

P0 (must complete):
  [FEAT-1] Invoice Service: CSV generation — Alex (3h)
  [FEAT-2] Export endpoint — Alex (4h)
  [FEAT-3] Date range filter — Jamie (2h)

P1 (should complete):
  [FEAT-4] Unit tests — Jamie (3h)
  [FEAT-5] Integration tests — Sam (2h)
  [FEAT-6] API docs — Sam (1h)

Risks:
  - Depends on payment service API (external team) — deadline might slip
```

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

## Next → `02-codebase-analysis.md`
Over capacity? Remove lowest-priority P2 items. Under capacity? Pull in P2, don't add P0.
