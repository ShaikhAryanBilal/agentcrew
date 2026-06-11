---
role: Meeting Facilitator
trigger: User invokes meeting mode: "/meeting [topic]" or "meeting mode [topic]"
process:
  - Convene — parse topic, select roles, show party, set agenda
  - Brainstorm — present topic, invite contributions, capture ideas
  - Decide — facilitate discussion, record decisions
  - Action Items — derive items, assign owners + deliverables + deadlines
  - Minutes — compile record, log to archive
done_when: Agenda set, roles spawned, ideas captured, decisions recorded, action items assigned, minutes logged
needs:
  - what: Meeting topic
    from: User
  - what: Role roster
    from: 00-roles.md
  - what: Role selection matrix
    from: objectives/08-conduct-meeting.md
  - what: Debate sub-workflow
    from: debate/ (if needed)
gives:
  - what: Meeting agenda
    to: All participants
  - what: Meeting minutes
    to: Archive
  - what: Decision records
    to: State, ADR
  - what: Action items
    to: Assigned owners
quality_checklist:
  - Agenda defined with timeboxes before discussion
  - Roles selected match meeting topic (from matrix)
  - All attendees given airtime (no domination)
  - Ideas captured in full before evaluation
  - Decisions documented with alternatives and rationale
  - Action items assigned with owner + deliverable + deadline
  - Minutes complete and archived
---

## Trigger
User invokes meeting mode: "/meeting [topic]" or "meeting mode [topic]"

## Instructions
1. Convene — parse the topic, consult the Role Selection Matrix in `objectives/08-conduct-meeting.md`, select roles based on topic keywords, show RPG party screen, set agenda with timeboxes, and share agenda with all participants.
2. Brainstorm — present topic with context, invite each role to contribute from their perspective, capture all ideas (divergence) before evaluating using round-robin to ensure balance, parking lot off-topic ideas, and summarize.
3. Decide — present options, facilitate discussion where each role gives pros/cons from their lens. If clear consensus, record decision with rationale and alternatives. If strong disagreement, escalate to Debate sub-workflow.
4. Action items — derive items from decisions, assign owner + deliverable + deadline per item, confirm each owner accepts, and summarize.
5. Minutes — compile the full meeting record.
6. Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/meeting.md` (derive `<chat-slug>` from request/topic text)
7. Update `.crewmarkdown/state/workflow.json`

## Done When
Agenda set, roles spawned, ideas captured, decisions recorded, action items assigned, minutes logged.

## Needs → Gives
| Need | From | → Gives | To |
|------|------|--------|----|
| Meeting topic | User | Meeting agenda | All participants |
| Role roster | 00-roles.md | Meeting minutes | Archive |
| Role selection matrix | objectives/08-conduct-meeting.md | Decision records | State, ADR |
| Debate sub-workflow | debate/ (if needed) | Action items | Assigned owners |

## Quality Checklist
- Agenda defined with timeboxes before discussion
- Roles selected match meeting topic (from matrix)
- All attendees given airtime (no domination)
- Ideas captured in full before evaluation
- Decisions documented with alternatives and rationale
- Action items assigned with owner + deliverable + deadline
- Minutes complete and archived
