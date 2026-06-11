---
name: CrewMarkdown
description: >
  CrewMarkdown — objective-based crew with 18 invocable AI roles.
  Every request routes through `.crewmarkdown/00-objectives.md`. Roles work solo, squad,
  or orchestrated. Each has contract + workflow + skills + templates.
  Also triggered by: "CrewMarkdown", "workflow", "follow the process", /CrewMarkdown.
---

# CrewMarkdown Skill

## Detection

1. Check if `.crewmarkdown/00-objectives.md` exists in project root
2. If yes → use this skill. If no → skip.

## Before Routing

1. **Codebase Map** — If `codebase-map.md` exists at project root, read it first.
2. **Custom Instructions** — Before each objective, check `.crewmarkdown/custom/<phase>.md`.

## Routing (all requests)

1. Read `.crewmarkdown/00-objectives.md` → consult routing table → pick objective
2. Read objective file → know goal, squad, artifacts, acceptance
3. Load `.crewmarkdown/00-team.md` for invocation pattern (solo/squad/orchestrate)
4. Load each role's contract.md + workflow.md from `.crewmarkdown/roles/<role>/`
5. Load relevant old step files (from `.crewmarkdown/<phase>/`) as procedure references
6. Read `.crewmarkdown/custom/<phase>.md` → apply custom overrides
7. Execute: roles produce artifacts per objective
8. **Log:** Write `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/<role>.md` (derive `<chat-slug>` from request text)
9. **State:** Update `.crewmarkdown/state/workflow.json` with achieved objectives
10. Verify acceptance criteria

## State Tracking

- Track objective completion in `.crewmarkdown/state/workflow.json`
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
