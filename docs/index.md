# AgentCrew — Autonomous AI Squads That Ship Production Software

**18 specialized roles · 8 lifecycle objectives · Solo · Squad · Orchestrate · Meeting**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![AI Ready](https://img.shields.io/badge/AI-Ready-8A2BE2)](#)
[![No Dependencies](https://img.shields.io/badge/Dependencies-Zero-success)](#)

```
You:       "Build the payment system"
AgentCrew: Orchestrator → 7 objectives → squad assembles → artifacts ship ✓
```

---

## Why AgentCrew?

AI agents are great at writing code but **terrible at software process**. Without structure, every prompt is a gamble — you might get code with no tests, no threat model, no PRD, no deploy plan.

AgentCrew gives AI agents a **repeatable SDLC brain**. 18 roles with hardened contracts, workflows, and quality gates. Drop it in any project, point your AI at it, and get production-grade results.

**No SaaS. No API keys. No vendor lock.** Just markdown files any AI agent can read.

## How It Works

1. **User Request** → 2. **Objective Match** → 3. **Squad Assembly** → 4. **Execute & Verify** → 5. **Ship ✓**

| Mode | Example | What Happens |
|------|---------|-------------|
| **Solo** | *"Architect, design the DB"* | Single role, zero orchestration overhead |
| **Squad** | *"Team, design the solution"* | Multiple roles, one objective, parallel execution |
| **Orchestrated** | *"Build the payment system"* | Orchestrator → 7 objectives → squads → track → ship |
| **Meeting** | *"/meeting brainstorm [topic]"* | Dynamic roles assembled, structured brainstorm, decisions, action items |

## Agent-Centric Format

Every file is a **system prompt for an AI agent** — YAML metadata + structured instructions, no prose fluff.

```yaml
---
role: Backend
needs:
  - artifact: API contracts
    from: Architect
produces:
  - artifact: API endpoints
    to: Frontend, QA
---
```

| Section | Format | Agent Benefit |
|---------|--------|-------------|
| Needs/Produces, Skills, Rules | YAML frontmatter | Parse in 1ms, schema-enforced |
| System, Instructions, I/O, Rules | Structured markdown | No prose parsing — direct to reasoning |
| Templates | Code blocks | Drop-in artifact generation |

**Zero dependencies.** Every file reads as a prompt.

## The Crew (18 Roles)

| Role | Superpower | Produces |
|------|-----------|----------|
| **Orchestrator** | Coordinates full lifecycle | Decomposition, squads, status |
| **Product Manager** | Requirements, priorities | PRD, roadmap, acceptance criteria |
| **Business Analyst** | Analysis, user stories | Requirements spec, dependency map |
| **Solution Architect** | Architecture, tech stack | ADRs, system diagrams, tech decisions |
| **Tech Lead** | Standards, code quality | ADRs, code review, tech debt plan |
| **Frontend Dev** | UI, client logic | Components, integration, state |
| **Backend Dev** | API, data, services | APIs, DB schema, business logic |
| **Mobile Dev** | iOS/Android | Mobile UI, push, offline, store |
| **UX Designer** | Research, wireframes | Personas, prototypes, design system |
| **Data Engineer** | ETL, pipelines | Data models, lineage, quality checks |
| **ML Engineer** | Models, training, serving | Model card, eval report, drift monitor |
| **QA Engineer** | Testing, quality | Test plan, bug report, sign-off |
| **Security Engineer** | Threat model, pentest | Threat model, SBOM, scan results |
| **DevOps Engineer** | CI/CD, infra | Pipeline, deploy plan, runbook |
| **Engineering Manager** | Sprint planning, retro | Sprint plan, velocity report, retro |
| **Technical Writer** | API docs, user guides, release notes | Doc-as-code, changelog, onboarding |
| **Meeting Facilitator** | Meeting mode, brainstorming | Agenda, decisions, action items, minutes |
| **Debate Facilitator** | Decision moderation | Structured debate, scored options |

## Quick Start

```bash
# 1. Copy to your project
cp -r .agentcrew ./your-project/

# 2. Generate codebase map
./.agentcrew/scripts/generate-codebase-map.ps1

# 3. Configure AI agents
./.agentcrew/config/setup.ps1        # Windows
./.agentcrew/config/setup.sh --all   # Linux/macOS

# 4. Make a request
#    "PM, write a PRD for login"
#    "Squad (QA, Security), verify quality"
#    "Build the full e-commerce platform"
```

Your AI agent reads `.agentcrew/00-objectives.md`, routes to the right objective, loads the squad, and executes.

## Project Structure

```
.agentcrew/
├── 00-objectives.md       # YAML frontmatter routing table
├── 00-team.md             # YAML frontmatter crew roster
├── 00-roles.md            # 18 role definitions
├── objectives/            # 8 lifecycle objectives
├── roles/                 # 18 contracts + workflows (YAML frontmatter)
├── procedures/            # Step-by-step guides
├── debate/                # Decision framework
├── meeting/               # Meeting mode workflow (5 steps)
├── custom/                # Per-project overrides
├── config/                # Agent config templates
├── light/                 # 7-step compressed variant
├── animations/            # Retro RPG party screen
├── scripts/               # State dashboard + utils
├── log/                   # Execution logs
└── state/workflow.json    # Progress tracker
```

## Invocation Modes

| Mode | When | Pattern |
|------|------|---------|
| **Solo** | Single role task | *"[Role], do [task]"* |
| **Squad** | Multiple roles, one objective | *"Squad ([roles]), achieve [objective]"* |
| **Orchestrate** | Full lifecycle | *"Build [feature]"* |
| **Meeting** | Brainstorming, decision-making, retro | *"/meeting [topic]"* |

---

*MIT Licensed — Built for AI-native development*
