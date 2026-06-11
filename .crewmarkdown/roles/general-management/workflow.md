---
role: General Management
trigger: Annual planning / quarterly review / strategic pivot / cross-team blocker.
process:
  - Strategy Formation — synthesize market intel, company vision, competitive landscape → strategic pillars
  - OKR Setting — draft company OKRs, cascade to departments, align key results
  - Resource Allocation — review budget vs headcount vs priorities, make trade-off decisions
  - Cross-functional Initiatives — charter teams, set scope, assign DRI, track milestones
  - Quarterly Business Review — OKR progress, financial health, market dynamics, priority reset
  - Decision Tracking — log all major decisions with context, rationale, and revisit date
done_when: OKRs set and cascaded, resources allocated, QBR complete, decision log current.
needs:
  - what: Department updates & KPIs
    from: All departments
  - what: Company strategy / vision
    from: Board / Founders
  - what: Market intelligence
    from: Marketing, Sales
  - what: Resource constraints
    from: Finance, HR
gives:
  - what: OKR framework & goals
    to: Everyone
  - what: Strategic plan & roadmap
    to: Everyone
  - what: Resource allocation
    to: All departments
  - what: Initiative charters
    to: All departments
  - what: Decision log
    to: Everyone
quality_checklist:
  - OKRs follow SMART criteria
  - Every team has cascaded OKRs aligned to company goals
  - Resource allocation tied to strategic priorities (not equal splits)
  - QBR held within 2 weeks of quarter end
  - Decision log updated within 1 week of each major decision
  - Cross-team initiatives have DRIs and milestone dates
---
## Trigger
Annual planning / quarterly review / strategic pivot / cross-team blocker.

## Instructions
1. Strategy formation — synthesize market intel, company vision, competitive landscape → strategic pillars.
2. OKR setting — draft company OKRs, cascade to departments, align key results.
3. Resource allocation — review budget vs headcount vs priorities, make trade-off decisions.
4. Cross-functional initiatives — charter teams, set scope, assign DRI, track milestones.
5. Quarterly business review — OKR progress, financial health, market dynamics, priority reset.
6. Decision tracking — log all major decisions with context, rationale, and revisit date.
7. Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/general-management.md`
8. Update `.crewmarkdown/state/workflow.json`

## Done When
OKRs set and cascaded, resources allocated, QBR complete, decision log current.

## Needs → Gives
| Need | From | → Gives | To |
|------|------|--------|----|
| Department updates & KPIs | All departments | OKR framework & goals | Everyone |
| Company strategy / vision | Board / Founders | Strategic plan & roadmap | Everyone |
| Market intelligence | Marketing, Sales | Resource allocation | All departments |
| Resource constraints | Finance, HR | Initiative charters | All departments |
| — | — | Decision log | Everyone |

## Quality Checklist
- OKRs follow SMART criteria
- Every team has cascaded OKRs aligned to company goals
- Resource allocation tied to strategic priorities (not equal splits)
- QBR held within 2 weeks of quarter end
- Decision log updated within 1 week of each major decision
- Cross-team initiatives have DRIs and milestone dates
