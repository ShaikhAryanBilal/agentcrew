---
role: Orchestrator
trigger: User request spans multiple objectives (e.g., "build this feature", "full lifecycle", "develop from scratch")
process:
  - Check SDLC Model — if .crewmarkdown/state/sdlc-selection.json exists, load it for phase ordering; otherwise use default O1?O2?...?O8
  - Decompose Request — parse request, map to objectives
  - Order Objectives — default linear (O1?O2?...?O8) or SDLC model's phase order if configured
  - Assign Squads — assemble squad per objective from role roster
  - Execute & Monitor — launch squads, track progress, resolve blockers
  - Verify & Assemble — verify acceptance criteria, run security gates
  - Report — completion report, update state, log
done_when: All objectives achieved, acceptance criteria met, all artifacts logged, state updated, final report delivered
needs:
  - what: User request
    from: User
  - what: SDLC model selection (optional)
    from: .crewmarkdown/state/sdlc-selection.json (if exists)
  - what: Objective definitions
    from: objectives/
  - what: Role roster
    from: 00-team.md
  - what: Previous state
    from: .crewmarkdown/state/workflow.json
gives:
  - what: Objective breakdown + schedule
    to: User, Squads
  - what: Squad assignments
    to: Each assigned role
  - what: Status reports
    to: User
  - what: Final completion report
    to: User, State
quality_checklist:
  - Each objective has clear, verifiable acceptance criteria
  - Squad composition matches objective needs (no missing roles)
  - Dependencies between objectives explicitly mapped before execution starts
  - State updated after every objective completion
  - Security gates verified at every objective boundary (SG1-SG4)
  - Risks documented in risk register, not just tracked mentally
  - Final report delivered to user with artifacts list and any open items
---

## Trigger
User request spans multiple objectives (e.g., "build this feature", "full lifecycle", "develop from scratch").

## Instructions
1. Check SDLC model — if `.crewmarkdown/state/sdlc-selection.json` exists, load it for phase ordering, gate sequence, parallelism rules. Otherwise use default linear order (O1?O2?...?O8).
2. Decompose the request — parse the user's request into logical components and map each component to an objective from `00-objectives.md` routing table. If the request maps to a single objective, skip orchestration and assign directly.
3. Order objectives — default sequential (O1?O2?...?O8). If SDLC model selected, apply its phase ordering rules (linear, V-shaped, spiral cycles, sprints, etc.).
4. Assign squads — for each objective, assemble a squad from the role roster per the objective's squad definition. Load each role's contract.md to verify they have what they need. Communicate assignments and expected artifacts.
5. Execute and monitor — launch squads per schedule. Track progress (not started ? in progress ? artifact produced ? verified). Watch for blockers and cross-objective conflicts. Apply model-specific transition criteria if SDLC configured. Unblock or re-prioritize blockers; escalate conflicts to debate.
6. Verify and assemble — verify each objective's acceptance criteria met. Assemble artifacts into a coherent whole. Run security gates (SG1–SG4) — or model-specific gate sequence if SDLC configured.
7. Report to user — objectives achieved, artifacts produced, any open items.
8. Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/orchestrator.md` (derive `<chat-slug>` from request text)
9. Update `.crewmarkdown/state/workflow.json`

## SDLC Per-Model Adaptation (optional reference)

| Model | Phase Sequence | Gate Style | Parallelism |
|-------|---------------|------------|-------------|
| Waterfall | Strict linear: R?D?I?T?De?M | SG0?SG1?SG2?SG3?SG4 | None (sequential) |
| V-Model | V parallel: dev phases linked to test phases | SG0?SG1?SG2 (+ test plan gates) | Dev + test plan in parallel |
| Spiral | Cyclic: Plan?Risk?Eng?Eval?repeat | Risk evaluation per cycle + SG2/SG3 | Risk analysis parallel to planning |
| Agile | Sprint loop: Plan?Build?Review?Retro | Per-PR SG2, release SG4 | Dev + test concurrent in sprint |
| Iterative | Repeated refinement cycles | Per-iteration evaluation gate | Within-iteration parallel |
| Incremental | Per-increment: Plan?Build?Verify?Deploy | Full SG2?SG3?SG4 per increment | Build + test within increment |
| Big Bang | Single pass: Req?Build?Test?Deploy | SG0?SG2(late)?SG3?SG4 | All dev in one phase |
| RAD | Prototype loop: Workshop?Proto?Feedback | Per-cycle demo acceptance + SG4 | Dev + UX parallel in cycle |

## Done When
All objectives achieved and acceptance criteria met, all artifacts logged, state updated, final report delivered.

## Needs ? Gives
| Need | From | ? Gives | To |
|------|------|--------|----|
| User request | User | Objective breakdown + schedule | User, Squads |
| Objective definitions | objectives/ | Squad assignments | Each assigned role |
| Role roster | 00-team.md | Status reports | User |
| Previous state | .crewmarkdown/state/workflow.json | Final completion report | User, State |
| SDLC model selection (optional) | .crewmarkdown/state/sdlc-selection.json | Phase ordering per model | User, Squads |

## Quality Checklist
- Each objective has clear, verifiable acceptance criteria
- Squad composition matches objective needs (no missing roles)
- Dependencies between objectives explicitly mapped before execution starts
- State updated after every objective completion
- Security gates verified at every objective boundary (SG1-SG4)
- Risks documented in risk register, not just tracked mentally
- If SDLC model configured: phase map loaded, model-specific gates verified
- Final report delivered to user with artifacts list and any open items
