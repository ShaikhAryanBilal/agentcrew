<div align="center">

<pre>
     _                    _    ____                   
    / \   __ _  ___ _ __ | |_ / ___|_ __ _____      __
   / _ \ / _` |/ _ \ '_ \| __| |   | '__/ _ \ \ /\ / /
  / ___ \ (_| |  __/ | | | |_| |___| | |  __/\ V  V / 
 /_/   \_\__, |\___|_| |_|\__|\____|_|  \___| \_/\_/  
         |___/                                        
</pre>

### Autonomous AI Squads That Ship Production Software

**18 specialized roles · 8 lifecycle objectives · Solo · Squad · Orchestrate · Meeting**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![AI Ready](https://img.shields.io/badge/AI-Ready-8A2BE2)](#)
[![No Dependencies](https://img.shields.io/badge/Dependencies-Zero-success)](#)
[![Docs](https://img.shields.io/badge/Docs-Markdown-8A2BE2)](docs/index.md)
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

AgentCrew gives any AI agent a **repeatable SDLC brain** — 18 specialized roles with hardened contracts, workflows, and quality gates that form squads on demand.

> **Zero dependencies. Zero SaaS. Zero vendor lock.**
> Just markdown files — every AI agent can read them.

[📖 Read the docs](docs/index.md) · [🐙 View on GitHub](https://github.com/ShaikhAryanBilal/agentcrew)

---

## How It Works

```
You → Request → Objective routed → Squad assembled → Artifacts → Verified ✓
```

Three execution modes, one framework:

| Mode | Example | What Happens |
|------|---------|-------------|
| 🎯 **Solo** | *"Architect, design the database schema"* | Single role executes. Zero overhead. |
| 👥 **Squad** | *"Squad (QA, Security), verify quality"* | Multiple roles, one objective, parallel execution. |
| 🏗️ **Orchestrate** | *"Build the e-commerce platform"* | Orchestrator decomposes → 8 objectives → squads → track → ship. |
| 🗣️ **Meeting** | *"/meeting brainstorm [topic]"* | Dynamic roles assembled, structured brainstorm, decisions, action items. |

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

18 roles. Each with a contract, workflow, quality checklist, and artifact templates.

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
| 📝 | **Technical Writer** | Docs & guides | API docs, user guides, release notes |
| 🗣️ | **Meeting Facilitator** | Meeting mode & brainstorming | Agenda, decisions, action items, minutes |
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
├── 00-objectives.md       # 🧭 YAML routing table — match request → objective
├── 00-roles.md            # 📖 All 18 roles at a glance
├── 00-team.md             # 👥 Invocation patterns (solo/squad/orchestrate/meeting)
├── objectives/            # 8 lifecycle objectives
│   ├── 01-clarify-vision.md
│   ├── 02-design-solution.md
│   ├── 03-plan-work.md
│   ├── 04-build-feature.md
│   ├── 05-verify-quality.md
│   ├── 06-ship-release.md
│   ├── 07-operate-learn.md
│   └── 08-conduct-meeting.md
├── roles/                 # 18 role contracts + workflows
│   ├── orchestrator/
│   ├── product-manager/
│   ├── architect/
│   ├── backend/
│   ├── qa/
│   ├── security/
│   └── ...               # All 18 roles
├── procedures/            # How-to guides by SDLC phase
│   ├── 01-requirements/
│   ├── 02-design/
│   ├── 03-development/
│   ├── 04-qa/
│   ├── 05-deployment/
│   ├── 06-maintenance/
│   ├── adr/
│   └── postmortem/
├── debate/                # Structured decision framework (5 steps)
├── meeting/               # Meeting mode workflow (5 steps)
├── custom/                # Project-specific overrides per phase
├── config/                # AI agent configs (opencode, Cursor, Claude Code, Copilot)
├── animations/            # 🎮 Retro RPG party screen
├── scripts/               # State dashboard, validation, workflow log
├── log/                   # Execution logs by objective/role/timestamp
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
| **Full** (`.agentcrew/`) | Production — 8 objectives, full squads, all quality gates |
| **Light** (`.agentcrew/light/`) | MVPs, prototypes, solo dev — compressed workflow, fewer gates |
| **Meeting** (`.agentcrew/meeting/`) | Brainstorming, retro, decision-making — dynamic role assembly |

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

📖 **Read the full docs:** [docs/index.md](docs/index.md)

</div>
