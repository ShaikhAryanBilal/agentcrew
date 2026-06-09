# Orchestrator Workflow

## Trigger
User request spans multiple objectives (e.g., "build this feature", "full SDLC", "develop from scratch")

## Process

### Step 1: Decompose Request
Input: User request
Action:
- Parse request into logical components
- Map each component to an objective from `00-objectives.md` routing table
- If request maps to a single objective â†’ skip orchestration, assign directly
- If request maps to multiple objectives â†’ continue

### Step 2: Order Objectives
Input: Objective list
Action:
- Determine dependency order
- Identify which objectives can run in parallel
- Create schedule

```
Example dependency order:
  1. Clarify Vision (blocks everything)
  2. Design Solution (blocks Build, Verify, Ship)
  3. Plan Work (can run parallel with Design Solution)
  4. Build Feature (blocks Verify, Ship)
  5. Verify Quality (blocks Ship)
  6. Ship Release (final)
  7. Operate & Learn (post-release, continuous)
```

### Step 3: Assign Squads
Input: Ordered objectives, role roster
Action:
- For each objective, assemble squad per objective's squad definition
- Load each role's contract.md â†’ verify they have what they need
- Communicate assignments + expected artifacts

### Step 4: Execute & Monitor
Input: Active squads
Action:
- Launch squads per schedule
- Track progress: not started â†’ in progress â†’ artifact produced â†’ verified
- Watch for blockers, cross-objective conflicts
- Blockers: unblock or re-prioritize
- Conflicts: trigger debate

### Step 5: Verify & Assemble
Input: Completed artifacts from all squads
Action:
- Verify each objective's acceptance criteria met
- Assemble artifacts into coherent whole
- Run security gates at objective boundaries (SG1-SG4)

### Step 6: Report
Input: Completion status
Action:
- Report to user: objectives achieved, artifacts produced, any open items
- Update state: `.agentcrew/state/workflow.json`
- Log orchestration record: `.agentcrew/log/orchestrator/<timestamp>.md`

## Done When
- All objectives achieved and acceptance criteria met
- All artifacts logged
- State updated
- Final report delivered to user

## Outcome Options
| Outcome | Meaning | Next |
|---------|---------|------|
| All objectives achieved | Full lifecycle complete | Operate & Learn (ongoing) |
| Partial completion | Some objectives done, remaining deferred | User decides next |
| Blocked | Dependency missing or conflict unresolved | Escalate to user |

## Quality Checklist
- [ ] Each objective has clear, verifiable acceptance criteria
- [ ] Squad composition matches objective needs (no missing roles)
- [ ] Dependencies between objectives explicitly mapped before execution starts
- [ ] State updated after every objective completion
- [ ] Security gates verified at every objective boundary (SG1-SG4)
- [ ] Risks documented in risk register, not just tracked mentally
- [ ] Final report delivered to user with artifacts list and any open items
