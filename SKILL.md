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
1. Check `.crewmarkdown/00-objectives.md` exists
2. Yes → use this skill. No → skip.

## Routing
1. Read `00-objectives.md` → match request to objective
2. Read objective file → goal, squad, artifacts, acceptance
3. Read `00-team.md` → invocation mode (solo/squad/orchestrate)
4. Load each role's `contract.md` + `workflow.md`
5. Load procedure files if needed
6. Read `custom/<phase>.md` → apply overrides
7. Execute: roles produce artifacts
8. Log: `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/<role>.md` (derive `<chat-slug>` from request text — kebab-case, max 5 words)
9. State: update `.crewmarkdown/state/workflow.json`
10. Verify acceptance criteria

## Invocation Modes
| Mode | Pattern | When |
|------|---------|------|
| Solo | "[Role], do [task]" | Single role, self-contained |
| Squad | "Squad ([roles]), achieve [objective]" | Multiple roles, one objective |
| Orchestrate | "Build this [feature/system]" | Full lifecycle, multiple objectives |
