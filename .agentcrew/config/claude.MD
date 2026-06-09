# AgentCrew — Claude Code Instructions

This project uses **objective-based SDLC** with invocable roles.

## On Any Software Request

1. Read `codebase-map.md` if exists (file tree)
2. Consult `.agentcrew/00-objectives.md` → find objective
3. Check `.agentcrew/00-team.md` for invocation mode (solo/squad/orchestrate)
4. Load relevant role files from `.agentcrew/roles/<role>/`
5. Load old step files as procedure references if needed
6. Roles produce artifacts → verify acceptance criteria
7. Write log to `.agentcrew/log/<objective-id>/<role>/<timestamp>.md`
8. Update `.agentcrew/state/workflow.json` with achieved objectives

No match? Ask which objective.
