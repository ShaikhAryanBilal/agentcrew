# Meeting: Stabilize the Current Product

- **Date**: 2026-06-10
- **Topic**: How can we stabilize the current product?
- **Facilitator**: Meeting Facilitator
- **Attendees**: PM, Architect, QA, DevOps, EM, Backend Dev
- **Timebox**: 30 min (actual: ~25 min)

## Agenda Executed
1. Opening context — stability pain points (2 min)
2. Brainstorming — 6 roles contributed in parallel (15 min)
3. Discussion & Decisions — 5 decisions recorded (5 min)
4. Action items — 7 items assigned (3 min)
5. Close

## Brainstorm Summary

### PM Lens
- Mine support signals (Zendesk, GitHub issues) for stability keywords
- Define SLIs: p99 latency, error rate < 0.1%, crash-free rate > 99.5%, bug reopen rate < 5%
- Use WSJF to prioritize stability vs features
- 30% stability carve-out per sprint OR hardening sprint every 3rd sprint
- Freeze new surfaces, stabilize core "red routes" first, deprecate low-use features

### Architect Lens
- `.crewmarkdown/roles/` and `objectives/` paths exist but are empty — router points to NULL
- Dual routing system: `00-router.md` (deprecated) + `00-objectives.md` = split-brain SPOF
- Zero state persistence — `state/` and `log/` dirs absent, no recovery on session drop
- Missing `codebase-map.md` — agents navigate blind
- No quality gates on framework changes — tech debt compounding

### QA Lens
- Zero test coverage on framework scripts (PowerShell/Shell)
- No regression safety net — CI validates file existence only, never behavior
- Bug tracking defined but unused — zero defect data
- PS1 vs Sh script drift — platform parity gap untested
- No flaky test management in CI

### DevOps Lens
- CI/CD pipeline absent — no GitHub Actions, no Docker, no automation
- Zero monitoring/alerting — no dashboards, no error budgets, no SLOs
- No rollback automation — MTTR depends on human reaction time
- Config drift risk — no schema validation on YAML frontmatter
- Infra not codified — GitHub Pages deployment is tribal knowledge

### EM Lens
- Capacity unknown — no sprint velocity, no baseline
- No tech debt allocation — stability competes with features
- No requirements gate — stories enter without acceptance criteria sign-off
- WIP limits = zero — unlimited pick per dev
- Monitoring/alerting not scoped — shipping blind

### Backend Dev Lens
- `workflow.json` writes have no concurrency guard — parallel writes corrupt
- `-ErrorAction SilentlyContinue` in scripts silently swallows errors → incomplete artifacts
- Hardcoded `.team` paths instead of `.crewmarkdown` — breaks on fresh clones
- No state schema versioning — schema changes break old state files
- Cross-platform script divergence — `.ps1` and `.sh` versions independent

## Decisions

| # | Decision | Rationale | Consensus |
|---|----------|-----------|-----------|
| D1 | Define SLIs before fixing: p99 latency, error rate, crash-free rate, bug reopen rate | Without targets, "stable" is subjective | Unanimous |
| D2 | Delete `00-router.md`, populate role/objective stubs, create `state/` + `log/`, generate `codebase-map.md` | Framework itself is unstable — routing is split-brain, half the tree is hollow | Unanimous |
| D3 | Add GitHub Actions CI: schema validation → script lint → behavioral tests → markdown link check | Current CI validates structure only, never behavior | Unanimous |
| D4 | Enforce: 30% stability carve-out, WIP limit (2/dev, 1/review), requirements gate | Without capacity, stability work loses to features | Unanimous |
| D5 | Concurrency guard on state writes, replace SilentlyContinue, fix `.team` paths, add version field to state schema | 4 script bugs found — each corrupts state or crashes workflow | Unanimous |

## Action Items

| # | Task | Owner | Deliverable | Deadline |
|---|------|-------|-------------|----------|
| AI-1 | Define SLIs + stability dashboard spec | PM | Markdown doc with SLI targets, measurement method | This sprint |
| AI-2 | Delete `00-router.md`, populate role/objective stubs, create `state/` + `log/`, generate `codebase-map.md` | Architect | PR with cleanup + stubs + generated map | This sprint |
| AI-3 | Add GitHub Actions CI with schema validation, script lint, state script tests | DevOps | PR with `.github/workflows/ci.yml` | This sprint |
| AI-4 | Enforce 30% stability carve-out, WIP limits, requirements gate in sprint process | EM | Updated sprint workflow doc + board config | Next sprint |
| AI-5 | Fix script bugs: concurrency guard, error handling, `.team` paths, state schema versioning | Backend | PR with fixes to affected `.ps1` files | This sprint |
| AI-6 | Bug tracking enforcement — every objective execution must write bug log | QA | PR adding bug log write step to objective workflow templates | This sprint |
| AI-7 | Evaluate monitoring tooling (UptimeRobot / Grafana Cloud) for Pages + framework uptime | DevOps | Recommendation doc comparing 2-3 options | Next sprint |

## Parking Lot
- Debate sub-workflow integration — deferred until framework stubs exist
- Mobile/ML-specific stability concerns — not relevant to current product
