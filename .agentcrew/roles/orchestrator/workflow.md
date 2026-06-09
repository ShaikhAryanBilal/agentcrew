---
role: Orchestrator
trigger: User request spans multiple objectives (e.g., "build this feature", "full SDLC", "develop from scratch")
process:
  - Decompose Request — parse request, map to objectives
  - Order Objectives — determine dependency order, parallel vs sequential
  - Assign Squads — assemble squad per objective from role roster
  - Execute & Monitor — launch squads, track progress, resolve blockers
  - Verify & Assemble — verify acceptance criteria, run security gates
  - Report — completion report, update state, log
done_when: All objectives achieved and acceptance criteria met, all artifacts logged, state updated, final report delivered
needs:
  - what: User request
    from: User
  - what: Objective definitions
    from: objectives/
  - what: Role roster
    from: 00-team.md
  - what: Previous state
    from: .agentcrew/state/workflow.json
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
User request spans multiple objectives (e.g., "build this feature", "full SDLC", "develop from scratch").

## Instructions
1. Decompose the request — parse the user's request into logical components and map each component to an objective from `00-objectives.md` routing table. If the request maps to a single objective, skip orchestration and assign directly.
2. Order objectives — determine dependency order, identify which objectives can run in parallel vs sequentially, and create a schedule.
3. Assign squads — for each objective, assemble a squad from the role roster per the objective's squad definition. Load each role's contract.md to verify they have what they need. Communicate assignments and expected artifacts.
4. Execute and monitor — launch squads per schedule. Track progress (not started → in progress → artifact produced → verified). Watch for blockers and cross-objective conflicts. Unblock or re-prioritize blockers; escalate conflicts to debate.
5. Verify and assemble — verify each objective's acceptance criteria met. Assemble artifacts into a coherent whole. Run security gates at objective boundaries (SG1–SG4).
6. Report to user — objectives achieved, artifacts produced, any open items.
7. Log to `.agentcrew/log/orchestrator/<timestamp>.md`
8. Update `.agentcrew/state/workflow.json`

## Done When
All objectives achieved and acceptance criteria met, all artifacts logged, state updated, final report delivered.

## Needs → Gives
| Need | From | → Gives | To |
|------|------|--------|----|
| User request | User | Objective breakdown + schedule | User, Squads |
| Objective definitions | objectives/ | Squad assignments | Each assigned role |
| Role roster | 00-team.md | Status reports | User |
| Previous state | .agentcrew/state/workflow.json | Final completion report | User, State |

## Quality Checklist
- Each objective has clear, verifiable acceptance criteria
- Squad composition matches objective needs (no missing roles)
- Dependencies between objectives explicitly mapped before execution starts
- State updated after every objective completion
- Security gates verified at every objective boundary (SG1-SG4)
- Risks documented in risk register, not just tracked mentally
- Final report delivered to user with artifacts list and any open items
