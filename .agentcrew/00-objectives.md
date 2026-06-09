# Objective-Based SDLC â€” Router

## Shift

This replaces `00-router.md` step-routing with **objective-based routing**.
Instead of "what step are we on?", ask **"what objective are we achieving?"**

## Core Model

```
Request â†’ Objective(s) â†’ Squad(s) â†’ Artifacts â†’ Done
```

## Invocation Modes

| Mode | Pattern | When |
|------|---------|------|
| **Solo** | "[Role], do [task]" | Single role, self-contained |
| **Squad** | "Squad ([roles]), achieve [objective]" | Multiple roles, one objective |
| **Orchestrate** | "Build this [feature/system]" | Multiple objectives, full lifecycle |

## Architecture

Each objective is a **self-contained unit** with:
- **Goal**: Success criteria
- **Squad**: Required roles
- **Schedule**: Parallel or sequential dependencies
- **Artifacts**: What each role produces
- **Assembly**: How artifacts combine into objective output
- **Acceptance**: How to verify done
- **References**: Links to step guides (old step files) that roles use as procedure

### Solo Mode
No orchestration needed. Role executes autonomously.
```
User â†’ "[Role], do [task]" â†’ Role invokes contract â†’ Artifact produced
```

### Squad Mode
Roles within one objective work in parallel where possible, sequential where needed.
```
User â†’ "[Objective]" â†’ Squad â†’ Parallel work â†’ Assembly â†’ Acceptance
```

### Orchestrate Mode
Orchestrator breaks request into multiple objectives, assigns squads, tracks progress.
```
User â†’ "Build this product" â†’ Orchestrator â†’ [Obj1, Obj2, ...] â†’ Squads â†’ Coordination â†’ Done
```

## Request â†’ Objective

| You Say | Objective | Squad | Default Mode |
|---------|-----------|-------|-------------|
| "Build this feature" / "Full SDLC" | Orchestrator routes: O1â†’O2â†’...â†’O6 | All roles | Orchestrate |
| "Define requirements" / "Write PRD" | Clarify Vision | PM, BA | Squad |
| "Design the system" / "Architecture" | Design Solution | Architect, UX, Security | Squad |
| "Plan the sprint" / "Break down work" | Plan Work | EM, PM, Tech Lead | Squad |
| "Implement X" / "Write code for X" | Build Feature | Dev(s), Tech Lead, Mobile Dev | Solo/Squad |
| "Build a mobile app" / "iOS/Android feature" | Build Feature | Mobile Dev, Backend | Solo/Squad |
| "Build data pipeline" / "ETL" | Build Feature | Data Engineer | Solo |
| "Train a model" / "ML pipeline" | Build Feature | ML Engineer, Data Engineer | Solo/Squad |
| "Test this" / "QA sign-off" / "Security audit" | Verify Quality | QA, Security, Dev(s), ML Engineer | Squad |
| "Deploy to prod" / "Release" | Ship Release | DevOps, PM | Solo/Squad |
| "Set up monitoring" / "Hotfix" / "Feedback" | Operate & Learn | DevOps, EM, PM | Solo/Squad |
| "Model monitoring" / "Data quality alert" | Operate & Learn | ML Engineer, Data Engineer | Solo |
| Single role call: "[Role], do X" | â†’ Load role's contract.md directly | That role only | Solo |
| No match? | â†’ Ask "Which objective are we pursuing?" | â€” | â€” |

## Objectives Index

| # | ID | File | Squad | Default Mode |
|---|----|------|-------|-------------|
| 1 | obj/clarify-vision | objectives/01-clarify-vision.md | PM, BA | Squad |
| 2 | obj/design-solution | objectives/02-design-solution.md | Architect, UX, Security, Data Engineer | Squad |
| 3 | obj/plan-work | objectives/03-plan-work.md | EM, PM, Tech Lead | Squad |
| 4 | obj/build-feature | objectives/04-build-feature.md | Dev(s), Mobile Dev, Data Engineer, ML Engineer, Tech Lead | Squad |
| 5 | obj/verify-quality | objectives/05-verify-quality.md | QA, Security, Dev(s), ML Engineer | Squad |
| 6 | obj/ship-release | objectives/06-ship-release.md | DevOps, PM | Squad |
| 7 | obj/operate-learn | objectives/07-operate-learn.md | DevOps, EM, PM, ML Engineer, Data Engineer | Solo/Squad |

## Phase â†’ Objective Mapping

Old step files become **procedure references** for roles:

| Phase (Old) | Maps To (New) | Used By |
|-------------|---------------|---------|
| procedures/01-requirements/ | Clarify Vision | PM, BA |
| procedures/02-design/ | Design Solution | Architect, UX, Security |
| procedures/03-development/ | Plan Work + Build Feature | EM, Tech Lead, Dev(s) |
| procedures/04-qa/ | Verify Quality | QA, Security |
| procedures/05-deployment/ | Ship Release | DevOps, PM |
| procedures/06-maintenance/ | Operate & Learn | DevOps, EM, PM |
| debate/ | Cross-cutting (any objective) | Facilitator, Panelists |

## Security Gates

Unchanged. Same gates (SG1-SG4) apply at objective boundaries.

| Gate | Before | In Objective | Must Pass |
|------|--------|-------------|-----------|
| SG1 | Design review | Design Solution | Threat model complete, high threats mitigated |
| SG2 | Merge to main | Build Feature | SAST + secret scan + dependency scan clean |
| SG3 | QA sign-off | Verify Quality | DAST + pentest + supply chain scan — no Critical/High |
| SG4 | Production deploy | Ship Release | All scans clean, no Critical/High bugs, SBOM verified |

## Debate Integration

Debate remains cross-cutting. Activated at decision points within any objective.

| In Objective | Typical Debate | Panel |
|-------------|----------------|-------|
| Clarify Vision | Scope trade-off, priority | PM, BA, Architect |
| Design Solution | Tech stack, architecture fork | Architect, Backend, Frontend, Security |
| Plan Work | Sprint scope, capacity | EM, PM, Tech Lead |
| Build Feature | Implementation approach, library | Tech Lead, Dev, QA |
| Verify Quality | Test strategy, automation | QA, Dev, DevOps |
| Ship Release | Rollout strategy, rollback | DevOps, PM, Tech Lead |
| Operate & Learn | Refactor vs rewrite, tooling | Tech Lead, Architect, DevOps |

## State Tracking

State file format: `.agentcrew/state/workflow.json`

Objectives track:
- `achievedObjectives`: List of completed objectives with timestamps
- `currentObjective`: Active objective
- `artifacts`: Map of produced artifacts per objective
- `phaseGates`: Security gate status (unchanged)

## Logging

Each role action within an objective logs to `.agentcrew/log/`.
Format: `.agentcrew/log/<objective-id>/<role>/<timestamp>.md`
