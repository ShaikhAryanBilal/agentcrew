# AgentCrew — Crew Orchestration Hub

## Overview

AgentCrew is a full software development crew of 16 AI roles, each invocable solo or in squads toward shared objectives.
Each role is self-contained with a contract (inputs/outputs) and workflow (process).

## Role Roster

| Role | Contract | Workflow | Specialty |
|------|----------|----------|-----------|
| Product Manager | roles/product-manager/contract.md | roles/product-manager/workflow.md | Requirements, priorities, sign-off |
| Business Analyst | roles/ba/contract.md | roles/ba/workflow.md | Requirements analysis, user stories |
| Solution Architect | roles/architect/contract.md | roles/architect/workflow.md | Architecture, tech stack |
| Tech Lead | roles/tech-lead/contract.md | roles/tech-lead/workflow.md | Standards, code quality, ADRs |
| Frontend Developer | roles/frontend/contract.md | roles/frontend/workflow.md | UI, client logic |
| Backend Developer | roles/backend/contract.md | roles/backend/workflow.md | API, data, services |
| Mobile Developer | roles/mobile-dev/contract.md | roles/mobile-dev/workflow.md | iOS/Android, offline, push |
| UX Designer | roles/ux-designer/contract.md | roles/ux-designer/workflow.md | Research, wireframes, visual |
| Data Engineer | roles/data-engineer/contract.md | roles/data-engineer/workflow.md | ETL/ELT, data warehouse, pipelines |
| ML Engineer | roles/ml-engineer/contract.md | roles/ml-engineer/workflow.md | Models, training, serving, drift |
| QA Engineer | roles/qa/contract.md | roles/qa/workflow.md | Testing, quality, sign-off |
| Security Engineer | roles/security/contract.md | roles/security/workflow.md | Threat model, pentest, SBOM |
| DevOps Engineer | roles/devops/contract.md | roles/devops/workflow.md | Infrastructure, CI/CD |
| Engineering Manager | roles/engineering-manager/contract.md | roles/engineering-manager/workflow.md | Sprint planning, capacity, retro |
| Debate Facilitator | roles/debator/contract.md | roles/debator/workflow.md | Neutral debate moderator |
| Orchestrator | roles/orchestrator/contract.md | roles/orchestrator/workflow.md | Multi-objective coordinator |

## Invocation Patterns

### 1. Solo Invocation

Invoke a single role for a specific task.

```
Syntax: "[Role], do [task] for [context]"
```

Examples:
- "Architect, design the database schema for the payment system"
- "PM, write the PRD for user authentication"
- "Backend Dev, implement the order API"
- "QA, create test cases for the checkout flow"
- "Security, review the threat model for the portal"
- "UX Designer, create wireframes for the dashboard"
- "DevOps, set up the CI/CD pipeline for this project"
- "EM, plan the sprint for these features"
- "Debate Facilitator, run a debate on tech stack"

**Effect:**
1. Load role's contract.md â†’ identify inputs needed and outputs expected
2. Load role's workflow.md â†’ know execution process
3. Load relevant objective file (if applicable) â†’ know goal + acceptance
4. Load relevant step files as procedure reference
5. Role executes, produces artifact
6. Log to `.agentcrew/log/<objective-id>/<role>/<timestamp>.md`
7. Update `.agentcrew/state/workflow.json` with completed artifact

### 2. Squad Invocation

Invoke multiple roles to achieve an objective together.

```
Syntax: "Squad ([roles]), achieve [objective]"
```

Examples:
- "Squad (PM, BA), clarify the vision for the reporting module"
- "Squad (Architect, UX, Security), design the solution for the customer portal"
- "Squad (Frontend, Backend), build the user profile feature"
- "Squad (QA, Security), verify quality of release v2.1"
- "Squad (DevOps, PM), ship the release to production"

**Effect:**
1. Load objective file â†’ know goal, squad, schedule, artifacts, acceptance
2. Each role loads their contract + workflow
3. Roles work **in parallel** where dependency graph allows
4. Roles work **in sequence** where dependencies exist
5. Assembly of artifacts into combined objective output
6. Verify acceptance criteria
7. Log each role's actions + objective completion
8. Update state

**Parallel vs Sequential within Objective:**

```
Parallel:     Role A â”€â”€> Artifact A
              Role B â”€â”€> Artifact B
              Role C â”€â”€> Artifact C
              Assembly: A + B + C â†’ Objective Output

Sequential:   Role A â”€â”€> Artifact A â”€â”€> Role B â”€â”€> Artifact B
```

Objective files define which paths are parallel vs sequential.

### 3. Orchestrated Invocation

Full lifecycle management. The Orchestrator role coordinates multiple objectives.

```
Syntax: "Build [feature]" / "Full SDLC for [project]" / "Develop [system]"
```

Examples:
- "Build the e-commerce platform from scratch"
- "Full SDLC for the reporting dashboard"
- "Develop the user authentication module"

**Effect:**
1. Orchestrator role loaded (roles/orchestrator/)
2. Orchestrator decomposes user request into objectives
3. Dependency order determined between objectives
4. For each objective: assign squad, set schedule, track progress
5. Squads execute per Squad pattern
6. Orchestrator monitors progress, resolves cross-objective conflicts
7. Orchestrator reports status to user
8. Final verification of all objectives complete
9. Log + update state

## Orchestrator Decision Flow

```
User Request
    â†“
Orchestrator: Parse â†’ "How many objectives does this need?"
    â†“
   [Single objective?] â†’ Assign squad directly â†’ Done (skip orchestration)
    â†“
   [Multiple objectives?] â†’ Map to objectives â†’ Order by dependencies
    â†“
   For each objective:
     â†’ Assign squad
     â†’ Set acceptance criteria
     â†’ Track progress
     â†’ Resolve blockers (use debate if needed)
    â†“
   All objectives achieved â†’ Report to user
```

## Role Independence Principle

Every role can be invoked **without** the orchestrator. The orchestrator is only needed when:
- The request spans multiple objectives
- Cross-objective dependencies need management
- The user explicitly asks for full lifecycle management

This means:
- "Architect, design the DB" works with or without orchestration
- "QA, run tests on build 42" works standalone
- "Build the whole app" uses orchestrator to coordinate all roles

## State & Logging

- **State**: `.agentcrew/state/workflow.json` tracks achieved objectives + artifacts
- **Logs**: `.agentcrew/log/<objective-id>/<role>/<timestamp>.md`
- **Debate logs**: `.agentcrew/log/debate/<decision-slug>.md`
