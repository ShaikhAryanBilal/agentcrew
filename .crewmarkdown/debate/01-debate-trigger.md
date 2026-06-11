# Debate Trigger — When to Debate

## Need
- Decision point reached in any workflow phase
- Multiple viable solutions exist (not 1 obvious choice)
- Stakeholders disagree on approach
- High-risk decision (cost, security, performance, timeline impact)

## Instructions

### 1. Identify Decision Point
- [ ] What is the exact decision to be made? (write as a single question)
- [ ] Who are the stakeholders for this decision?
- [ ] What's the impact of getting it wrong?
- [ ] Is there a deadline for this decision?

### 2. Determine Debate Format
- [ ] Light debate: 1 round, 2 panelists, 15 min
- [ ] Standard debate: 2 rounds, 3-4 panelists, 30 min
- [ ] Full debate: 3 rounds, 4-5 panelists + facilitator, 45 min

### 3. Assign Roles
- [ ] **Facilitator** — neutral, runs process, enforces timeboxes
- [ ] **Panelists** — one per role/stakeholder with a stake in the decision
- [ ] **Scribe** — documents arguments, evidence, final decision
- [ ] **Voters** — decide the winner

### 4. Prepare Brief
Write a one-page brief with: decision question, context, options, constraints, debate format

## Debate Thresholds
| Trigger Condition | Example | Action |
|-------------------|---------|--------|
| Tech choice tie | REST vs GraphQL | Full debate |
| Architecture fork | Monolith vs microservices | Full debate |
| Feature priority dispute | P0 vs P1 classification | Light debate |
| Timeline estimate split | 2 weeks vs 6 weeks | Standard debate |
| Design pattern conflict | Repository vs CQRS | Standard debate |
| Security approach | Auth0 vs custom | Full debate |
| Cost vs quality | AWS vs self-hosted | Light debate |

## Done
- Decision question written
- Debate format selected
- Panelists assigned
- Brief prepared

→ Next: `02-debate-panel.md`
Only one obvious option? Skip debate. Proceed to next workflow step.
