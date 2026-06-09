# Debate Trigger — When to Debate

## Need
- Decision point reached in any SDLC phase
- Multiple viable solutions exist (not 1 obvious choice)
- Stakeholders disagree on approach
- High-risk decision (cost, security, performance, timeline impact)

## Decision Tree

```
One obvious solution?
├── Yes → Skip debate. Proceed directly.
└── No → Multiple viable options exist?
    ├── No → Single path forward. No debate needed.
    └── Yes → Decision impact level?
        ├── Low (cosmetic, trivial) → Quick poll, no formal debate
        ├── Medium (affects 1 component/sprint) → Light debate (1 round)
        └── High (cross-team, budget, security, scale) → Full debate (3 rounds)

Risk level of wrong decision?
├── Low → Light debate sufficient
├── Medium → Standard debate
└── High → Full debate with external panelist if available
```

## Debate Thresholds

| Trigger Condition | Example | Action |
|-------------------|---------|--------|
| Tech choice tie | REST vs GraphQL, SQL vs NoSQL | Full debate |
| Architecture fork | Monolith vs microservices, event-driven vs sync | Full debate |
| Feature priority dispute | P0 vs P1 classification | Light debate |
| Timeline estimate split | 2 weeks vs 6 weeks for same scope | Standard debate |
| Design pattern conflict | Repository vs CQRS, MVC vs MVVM | Standard debate |
| Security approach | Auth0 vs custom, encryption at rest vs full | Full debate |
| Cost vs quality | AWS vs self-hosted, managed vs custom | Light debate |

## Do

### 1. Identify Decision Point

- [ ] What is the exact decision to be made? (write as a single question)
- [ ] Who are the stakeholders for this decision?
- [ ] What's the impact of getting it wrong? (cost, time, quality, security)
- [ ] Is there a deadline for this decision?

### 2. Determine Debate Format

- [ ] Light debate: 1 round, 2 panelists, 15 min
- [ ] Standard debate: 2 rounds, 3-4 panelists, 30 min
- [ ] Full debate: 3 rounds, 4-5 panelists + facilitator, 45 min

### 3. Assign Roles

- [ ] **Facilitator** — neutral, runs process, enforces timeboxes
- [ ] **Panelists** — one per role/stakeholder with a stake in the decision
- [ ] **Scribe** — documents arguments, evidence, final decision
- [ ] **Voters** — decide the winner (may be facilitator + panelists or separate)

### 4. Prepare Brief

Write a one-page brief containing:

```
## Decision Question
[Single, clear question]

## Context
[Background, constraints, why this matters]

## Options
| # | Option | Proposed By | 1-sentence Description |
|---|--------|-------------|------------------------|
| 1 | ... | Architect | ... |
| 2 | ... | Backend Dev | ... |
| 3 | ... | PM | ... |

## Constraints
- Budget: $
- Timeline: weeks
- Team skill: [current stack]
- Compliance: [requirements]

## Debate Format
- Type: Light / Standard / Full
- Panelists: [roles]
- Timebox: [minutes]
```

## Output Format

```
## Debate Record
- Decision: [question]
- Date: yyyy-mm-dd
- Format: Light / Standard / Full
- Facilitator: [role]
- Panelists: [role1, role2, ...]
- Scribe: [role]
```

## Done
- Decision question written
- Debate format selected
- Panelists assigned
- Brief prepared

## Next → `02-debate-panel.md`
Only one obvious option? Skip debate. Proceed to next workflow step.
