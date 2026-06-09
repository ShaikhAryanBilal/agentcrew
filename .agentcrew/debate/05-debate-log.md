# Debate Log — Archive + Feed Decision Back

## Need
- Decision record from resolution step
- Full debate transcript
- Scoring matrix

## Instructions

### 1. Archive Debate Artifacts
Save to `.agentcrew/log/debate/<year>/<month>/<day>/<decision-slug>.md`:
```
## Debate Archive
- Decision: [question]
- Slug: [kebab-case-decision-name]
- Date: yyyy-mm-dd
- Phase: [parent SDLC phase]
- Parent Step: [step ID where debate originated]
### Brief
[Copy of debate brief]
### Panel
| Role | Panelist | Initial Stance | Final Stance | Shift? |
### Transcript Summary
[Key exchanges from each round]
### Scoring Matrix
[Table]
### Decision
- Winner: Option N
- Runner-up: Option N
- Method: Consensus / Criteria / Tiebreaker
### Action Items
### Retrospective (filled after parent step completes)
- Was the decision correct? Yes/No/Too early
```

### 2. Feed Decision to Parent Workflow
- [ ] Decision output documented in workflow state
- [ ] Parent step resumes with the winning option
- [ ] Losing options archived with rationale (not deleted)

### 3. Update Workflow State
Update `.agentcrew/state/workflow.json` with debate record.

### 4. Decision Communication
- [ ] Winning decision broadcast to: all panelists + affected teams
- [ ] Rationale summary (3 bullets) shared — not just the decision
- [ ] If decision has cost/timeline impact → PM notified

## Done
- Debate artifacts archived
- Decision fed back to parent workflow step
- Workflow state updated with debate record
- Affected stakeholders notified

→ Next: Return to parent workflow step
Parent step continues with the winning option as the chosen path forward.
