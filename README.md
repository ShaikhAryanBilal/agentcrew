<div align="center">

# AgentCrew 🚀
### Autonomous AI Squads That Ship Production Software

**16 specialized roles · 7 lifecycle objectives · Solo · Squad · Orchestrated**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![AI Ready](https://img.shields.io/badge/AI-Ready-8A2BE2)](#)
[![No Dependencies](https://img.shields.io/badge/Dependencies-Zero-success)](#)
[![GitHub Pages](https://img.shields.io/badge/GitHub-Pages-181717?logo=github)](https://shaikaryanbilal.github.io/agentcrew)
[![Made with ❤️](https://img.shields.io/badge/Made%20with-%E2%9D%A4%EF%B8%8F-red)](#)

```
You:       "Build the payment system"
AgentCrew: Orchestrator → 7 objectives → squad assembles → artifacts ship ✓
```

</div>

---

## The Problem

AI agents write great code. But software engineering isn't just code — it's **process**.

Without structure, every prompt is a gamble. You might get a feature, but almost never with:
- A PRD that defines what success looks like
- A threat model that catches vulnerabilities early
- A test plan that validates correctness
- A deploy plan that ensures safe rollout
- An architecture decision record that explains *why*

You end up debugging chaos instead of building.

---

## The Solution

AgentCrew gives any AI agent a **repeatable SDLC brain** — 16 specialized roles with hardened contracts, workflows, and quality gates that form squads on demand.

> **Zero dependencies. Zero SaaS. Zero vendor lock.**
> Just markdown files — every AI agent can read them.

[📖 Read the docs](https://shaikaryanbilal.github.io/agentcrew) · [🐙 View on GitHub](https://github.com/ShaikhAryanBilal/agentcrew)

---

## How It Works

```
You → Request → Objective routed → Squad assembled → Artifacts → Verified ✓
```

Three execution modes, one framework:

| Mode | Example | What Happens |
|------|---------|-------------|
| 🎯 **Solo** | *"Architect, design the database schema"* | Single role executes. Zero overhead. |
| 👥 **Squad** | *"Team, design the authentication system"* | Multiple roles, one objective, parallel execution. |
| 🏗️ **Orchestrated** | *"Build the e-commerce platform"* | Orchestrator decomposes → 7 objectives → squads → track → ship. |

---

## What AgentCrew Ships

Every role produces standardized, production-grade artifacts:

| Artifact | Role | What It Contains |
|----------|------|-----------------|
| 📄 **PRD** | Product Manager | Requirements, scope, acceptance criteria, roadmap |
| 📐 **ADR** | Architect / Tech Lead | Architecture decisions, trade-offs, rationale |
| 🛡️ **Threat Model** | Security Engineer | Attack vectors, mitigations, risk assessment |
| 🧪 **Test Plan** | QA Engineer | Test strategy, coverage, edge cases, sign-off criteria |
| 📦 **SBOM** | Security Engineer | Software bill of materials, dependency vulnerabilities |
| 🚀 **Deploy Plan** | DevOps Engineer | Rollout strategy, rollback, monitoring, runbook |
| 📊 **Model Card** | ML Engineer | Model intent, eval results, bias analysis, drift monitoring |
| ✅ **Quality Checklist** | Every role | Gate criteria before moving to next phase |

No more chasing your AI agent for missing pieces. Everything is defined, templated, and verified.

---

## The Crew

16 roles. Each with a contract, workflow, quality checklist, and artifact templates.

| | Role | Superpower | Produces |
|--|------|-----------|----------|
| 🎯 | **Orchestrator** | Coordinates full lifecycle | Decomposition, squad assignments, status |
| 📋 | **Product Manager** | Requirements & priorities | PRD, roadmap, acceptance criteria |
| 📊 | **Business Analyst** | Analysis & user stories | Requirements spec, dependency map |
| 🏗️ | **Solution Architect** | Architecture & tech stack | ADRs, system diagrams, tech decisions |
| 👨‍💻 | **Tech Lead** | Standards & code quality | ADRs, code review, tech debt plan |
| 🎨 | **Frontend Dev** | UI & client logic | Components, integration, state management |
| ⚙️ | **Backend Dev** | API, data, services | APIs, DB schema, business logic |
| 📱 | **Mobile Dev** | iOS & Android | Mobile UI, push notifications, offline, store |
| ✏️ | **UX Designer** | Research & wireframes | Personas, prototypes, design system |
| 🗄️ | **Data Engineer** | ETL & pipelines | Data models, lineage, quality checks |
| 🧠 | **ML Engineer** | Models & training | Model card, eval report, drift monitor |
| 🔍 | **QA Engineer** | Testing & quality | Test plan, bug report, sign-off |
| 🛡️ | **Security Engineer** | Threat model & pentest | Threat model, SBOM, scan results |
| 🚀 | **DevOps Engineer** | CI/CD & infra | Pipeline, deploy plan, runbook |
| 📅 | **Engineering Manager** | Sprint planning & retro | Sprint plan, velocity report, retro |
| ⚖️ | **Debate Facilitator** | Decision moderation | Structured debate, scored options |

---

## Quick Start

Get AgentCrew running in your project in under a minute.

```bash
# 1. Copy to your project
cp -r .agentcrew ./your-project/

# 2. Generate a codebase map (so AI navigates your codebase fast)
./.agentcrew/scripts/generate-codebase-map.ps1

# 3. Configure for your AI agent
./.agentcrew/config/setup.ps1        # Windows
./.agentcrew/config/setup.sh --all   # Linux / macOS

# 4. Make your first request
#    "PM, write a PRD for login"
#    "Squad (QA, Security), verify the release build"
#    "Build the full platform — start to finish"
```

Done. Your AI agent reads `.agentcrew/00-objectives.md`, routes to the matching objective, assembles the squad, and executes.

---

## Project Structure

```
.agentcrew/
├── 00-objectives.md       # 🧭 Start here — the routing table
├── 00-team.md             # 👥 Crew orchestration hub
├── 00-roles.md            # 📖 All 16 roles at a glance
├── objectives/            # 7 lifecycle objectives
│   ├── 01-clarify-vision.md
│   ├── 02-design-solution.md
│   ├── 03-plan-work.md
│   ├── 04-build-feature.md
│   ├── 05-verify-quality.md
│   ├── 06-ship-release.md
│   └── 07-operate-learn.md
├── roles/                 # 16 role contracts + workflows
│   ├── product-manager/
│   ├── architect/
│   ├── backend/
│   ├── qa/
│   ├── security/
│   └── ...               # All 16 roles
├── procedures/            # Step-by-step guides
│   ├── 01-pm/
│   ├── 02-architect/
│   └── ...               # Per-role procedures
├── debate/                # Structured decision framework
├── custom/                # Project-specific overrides
├── config/                # AI agent configuration templates
├── light/                 # Compressed 7-step variant for MVPs
├── animations/            # 🎮 Retro RPG party screen
├── scripts/               # State dashboard + utilities
├── log/                   # Execution logs
└── state/workflow.json    # 📊 Real-time progress tracker
```

---

## The Demo

When AgentCrew assembles a squad, it fires up a **Retro RPG party screen** — right in your terminal.

```
 ╔══════════════════════════════════════════╗
 ║          ⚔️ SQUAD ASSEMBLED ⚔️           ║
 ║                                          ║
 ║  🏗️ Architect     [████████░░] HP  80%  ║
 ║  ⚙️ Backend        [██████████] HP 100%  ║
 ║  🔍 QA             [██████░░░░] HP  60%  ║
 ║  🚀 DevOps         [████████░░] HP  75%  ║
 ║                                          ║
 ║  ► Objective: Build Feature              ║
 ║  ► Status: In Progress                   ║
 ╚══════════════════════════════════════════╝
```

Animated terminal TUI with role icons, HP-style progress bars, and live status messages.

```bash
# PowerShell
.\.agentcrew\animations\show-party.ps1 -Objective "Build Feature" -Squad Frontend,Backend,QA -Timeout 5

# Bash
./.agentcrew/animations/show-party.sh -o "Build Feature" -s "Frontend,Backend,QA" -t 5
```

---

## Variants

| Variant | When to Use |
|---------|------------|
| **Full** (`.agentcrew/`) | Production — 7 objectives, full squads, all quality gates |
| **Light** (`.agentcrew/light/`) | MVPs, prototypes, solo dev — compressed workflow, fewer gates |

Switch anytime. Need rigor? Use full. Moving fast? Use light.

---

## Requirements

All you need is:
- **Any AI agent** that reads markdown (opencode, Claude Code, Cursor, Copilot, Cline)
- **PowerShell** or **Bash** (optional — for codebase-map, setup, and state scripts)

---

## With vs. Without

| | Without AgentCrew | With AgentCrew |
|--|------------------|----------------|
| 📄 **Outputs** | Inconsistent, varies every prompt | Standardized artifacts every time |
| ✅ **Quality** | Random, depends on the day | Quality checklists per role, gated |
| 🔒 **Security** | Forgotten until incident | Security Engineer in every build |
| 🧠 **Memory** | No process tracking across sessions | Logged objectives + state tracking |
| 🔗 **Lock-in** | Tied to one agent / one prompt style | Portable markdown — any agent reads it |
| 🏗️ **Architecture** | No decision records | ADRs with rationale and trade-offs |

---

<div align="center">

**MIT Licensed** · Built for AI-native development

**⭐ [Star on GitHub](https://github.com/ShaikhAryanBilal/agentcrew)** · 🐛 [Report an issue](https://github.com/ShaikhAryanBilal/agentcrew/issues) · 🤝 [Contributions welcome](CONTRIBUTING.md)

📖 **Read the full docs:** [https://shaikaryanbilal.github.io/agentcrew](https://shaikaryanbilal.github.io/agentcrew)

</div>
