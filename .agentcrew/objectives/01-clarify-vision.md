# Objective: Clarify Vision

## Goal
Transform raw stakeholder input into a signed-off PRD with clear scope, priorities, and user stories.

## Squad
| Role | Responsibility |
|------|---------------|
| PM | Intake, PRD writing, sign-off |
| BA | Requirements analysis, user stories |

## Schedule
```
PM:  Intake ──> PRD Draft ──> Review ──> Sign-off
                    ↑
BA:  Analysis ──────┘ (parallel)
```

**Parallel**: PM gathers requirements while BA analyzes and refines.  
**Sequential**: PRD requires analysis complete. Sign-off requires PRD complete.

## Dependencies
- **Needs**: Stakeholder input from user
- **Blocks**: Design Solution (next objective)

## Artifacts
| Role | Produces | Format |
|------|----------|--------|
| PM | Structured requirement list (5W1H+C) | Markdown |
| BA | Gap analysis, deduped + prioritized reqs | Markdown |
| BA | P0/P1 user stories with acceptance criteria | Markdown |
| PM | PRD document (full template) | Markdown |
| PM | Sign-off record | Markdown |

## Acceptance
- All requirements captured and classified ([F], [NF], [B], [T], [C])
- MoSCoW priorities assigned (P0-P3)
- Dependency graph mapped
- P0/P1 user stories written with 2-3 ACs each
- PRD reviewed and signed off
- Scope frozen

## Procedure References
Roles use these existing step files as how-to guides:
- PM: `procedures/01-requirements/01-requirements-gathering.md` (intake process)
- BA: `procedures/01-requirements/02-requirements-analysis.md` (analysis process)
- PM: `procedures/01-requirements/03-prd.md` (PRD template)
- PM: `procedures/01-requirements/04-requirements-review-and-signoff.md` (sign-off process)

## Debate Triggers
- Priority/scope disputes → PM facilitates debate with BA + Architect
- Feature vs. effort trade-offs → debate/trigger
- Conflicting stakeholder requirements → debate/trigger

## Solo Invocation
- "PM, gather requirements for [feature]" → PM runs intake + PRD
- "BA, analyze these requirements" → BA runs analysis only
- "PM, write the PRD" → PM writes PRD from existing reqs
