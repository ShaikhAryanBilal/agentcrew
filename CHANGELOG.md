# Changelog — AgentCrew

> Day-by-day progress of the AgentCrew project.

---

## Day 2 — 2026-06-09

### Added
- **Technical Writer role** (`roles/technical-writer/`) — owns API docs, user guides, release notes, onboarding guides with full contract + workflow
- Routing in `00-objectives.md` for doc requests: `"Write API docs"`, `"Write release notes"`, `"Write user guide"`
- Integrated Technical Writer into **Build Feature** (API docs) and **Ship Release** (release notes) squads
- Updated GitHub Pages site to reflect 17 roles (all HTML pages)

---

## Day 1 — 2026-06-09

### Added
- Initial AgentCrew setup: 16 AI roles with contracts, workflows, and procedures
- Objective-based SDLC routing (7 objectives)
- Retro RPG party screen animation (`show-party.ps1` / `show-party.sh`)
- `AGENTS.md` entry point for AI agents
- GitHub Pages site with sidebar, dark theme, and full role/objective/procedure pages
- `codebase-map.md` for agent context

### Changed
- README overhaul with problem/solution narrative and FIGlet banner

### Infrastructure
- `.gitignore` configuration
- `opencode.jsonc` for opencode integration
- CI/CD workflows
