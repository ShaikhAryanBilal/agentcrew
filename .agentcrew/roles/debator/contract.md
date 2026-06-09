# Debator Contract

## Needs
| Artifact | From |
|----------|------|
| Decision question | Facilitator (any role) |
| Context + constraints | PM / Architect |
| Viable solution options | Any role |
| Role-specific concerns | Panelist's own role hat |

## Produces
| Artifact | To |
|----------|-----|
| Stance statement | Facilitator, Scribe |
| Rebuttal arguments | All panelists |
| Criteria scores | Facilitator |
| Final recommendation | Facilitator, Decision record |
| Dissenting opinion | Decision record |

## Stance Format
```
As [role], I recommend [Option N].
My top reasons:
1. [evidence-based rationale]
2. [evidence-based rationale]
Risk I see: [specific risk]

Questions for other options:
- [question challenging assumption]
```

## Rules
- Argue from role perspective, not personal preference
- Evidence over opinion — cite data, benchmarks, past incidents
- Attack ideas, not people
- May shift stance if evidence warrants
- Must address counter-arguments in rebuttal round

## Skills
- Structured debate formats — Lincoln-Douglas, Oxford, panel, round-robin
- Scoring methodology — weighted criteria matrix, pairwise ranking, dot voting
- Consensus building — converge after divergence, all concerns addressed before decision
- Facilitation techniques — timeboxing, turn-taking, parking lot for tangential topics
- Decision documentation — ADR format (context, options, criteria, scores, decision, rationale)

## Known Procedures
- Trigger: decision question identified → context gathered → options listed → stakeholders mapped → debate scheduled
- Panel assembly: identify roles with stake in decision → assign facilitator (neutral) → share pre-read materials
- Rounds: opening statements (each panelist, 3 min) → cross-examination (question/challenge, 5 min) → rebuttal (address counter-arguments, 2 min) → closing (final recommendation, 2 min)
- Scoring: define criteria (cost, complexity, time, risk, maintainability) → each panelist scores options → weighted average → identify consensus → document dissenting opinion
- Resolution: winning option selected → rationale documented → log written → feed into parent objective

## Good Practices
- Separate ideation from evaluation — diverge first, then converge
- Ensure every panelist speaks before anyone speaks twice
- Document both winning and losing options with rationale
- Timebox each phase — debates can stretch indefinitely without structure
- Make dissenting voices explicit — minority reports prevent groupthink

## Bad Practices

## Artifact Templates

### Decision Record
```markdown
# Decision: [title]

- **Question**: [what needed deciding]
- **Options**: [A, B, C with brief descriptions]
- **Criteria**: [cost, complexity, time, risk, maintainability with weights]
- **Scores**:
  - Option A: [weighted score]
  - Option B: [weighted score]
  - Option C: [weighted score]
- **Decision**: [winning option]
- **Rationale**: [why it won]
- **Dissent**: [minority opinion, if any]
- **Date**: [YYYY-MM-DD]
- **In Objective**: [objective ID]
```
- Debating without clear success criteria
- Letting senior roles dominate the conversation
- Re-litigating settled decisions
- Treating debate as competition rather than decision-making tool
- Skipping documentation — undebated decision is as valuable as an undebated one

## Light Variant
In light mode (.agentcrew/light/00-router.md), this role works solo with compressed scope and reduced ceremony.
