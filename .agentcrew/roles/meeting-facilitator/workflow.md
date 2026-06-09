# Meeting Facilitator Workflow

## Trigger
User invokes meeting mode: "/meeting [topic]" or "meeting mode [topic]"

## Process

### Phase 1: Convene
1. Parse meeting topic from user input
2. Consult Role Selection Matrix in `objectives/08-conduct-meeting.md`
3. Determine which roles to spawn based on topic keywords
4. Show RPG party screen with assembled squad
5. Set agenda with timeboxes
6. Share agenda with all participants

### Phase 2: Brainstorm
1. Present topic with context
2. Invite each role to contribute from their perspective
3. Capture all ideas (divergence) before evaluating
4. Use round-robin to ensure balanced contribution
5. Parking lot for off-topic but valuable ideas
6. Summarize ideas gathered

### Phase 3: Decide
1. Present options / ideas for decision
2. Facilitate discussion — each role gives pros/cons from their lens
3. If clear consensus -> record decision
4. If strong disagreement -> escalate to Debate sub-workflow (debate/trigger)
5. Record decision with rationale, alternatives, and consensus level

### Phase 4: Action Items
1. Derive action items from decisions made
2. Assign owner + deliverable + deadline per item
3. Confirm each owner accepts their item
4. Summarize all action items

### Phase 5: Minutes
1. Compile full meeting record
2. Write to `.agentcrew/log/meeting/<topic-slug>/<timestamp>.md`
3. Update `.agentcrew/state/workflow.json` with meeting artifact

## Done When
- Agenda set and shared
- All relevant roles spawned and contributed
- Ideas brainstormed and captured
- Decisions recorded with rationale
- Action items assigned with owners and deadlines
- Minutes logged to `.agentcrew/log/meeting/`

## Needs
| What | From |
|------|------|
| Meeting topic | User |
| Role roster | `.agentcrew/00-roles.md` |
| Role selection matrix | `objectives/08-conduct-meeting.md` |
| Debate sub-workflow | `debate/` (if needed) |

## Gives
| What | To |
|------|-----|
| Meeting agenda | All participants |
| Meeting minutes | Archive |
| Decision records | State, ADR |
| Action items | Assigned owners |

## Quality Checklist
- [ ] Agenda defined with timeboxes before discussion
- [ ] Roles selected match meeting topic (from matrix)
- [ ] All attendees given airtime (no domination)
- [ ] Ideas captured in full before evaluation
- [ ] Decisions documented with alternatives and rationale
- [ ] Action items assigned with owner + deliverable + deadline
- [ ] Minutes complete and archived
