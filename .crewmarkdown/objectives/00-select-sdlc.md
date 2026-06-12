---
id: obj/select-sdlc
squad: PM, Architect, EM
default_mode: Squad
---

# Select SDLC Model (Optional)

## System
You are executing objective: Select SDLC Model. Determine which SDLC methodology fits the project, configure gates and phase ordering, and set expectations for the entire lifecycle. This objective is **optional** — only invoked on explicit request ("Select SDLC model"). Default behavior is objective-driven with linear ordering.

## Instructions
1. Assemble squad: PM, Architect, EM
2. Load `.crewmarkdown/config/sdlc-models.md` for full model definitions
3. PM interviews user/project stakeholders on: requirement clarity, risk tolerance, team size, project complexity, user involvement, delivery speed
4. Architect scores each dimension against `selection_criteria` in sdlc-models.md
5. EM validates against team capacity and timeline
6. Squad recommends top-2 models via structured debate if split
7. PM presents recommendation to user with rationale
8. User selects model
9. Write `.crewmarkdown/state/sdlc-selection.json` with:
   - selected model
   - rationale
   - overridden gates (if any)
   - phase ordering per model's phase map
   - accepted risk level
10. Verify acceptance criteria
11. **Save confirmation**: Ask user "Save artifacts & log this session? [Y/n]" (ref: `procedures/00-save-confirmation.md`). Y→persist, N→in-memory only.
12. If persist: Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/<role>.md` (derive `<chat-slug>` from request text)
13. If persist: Update `.crewmarkdown/state/workflow.json`

## Squad
| Role | Responsibility |
|------|---------------|
| PM | Stakeholder interview, requirements clarity assessment, recommendation |
| Architect | Technical complexity scoring, risk assessment, model fit analysis |
| EM | Team capacity check, timeline constraint validation, delivery speed assessment |

## Inputs → Outputs
| Input | From | → Output | To |
|-------|------|---------|----|
| Project context + requirements | User | Dimension scores (6 axes) | All squad |
| SDLC model definitions | config/sdlc-models.md | Top-2 model recommendation | User |
| User decision | User | `.crewmarkdown/state/sdlc-selection.json` | State, All objectives |

## Acceptance
- All 6 selection dimensions scored with evidence
- Top-2 models presented with pros/cons per project context
- User selected model documented
- sdlc-selection.json written with model, rationale, gate overrides, phase order
- Phase gate sequence configured per model definition
- Risk level documented

## Gates
- SDLC-G0: Selection validated by at least 2 of 3 squad roles
- SDLC-G1: User sign-off on selected model

## Procedures
- PM: `procedures/01-requirements/01-requirements-gathering.md` (lightweight — just selection criteria)
- All: `config/sdlc-models.md`

## Debate Triggers
- Split recommendation (no consensus on top-2) → debate/01-debate-trigger.md
- User wants custom hybrid model → squad designs hybrid via debate

## Phase Map Output
After selection, map SDLC model phases to CrewMarkdown objectives:

| SDLC Phase → CrewMarkdown Objective |
|-----------------------------------|
| See `.crewmarkdown/config/sdlc-models.md` for per-model phase map |

## Next Step
If `sdlc-selection.json` written, Orchestrator reads it for phase ordering. Otherwise default O1→O2→...→O8 applies.
