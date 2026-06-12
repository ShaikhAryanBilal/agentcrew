# Changelog — CrewMarkdown

> Day-by-day progress of the CrewMarkdown project.

---

## Day 5 — 2026-06-12

### Added
- **Tactical Mode** (`/tactical`) — continuous always-on thread mode that stays active for the entire conversation, dynamically dispatching roles per request with persistent context
- **Tactical Commander role** (`roles/tactical-commander/`) — owns the tactical thread: activate, dispatch, track, decide, summarize with full contract + workflow
- **5 tactical procedures** (`tactical/01-activate.md` through `05-summarize.md`) — thread state init, role dispatch, action tracking, decision logging, tactical summary generation
- **43rd role** in all docs and config — Tactical Commander added to routing table, role registry, and execution modes

### Changed
- `README.md` — header, execution modes, role count, roles table, project structure, variants updated for tactical mode
- `docs/index.html` — hero badge, stats (43 roles, 12 objectives), execution modes, invocation modes, project structure updated
- `docs/objectives.html` — Mermaid diagram (+M9), routing table, subtitle updated
- `docs/features.html` — tactical mode card and full section added
- `docs/roles.html` — title/subtitle (42→43), Tactical Commander role card added
- `CHANGELOG.md` — this entry

---

## Day 4 — 2026-06-11

### Added
- **Semantic matching** — `synonyms:` field in all 22 routing entries (`00-objectives.md`), enabling synonym-based (not just keyword) request→objective matching
- **Confidence scoring** — each routing entry now has `confidence:` level (high/medium/low) guiding agent when to route silently vs. ask user
- **Routing Strategy** documentation (5-tier match priority: exact → synonym → partial → fuzzy → none)
- **Routing Cache** (`state/routing-cache.json`) — stores last 50 request→objective mappings; agent checks cache before scanning routing table
- **Feedback Loop** (`state/reroute-feedback.json`) — logs user corrections so routing improves over time
- **`/reroute` command** (`00-team.md`) — abandon current objective, load correct one, log correction to cache + feedback

### Changed
- `00-objectives.md` — routing table: every entry got `synonyms:` + `confidence:`; body: added full Routing Strategy section covering semantic match, confidence scoring, cache, feedback loop, `/reroute`
- `00-team.md` — added invocation pattern #5 for `/reroute`

### Infrastructure
- `state/routing-cache.json` seeded with session routing decisions
- `state/reroute-feedback.json` created with schema (empty, ready for corrections)

---

## Day 3 — 2026-06-10

### Added
- **SDLC Model Selection system** (`config/sdlc-models.md`) — 8 models (Waterfall, V-Model, Spiral, Agile, Iterative, Incremental, Big Bang, RAD) with selection criteria, phase maps, gates, risk patterns
- **16 new business & specialist roles**: Marketing, Sales, HR, Finance, General Management, SEO Specialist, UX Researcher, Data Scientist, Growth Marketing, Customer Success, SRE, Legal, BizDev, Solutions Architect, Content Strategist
- **New objectives**: `obj/select-sdlc` (optional model selection), `09-execute-campaign.md`, `10-people-ops.md`
- **Routing** for campaigns, people ops, SDLC selection in `00-objectives.md`
- **New scripts**: adr-gen, changelog-gen, ci-gen, health-check, issue-sync, markdown-lint, release-prep, scaffold-init, state-diff, step-integrity, template-check, validate-contracts, xref-validator (PS1 + SH)
- **New config**: `CrewMarkdown.ps1`, `tone.json`, `humor-data.ps1`
- CrewMarkdown step index script (`.crewmarkdown/CrewMarkdown.ps1`) with humor/please/yell modes

### Changed
- Log path restructured: `.crewmarkdown/log/` → `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>/<role>.md`
- Orchestrator contract & workflow overhaul — multi-objective coordination, phase gate tracking
- Squad expanded for Plan Work (Finance, HR, Management) and Build Feature (Marketing, Sales)
- All 18 existing role workflows updated for consistency
- `validate-workflow.ps1` greatly enhanced (140 lines, comprehensive checks)
- `write-workflow-log.ps1` / `.sh` updated for new log path
- `show-party.ps1` enhanced with more animation patterns
- `opencode.jsonc` CrewMarkdown command updated
- AGENTS.md, SKILL.md, README.md updated to reflect 33 roles

### Infrastructure
- `.gitignore` updated for new script artifacts
- All config files standardized (claude.MD, copilot.instructions, cursor.rules, opencode configs)

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
- Initial CrewMarkdown setup: 16 AI roles with contracts, workflows, and procedures
- Objective-based workflow routing (7 objectives)
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
