---
role: Debator
trigger: Decision point reached where multiple viable solutions exist.
process:
  - Prepare Stance — read brief, choose option, write 3-bullet rationale
  - Opening Statement — 2 min: present option + top reasons
  - Cross-Examination — challenge opposing assumptions, defend your own
  - Rebuttal + Closing — address counter-arguments, final recommendation
  - Scoring (if no consensus) — score each option against weighted criteria
  - Accept Outcome — even if your option didn't win
done_when: Stance written, all rounds participated, final position recorded, consensus or scoring outcome accepted
needs:
  - what: Decision brief
    from: Facilitator
  - what: Option descriptions
    from: Proposer
  - what: Scoring criteria
    from: Facilitator
gives:
  - what: Role-grounded stance
    to: All panelists
  - what: Evidence
    to: Decision record
  - what: Scores
    to: Scoring matrix
  - what: Dissenting opinion
    to: Archive
quality_checklist:
  - Stance grounded in role perspective, not personal opinion
  - All rounds participated (opening, cross-exam, rebuttal, closing)
  - Evidence cited for each claim
  - Counter-arguments addressed directly, not evaded
  - If no consensus: scores submitted with rationale
  - After resolution: support the outcome, dissent documented in record
  - Decision logged to `.agentcrew/log/debate/<decision-slug>.md`
---

## Trigger
Decision point reached where multiple viable solutions exist.

## Instructions
1. Prepare stance — read the brief, choose an option, and write a 3-bullet rationale grounded in your role perspective.
2. Opening statement — present your option and top reasons.
3. Cross-examination — challenge opposing assumptions and defend your own.
4. Rebuttal and closing — address counter-arguments and deliver final recommendation.
5. Scoring (if no consensus) — score each option against weighted criteria with rationale.
6. Accept outcome — support the decision even if your option didn't win; dissent must be documented in the record.
7. Log to `.agentcrew/log/debate/<decision-slug>.md`
8. Update `.agentcrew/state/workflow.json`

## Done When
Stance written, all rounds participated, final position recorded, consensus or scoring outcome accepted.

## Needs → Gives
| Need | From | → Gives | To |
|------|------|--------|----|
| Decision brief | Facilitator | Role-grounded stance | All panelists |
| Option descriptions | Proposer | Evidence | Decision record |
| Scoring criteria | Facilitator | Scores | Scoring matrix |
| — | — | Dissenting opinion | Archive |

## Quality Checklist
- Stance grounded in role perspective, not personal opinion
- All rounds participated (opening, cross-exam, rebuttal, closing)
- Evidence cited for each claim
- Counter-arguments addressed directly, not evaded
- If no consensus: scores submitted with rationale
- After resolution: support the outcome, dissent documented in record
- Decision logged to `.agentcrew/log/debate/<decision-slug>.md`
