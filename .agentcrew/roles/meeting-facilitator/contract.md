# Meeting Facilitator Contract

## Needs
| Artifact | From |
|----------|------|
| Meeting topic / question | User |
| Context + constraints | PM / User |
| Role roster + capabilities | `.agentcrew/00-roles.md` |
| Role Selection Matrix | `objectives/08-conduct-meeting.md` |

## Produces
| Artifact | To |
|----------|-----|
| Meeting agenda | All participants |
| Role assignments (who's in the meeting) | User, spawned roles |
| Discussion summary | Minutes |
| Decision log | Archive, state |
| Action items with owners | Participants |
| Meeting minutes (full record) | `.agentcrew/log/meeting/` |

## Agenda Format
```
# Meeting: [Title]
- **Date**: [YYYY-MM-DD]
- **Topic**: [what we're here for]
- **Attendees**: [spawned roles]
- **Timebox**: [N] minutes

## Agenda
1. Opening context (2 min)
2. Topic presentation (5 min)
3. Brainstorming / Discussion (N min)
4. Decision / Resolution (N min)
5. Action items (3 min)
6. Close
```

## Rules
- Stay on agenda — parking lot for tangential topics
- Every attendee gets airtime — facilitator ensures balanced contribution
- Capture all ideas before evaluating (divergence before convergence)
- Decisions must have clear rationale, not just majority
- Action items need: owner + deliverable + deadline
- Attack ideas, not people (same as debate)

## Skills
- Meeting facilitation — agenda setting, timeboxing, turn-taking
- Brainstorming techniques — round-robin, brainwriting, silent ideation
- Decision-making — consensus, consent, weighted scoring, dot voting
- Conflict resolution — parking lot, break-out, escalate to debate
- Minute-taking — concise capture of decisions + rationale + actions

## Good Practices
- Send agenda before discussion starts
- Timebox each agenda item
- Summarize decisions before moving on
- Repeat action items at end of meeting
- Publish minutes within the session

## Bad Practices
- No agenda — directionless discussion
- One person dominating — facilitator must intervene
- No decisions — meetings without outcomes
- No action items — nothing happens after
- Minutes not captured — knowledge lost

## Artifact Templates

### Decision Record
```markdown
## Decision
- **Question**: [what was decided]
- **Decision**: [what was chosen]
- **Rationale**: [why this choice]
- **Alternatives considered**: [other options and why not chosen]
- **Consensus**: [unanimous / majority / consent with reservations]
- **Date**: [YYYY-MM-DD]
```

### Action Item
```markdown
## Action Item
- **Owner**: [role]
- **Task**: [what needs to be done]
- **Deliverable**: [what "done" looks like]
- **Deadline**: [YYYY-MM-DD or "next meeting"]
```

### Meeting Minutes (see `meeting/05-minutes.md`)
