# CrewMarkdown — Claude Code Instructions

This project uses **objective-based workflow** with invocable roles.

## On Any Software Request

1. Read `codebase-map.md` if exists (file tree)
2. Consult `.crewmarkdown/00-objectives.md` → find objective
3. Check `.crewmarkdown/00-team.md` for invocation mode (solo/squad/orchestrate)
4. Load relevant role files from `.crewmarkdown/roles/<role>/`
5. Load old step files as procedure references if needed
6. Roles produce artifacts → verify acceptance criteria
7. Write log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/<role>.md` (derive `<chat-slug>` from request text)
8. Update `.crewmarkdown/state/workflow.json` with achieved objectives

No match? Ask which objective.
