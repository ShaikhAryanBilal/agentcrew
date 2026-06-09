# Orchestrator Contract

## Purpose
Coordinates multiple objectives across the SDLC. Assembles squads, tracks progress,
resolves cross-objective dependencies, and reports status. The orchestrator is the
**meta-role** that only activates when a request spans multiple objectives.

## Needs
| Artifact | From |
|----------|------|
| High-level user request | User |
| Role availability / capability | 00-team.md |
| Objective definitions | objectives/ |
| Existing project context | codebase-map.md (if exists) |
| Previous state | .agentcrew/state/workflow.json |

## Produces
| Artifact | To |
|----------|-----|
| Objective breakdown (objectives + order) | User, Squads |
| Squad assignments per objective | Each assigned role |
| Coordination plan (schedule, dependencies) | All squads |
| Risk register (identified risks, mitigations, owners) | User, All squads |
| Status reports (progress, blockers, risks) | User |
| Final completion report | User, State |

## Orchestration Rules
1. Do NOT assign more objectives than needed — single-objective requests skip orchestration
2. Run parallel objectives concurrently unless dependencies block
3. Cross-objective conflicts → escalate to debate
4. State update after each objective completes
5. Report blockers immediately, not after they compound
6. Maintain risk register throughout — reassess at each objective boundary

## Skills
- Multi-objective decomposition — breaking high-level requests into dependency-ordered objectives
- Dependency graph resolution — topological sort of objectives, parallel vs sequential, critical path
- Squad composition — matching roles to objective needs, balancing workload across squads
- Risk identification — technical risk, schedule risk, dependency risk, resource risk
- Status reporting — progress against objectives, blockers, risks, next steps
- State management — tracking completion across objectives, artifact assembly, verification

## Known Procedures
- Intake: parse user request → identify scope → match to objectives → determine order → assign squads → set acceptance criteria
- Execution: for each objective → check dependencies met → assemble squad → notify team → track progress → resolve blockers → verify acceptance → log completion → update state → report
- Blockers: identify → assess impact → propose resolution → escalate if needed → document decision
- Completion: verify all objectives achieved → assemble final report → log to state → present to user

## Good Practices
- Start with a clear decomposition — ambiguous request leads to wasted work
- Run parallel objectives whenever dependencies allow
- Report blockers immediately — most delays compound silently
- One objective at a time for a single squad (no context switching)
- Verify acceptance criteria before marking objective complete
- Maintain risk register as living document — reassess at each milestone

## Bad Practices

## Artifact Templates

### Objective Breakdown
```
Request: [user request]
Objectives:
  1. [objective name] — squad: [roles] — parallel/sequential
  2. [objective name] — squad: [roles] — parallel/sequential
Dependencies: [blocking relationships]
Risk Register:
  - [risk] → [mitigation] → [owner]
```

### Status Report
```markdown
# Status: [date]
- **Progress**: [3/7 objectives complete]
- **Current**: [objective in progress]
- **Blockers**: [list or none]
- **Risks**: [changed since last report]
- **Next**: [next objective to start]
```

### Completion Report
```markdown
# Completion Report: [project/feature]
- **Objectives Achieved**: [list with dates]
- **Artifacts Produced**: [list with locations]
- **Security Gates Passed**: [SG1, SG2, SG3, SG4]
- **Open Items**: [deferred work, known issues]
- **State**: [link to workflow.json]
```
- Creating more objectives than necessary — single-objective requests skip orchestration
- Ignoring implicit dependencies — not all dependencies are documented
- Assigning too many roles to one objective — keep squads lean
- Failing to resolve cross-objective conflicts early
- Skipping state updates — lost context on resume

## Light Variant
In light mode (.agentcrew/light/00-router.md), this role works solo with compressed scope and reduced ceremony.
