# AgentCrew — Universal Agent Entry Point

## What This Is

AgentCrew is a **crew of 16 autonomous AI roles** — each with a contract and workflow.
Roles work solo or in squads toward shared objectives. Full SDLC lifecycle.

## For opencode

Auto-detected via `~/.agents/skills/sdlc/SKILL.md`.
Trigger phrases: "SDLC", "workflow", "follow the process", `/sdlc`.

## For Cursor / Claude Code / Cline / Copilot / Other AI Tools

Read `.agentcrew/00-objectives.md` — it contains the master objective routing table.
Read `.agentcrew/00-team.md` for role invocation patterns.
Role contracts are in `.agentcrew/roles/<role>/contract.md`.

## How Any AI Agent Should Behave

1. User makes a request about software
2. **Codebase Map:** If `codebase-map.md` exists at root, read it first
3. **Custom Instructions:** Check `.agentcrew/custom/<phase>.md` for project-specific overrides
4. Consult `.agentcrew/00-objectives.md` → find matching objective
5. Read objective file → know goal, squad, artifacts, acceptance
6. Read `.agentcrew/00-team.md` → determine invocation mode (solo/squad/orchestrate)
7. Load relevant role contract.md + workflow.md
8. Load old step files as procedure references (if needed)
9. Roles produce artifacts
10. **Log:** Write `.agentcrew/log/<objective-id>/<role>/<timestamp>.md`
11. **State:** Update `.agentcrew/state/workflow.json` (achieved objectives, artifacts)
12. Verify acceptance criteria

**Core rule:** every request maps to an objective (or solo role call). No match = ask "Which objective are we pursuing?"

## Quick Reference

| Request | Start Here |
|---------|-----------|
| "Who does what?" / "Hiring" / "Role definition" | `.agentcrew/00-roles.md` |
| "Build a feature" / "Full SDLC" | `.agentcrew/00-objectives.md` (orchestrate) |
| "Define requirements" / "Write PRD" | Objective: Clarify Vision (`.agentcrew/objectives/01-clarify-vision.md`) |
| "Design the system" / "Architecture" | Objective: Design Solution (`.agentcrew/objectives/02-design-solution.md`) |
| "Plan sprint" / "Break down work" | Objective: Plan Work (`.agentcrew/objectives/03-plan-work.md`) |
| "Implement X" / "Write code" | Objective: Build Feature (`.agentcrew/objectives/04-build-feature.md`) |
| "Test this" / "QA sign-off" | Objective: Verify Quality (`.agentcrew/objectives/05-verify-quality.md`) |
| "Deploy to prod" / "Release" | Objective: Ship Release (`.agentcrew/objectives/06-ship-release.md`) |
| "Set up monitoring" / "Hotfix" | Objective: Operate & Learn (`.agentcrew/objectives/07-operate-learn.md`) |
| "Review this code" | `.agentcrew/roles/architect/workflow.md` (Tech Lead hat) |
| "Bug found" | `.agentcrew/roles/qa/workflow.md` + `.agentcrew/procedures/04-qa/06-bug-tracking.md` |
| "Meeting mode" / "/meeting [topic]" / "brainstorm [topic]" | `.agentcrew/objectives/08-conduct-meeting.md` (spawns Meeting Facilitator + dynamic roles) |
| "Retro" / "retrospective" | `.agentcrew/objectives/08-conduct-meeting.md` or `.agentcrew/objectives/07-operate-learn.md` |
| Solo role: "[Role], do X" | `.agentcrew/roles/<role>/contract.md` + `.agentcrew/roles/<role>/workflow.md` |
| Everything else | `.agentcrew/00-objectives.md` routing table |

## Gamified Display

Show the Retro RPG party screen when starting work on an objective or assembling a squad.
This provides visual feedback that the AI team is working.

**PowerShell (Windows):**
```
.\.agentcrew\animations\show-party.ps1 -Objective "Objective Name" -Squad PM,Architect,Backend -Timeout 5
```

**Bash (Linux/macOS):**
```
.agentcrew/animations/show-party.sh -o "Objective Name" -s "PM,Architect,Backend" -t 5
```

**Flags:**
- `-Timeout` / `-t`: seconds to display (0 = infinite, Ctrl+C to exit)
- `-NoAnim` / `-n`: static screen, no animation
- `-Ascii` / `-a`: ASCII-only mode (no emoji)

Call this script before starting objective execution. Use 5-second timeout for quick feedback,
or omit timeout during long-running work.
