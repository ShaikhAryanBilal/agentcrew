---
name: sdlc
description: >
  AgentCrew — objective-based SDLC crew with 18 invocable AI roles.
  Every request routes through `.agentcrew/00-objectives.md`. Roles work solo, squad,
  or orchestrated. Each has contract + workflow + skills + templates.
  Also triggered by: "SDLC", "workflow", "follow the process", /sdlc.
---

# AgentCrew Skill

## Detection

1. Check if `.agentcrew/00-objectives.md` exists in project root
2. If yes → use this skill. If no → skip (not an SDLC-managed project).

## Before Routing

1. **Codebase Map** — If `codebase-map.md` exists at project root, read it first.
2. **Custom Instructions** — Before each objective, check `.agentcrew/custom/<phase>.md`.

## Routing (all requests)

1. Read `.agentcrew/00-objectives.md` → consult routing table → pick objective
2. Read objective file → know goal, squad, artifacts, acceptance
3. Load `.agentcrew/00-team.md` for invocation pattern (solo/squad/orchestrate)
4. Load each role's contract.md + workflow.md from `.agentcrew/roles/<role>/`
5. Load relevant old step files (from `.agentcrew/<phase>/`) as procedure references
6. Read `.agentcrew/custom/<phase>.md` → apply custom overrides
7. Execute: roles produce artifacts per objective
8. **Log:** Write `.agentcrew/log/<objective-id>/<role>/<timestamp>.md`
9. **State:** Update `.agentcrew/state/workflow.json` with achieved objectives
10. Verify acceptance criteria

## State Tracking

- Track objective completion in `.agentcrew/state/workflow.json`
- Log per-role artifacts per objective
- On revert: re-execute the failed objective with same or adjusted squad

## Invocation Modes

| Mode | Pattern | When |
|------|---------|------|
| Solo | "[Role], do [task]" | Single role, self-contained task |
| Squad | "Squad ([roles]), achieve [objective]" | Multiple roles, one objective |
| Orchestrate | "Build this [feature/system]" | Multiple objectives, full lifecycle |

## Objectives

```
Clarify Vision → Design Solution → Plan Work → Build Feature → Verify Quality → Ship Release → Operate & Learn
```

Each objective has a goal, squad, schedule, artifacts, and acceptance criteria.
Old step files serve as procedure guides for roles.
