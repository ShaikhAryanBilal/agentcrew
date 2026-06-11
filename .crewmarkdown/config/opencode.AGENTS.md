# CrewMarkdown — Universal Agent Entry Point

## What This Is

CrewMarkdown is a **crew of 18 autonomous AI roles** — each with a contract and workflow.
Roles work solo or in squads toward shared objectives. Full lifecycle.

## For opencode

Auto-detected via `~/.agents/skills/CrewMarkdown/SKILL.md`.
Trigger phrases: "CrewMarkdown", "workflow", "follow the process", `/CrewMarkdown`.

## For Cursor / Claude Code / Cline / Copilot / Other AI Tools

Read `.crewmarkdown/00-objectives.md` — it contains the master objective routing table.
Read `.crewmarkdown/00-team.md` for role invocation patterns.
Role contracts are in `.crewmarkdown/roles/<role>/contract.md`.

## How Any AI Agent Should Behave

1. User makes a request about software
2. **Codebase Map:** If `codebase-map.md` exists at root, read it first
3. **Custom Instructions:** Check `.crewmarkdown/custom/<phase>.md` for project-specific overrides
4. Consult `.crewmarkdown/00-objectives.md` → find matching objective
5. Read objective file → know goal, squad, artifacts, acceptance
6. Read `.crewmarkdown/00-team.md` → determine invocation mode (solo/squad/orchestrate)
7. Load relevant role contract.md + workflow.md
8. Load old step files as procedure references (if needed)
9. Roles produce artifacts
10. **Log:** Write `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/<role>.md` (derive `<chat-slug>` from request text)
11. **State:** Update `.crewmarkdown/state/workflow.json` (achieved objectives, artifacts)
12. Verify acceptance criteria

**Core rule:** every request maps to an objective (or solo role call). No match = ask "Which objective are we pursuing?"

## Quick Reference

| Request | Start Here |
|---------|-----------|
| "Who does what?" / "Hiring" / "Role definition" | `.crewmarkdown/00-roles.md` |
| "Build a feature" / "Full lifecycle" | `.crewmarkdown/00-objectives.md` (orchestrate) |
| "Define requirements" / "Write PRD" | Objective: Clarify Vision (`.crewmarkdown/objectives/01-clarify-vision.md`) |
| "Design the system" / "Architecture" | Objective: Design Solution (`.crewmarkdown/objectives/02-design-solution.md`) |
| "Plan sprint" / "Break down work" | Objective: Plan Work (`.crewmarkdown/objectives/03-plan-work.md`) |
| "Implement X" / "Write code" | Objective: Build Feature (`.crewmarkdown/objectives/04-build-feature.md`) |
| "Test this" / "QA sign-off" | Objective: Verify Quality (`.crewmarkdown/objectives/05-verify-quality.md`) |
| "Deploy to prod" / "Release" | Objective: Ship Release (`.crewmarkdown/objectives/06-ship-release.md`) |
| "Set up monitoring" / "Hotfix" | Objective: Operate & Learn (`.crewmarkdown/objectives/07-operate-learn.md`) |
| "Review this code" | `.crewmarkdown/roles/architect/workflow.md` (Tech Lead hat) |
| "Bug found" | `.crewmarkdown/roles/qa/workflow.md` + `.crewmarkdown/procedures/04-qa/06-bug-tracking.md` |
| Solo role: "[Role], do X" | `.crewmarkdown/roles/<role>/contract.md` + `.crewmarkdown/roles/<role>/workflow.md` |
| Everything else | `.crewmarkdown/00-objectives.md` routing table |

## Gamified Display

Show the Retro RPG party screen when starting work on an objective or assembling a squad.
This provides visual feedback that the AI team is working.

**PowerShell (Windows):**
```
.\.crewmarkdown\animations\show-party.ps1 -Objective "Objective Name" -Squad PM,Architect,Backend -Timeout 5
```

**Bash (Linux/macOS):**
```
.crewmarkdown/animations/show-party.sh -o "Objective Name" -s "PM,Architect,Backend" -t 5
```

**Flags:**
- `-Timeout` / `-t`: seconds to display (0 = infinite, Ctrl+C to exit)
- `-NoAnim` / `-n`: static screen, no animation
- `-Ascii` / `-a`: ASCII-only mode (no emoji)

Call this script before starting objective execution. Use 5-second timeout for quick feedback,
or omit timeout during long-running work.
