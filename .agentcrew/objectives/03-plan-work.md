# Objective: Plan Work

## Goal
Break down approved designs into a committed sprint plan with task assignments, capacity allocation, and coding standards established.

## Squad
| Role | Responsibility |
|------|---------------|
| EM | Capacity calculation, task breakdown, sprint commitment |
| PM | Priority alignment, backlog refinement, sprint goal |
| Tech Lead | Coding standards, technical guidance, task sizing |

## Schedule
```
Tech Lead: Standards ──> (reference doc, available throughout)
EM:        Capacity calc ──> Task breakdown ──> Sprint commitment
PM:        Priority alignment ──> Sprint goal definition
```

**Parallel**: Tech Lead defines/reviews standards while EM calculates capacity and PM aligns priorities.  
**Sequential**: Sprint commitment needs capacity + priorities + task breakdown.

## Dependencies
- **Needs**: Approved design pack (from Design Solution)
- **Blocks**: Build Feature

## Artifacts
| Role | Produces | Format |
|------|----------|--------|
| EM | Capacity calculation (team hours available) | Markdown |
| EM | Task breakdown (each ≤ 1 dev-day) | Markdown |
| EM | Sprint commitment | Markdown |
| PM | Prioritized backlog (current sprint) | Markdown |
| PM | Sprint goal statement | Markdown |
| Tech Lead | Coding standards (if new or updated) | Markdown |
| Tech Lead | Task size estimates (S/M/L/XL) | Markdown |

## Acceptance
- All tasks ≤ 1 dev-day
- Total sprint load within capacity
- Sprint goal defined and agreed
- Coding standards documented (new project) or confirmed (existing)
- Dependencies between tasks identified
- Acceptance criteria per task defined

## Procedure References
- EM: `procedures/03-development/01-sprint-planning.md`
- Tech Lead: `procedures/03-development/03-coding-standards.md`

## Debate Triggers
- Sprint scope vs capacity conflict → PM + EM negotiate
- Technical approach disagreement → Tech Lead facilitates
- Priority dispute → PM decides, EM adjusts

## Solo Invocation
- "EM, plan the sprint for these features" → EM runs sprint planning
- "Tech Lead, define coding standards for [language]" → Tech Lead writes standards
- "PM, prioritize the backlog" → PM prioritizes
