# Meeting: Minutes — Full Meeting Record

## Need
- Agenda from convene step
- Brainstorm output
- Decision records
- Action items

## Do

### 1. Compile Full Minutes
Combine all meeting artifacts into a single comprehensive record:

```
# Meeting Minutes

## Header
- **Title**: [Meeting title]
- **Date**: [YYYY-MM-DD]
- **Time**: [HH:MM - HH:MM]
- **Duration**: [N] minutes
- **Objective**: [single-sentence purpose]
- **Objective ID**: obj/conduct-meeting

## Attendees
- [Role 1]
- [Role 2]
- [Role 3]
- **Facilitator**: Meeting Facilitator

## Agenda (as planned)
1. Opening context (2 min)
2. Topic presentation (5 min)
3. Brainstorming / Discussion (N min)
4. Decision / Resolution (N min)
5. Action items (3 min)

## Discussion Summary

### Agenda Item 1: Opening Context
[Summary of opening context provided]

### Agenda Item 2: Topic Presentation
[Key points presented]

### Agenda Item 3: Brainstorming / Discussion
| Role | Contribution |
|------|-------------|
| [Role 1] | [Key points] |
| [Role 2] | [Key points] |
| [Role 3] | [Key points] |

## Decisions

### Decision 1: [Title]
- **Question**: [what was decided]
- **Decision**: [chosen option]
- **Rationale**: [why this path]
- **Alternatives**: [other options considered]
- **Consensus**: [unanimous / consent / majority]

### Decision 2: [Title]
...

## Action Items

| # | Task | Owner | Deliverable | Deadline |
|---|------|-------|-------------|----------|
| 1 | [Task] | [Role] | [Done when] | [Date] |
| 2 | [Task] | [Role] | [Done when] | [Date] |

## Parking Lot
- [Deferred topic 1]
- [Deferred topic 2]

## Next Meeting
- Suggested date: [YYYY-MM-DD] (if applicable)
- Suggested topics from parking lot

---

*Minutes compiled by Meeting Facilitator*
```

### 2. Log Minutes
- [ ] Write minutes to `.agentcrew/log/meeting/<topic-slug>/<timestamp>.md`
- [ ] Create directory structure: `.agentcrew/log/meeting/<topic-slug>/`

### 3. Update State
- [ ] Update `.agentcrew/state/workflow.json` with:
  ```json
  {
    "meeting": {
      "topic": "...",
      "date": "...",
      "attendees": ["..."],
      "decisions": ["..."],
      "actionItems": ["..."],
      "minutesPath": "..."
    }
  }
  ```

### 4. Summary for User
Present a concise summary:
```
## Meeting Complete: [Topic]

### Decisions
- [Decision 1]
- [Decision 2]

### Action Items
- [Role] -> [Task] by [Deadline]
- [Role] -> [Task] by [Deadline]

### Minutes
Logged to: .agentcrew/log/meeting/<topic>/<timestamp>.md
```

## Done
- Full minutes compiled from all meeting artifacts
- Minutes archived to log directory
- State updated with meeting outcomes
- Summary presented to user
