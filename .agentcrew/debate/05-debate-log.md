# Debate Log â€” Archive + Feed Decision Back

## Need
- Decision record from resolution step
- Full debate transcript
- Scoring matrix

## Do

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
|------|----------|---------------|--------------|--------|
| ... | ... | Option N | Option N | No/Yes |

### Transcript Summary
[Key exchanges from each round]

### Scoring Matrix
[Table]

### Decision
- Winner: Option N
- Runner-up: Option N (score diff: X%)
- Method: Consensus / Criteria / Tiebreaker

### Action Items
- [ ] [item]

### Retrospective (filled after parent step completes)
- Was the decision correct? Yes/No/Too early
- What would we debate differently?
```

### 2. Feed Decision to Parent Workflow

- [ ] Decision output documented in workflow state
- [ ] Parent step resumes with the winning option
- [ ] Losing options archived with rationale (not deleted)

### 3. Update Workflow State

Update `.agentcrew/state/workflow.json`:

```json
{
  "debates": [
    {
      "id": "deb-001",
      "question": "REST vs GraphQL for invoice export API",
      "winner": "REST",
      "date": "2026-06-08",
      "parentStep": "design/arch",
      "method": "criteria-scoring",
      "scoreDiff": "3.2%",
      "archivePath": ".agentcrew/log/debate/2026/06/08/rest-vs-graphql.md"
    }
  ]
}
```

### 4. Decision Communication

- [ ] Winning decision broadcast to: all panelists + affected teams
- [ ] Rationale summary (3 bullets) shared â€” not just the decision
- [ ] If decision has cost/timeline impact â†’ PM notified

## Done
- Debate artifacts archived
- Decision fed back to parent workflow step
- Workflow state updated with debate record
- Affected stakeholders notified

## Next â†’ Return to parent workflow step
Parent step continues with the winning option as the chosen path forward.
