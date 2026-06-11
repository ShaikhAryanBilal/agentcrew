# Debate Panel — Assemble Roles + Stances

## Need
- Debate brief from trigger step
- Panelist roles assigned
- Decision question + options listed

## Instructions

### 1. Panelist Role Assembly
Each panelist represents a distinct role. Their stance must be grounded in that role's concerns.

| Panelist | Role Perspective | Primary Concern |
|----------|-----------------|-----------------|
| Architect | System integrity | Scalability, maintainability, tech debt |
| Backend Dev | Implementation feasibility | Dev velocity, testing, ops |
| Frontend Dev | UX integration | API ergonomics, perf, DX |
| PM | Business value | Timeline, cost, user impact |
| QA | Quality assurance | Testability, edge cases, reliability |
| Security | Threat posture | Attack surface, compliance, data safety |
| DevOps | Operations | Deployability, monitoring, cost |
| UX Designer | User experience | Usability, accessibility, flow |

### 2. Stance Generation
Each panelist writes their initial stance:

```
## Panelist: [Role Name]
### Chosen Option: [Option #]
### Rationale (3 bullets max):
1. [Primary reason]
2. [Secondary reason tied to role's success criteria]
3. [Risk mitigation]
### Questions for Other Panelists:
- [Question challenging another option's weakness]
```

### 3. Stance Review
- [ ] Every option has at least 1 panelist advocating for it
- [ ] Unrepresented options flagged — facilitator may assign a panelist to argue it
- [ ] Every stance includes concrete rationale (not "I like it")
- [ ] Stances are 5 sentences max — concise, structured

### 4. Facilitator Prep
- [ ] Identify points of agreement (reduce debate time)
- [ ] Identify sharpest disagreement (focus debate there)
- [ ] Prepare clarifying questions for each panelist
- [ ] Confirm timebox per round

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| Panelists argue their personal preference | Argue from role perspective — "As [role], I choose X because..." |
| Skip role assignment | Every panelist needs a clear role hat |
| One panelist dominates | Facilitator enforces equal speaking time |
| Stance is "I agree with X" | Must provide independent reasoning |

## Done
- All panelists have written stances
- Every option has an advocate
- Facilitator has reviewed stances
- Timebox confirmed per round

→ Next: `03-debate-rounds.md`
Unrepresented option? Assign a panelist to argue it before proceeding.
