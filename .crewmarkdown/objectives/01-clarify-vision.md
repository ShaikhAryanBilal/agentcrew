# Clarify Vision

## System
You are executing objective: Clarify Vision. Transform raw stakeholder input into a signed-off PRD with clear scope, priorities, and user stories.

## Instructions
1. Assemble squad: PM, BA
2. Run intake in parallel: PM gathers requirements (procedures/01-requirements/01-requirements-gathering.md), BA analyzes and refines (procedures/01-requirements/02-requirements-analysis.md)
3. BA writes P0/P1 user stories with 2-3 acceptance criteria each
4. PM writes PRD (procedures/01-requirements/03-prd.md), reviews, and obtains sign-off (procedures/01-requirements/04-requirements-review-and-signoff.md)
5. Verify acceptance criteria
6. Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/<role>.md` (derive `<chat-slug>` from request text)
7. Update `.crewmarkdown/state/workflow.json`

## Squad
| Role | Responsibility |
|------|---------------|
| PM | Intake, PRD writing, sign-off |
| BA | Requirements analysis, user stories |

## Inputs → Outputs
| Input | From | → Output | To |
|-------|------|---------|----|
| Raw stakeholder input | User | Structured requirement list (5W1H+C) | BA |
| Structured requirements | PM | Gap analysis, deduped + prioritized reqs ([F]/[NF]/[B]/[T]/[C], MoSCoW P0-P3) | PM |
| Analyzed requirements | BA | P0/P1 user stories with acceptance criteria | PM |
| User stories + reqs | BA + PM | PRD document (full template) | User |
| Approved PRD | User | Sign-off record | PM |

## Acceptance
- All requirements captured and classified ([F], [NF], [B], [T], [C])
- MoSCoW priorities assigned (P0-P3)
- Dependency graph mapped
- P0/P1 user stories written with 2-3 ACs each
- PRD reviewed and signed off
- Scope frozen

## Gates
- None

## Procedures
- PM: `procedures/01-requirements/01-requirements-gathering.md`
- BA: `procedures/01-requirements/02-requirements-analysis.md`
- PM: `procedures/01-requirements/03-prd.md`
- PM: `procedures/01-requirements/04-requirements-review-and-signoff.md`

## Debate Triggers
- Priority/scope disputes → PM facilitates debate with BA + Architect
- Feature vs. effort trade-offs → debate/trigger
- Conflicting stakeholder requirements → debate/trigger
