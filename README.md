# CrewMarkdown

**AI-Native Software Engineering Framework** — 33 roles · 58 sub-specializations · 11 lifecycle objectives · Solo · Squad · Orchestrate · Meeting

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![AI Ready](https://img.shields.io/badge/AI-Ready-8A2BE2)](#)
[![Sub-Specs](https://img.shields.io/badge/Sub--Specs-58-22d3ee)](#)
[![No Dependencies](https://img.shields.io/badge/Dependencies-Zero-success)](#)

---

## Overview

CrewMarkdown provides any AI agent with a **repeatable, production-grade software engineering process** — no SaaS, no API keys, no vendor lock. Just markdown files.

Every request is routed to an **objective**, which assembles a **squad** of specialized AI roles. Each role has a hardened **contract**, a **workflow**, quality gates, and artifact templates. The result: consistent, auditable, professional software delivery across the full lifecycle.

---

## The Problem

AI agents write great code but lack software engineering process. Without structure, every prompt is a gamble — you might get a feature, but almost never with:

- A **PRD** that defines scope and acceptance criteria
- A **threat model** that catches vulnerabilities early
- A **test plan** that validates correctness
- A **deploy plan** that ensures safe rollout
- An **architecture decision record** that explains *why*

You end up debugging chaos instead of shipping quality.

---

## The Solution

CrewMarkdown gives any AI agent a structured engineering brain. Drop it into any project, point your AI at `.crewmarkdown/`, and get production-grade results — every time.

```
User Request → Objective Routing → Squad Assembly → Execution & Verification → Ship
```

### Execution Modes

| Mode | Example | Behavior |
|------|---------|----------|
| **Solo** | *"Architect, design the database schema"* | Single role executes with zero overhead |
| **Squad** | *"Squad (QA, Security), verify the release"* | Multiple roles, one objective, parallel execution |
| **Orchestrate** | *"Build the e-commerce platform"* | Orchestrator decomposes → 11 objectives → squads → track → ship |
| **Meeting** | *"/meeting brainstorm [topic]"* | Dynamic role assembly, structured deliberation, decisions, action items |

---

## The Crew — 33 Professional Roles

Every role ships with a YAML-frontmatter contract, a structured workflow, a quality checklist, and production-grade artifact templates. Roles span the full software delivery lifecycle.

### Engineering & Architecture

| Role | Core Competency | Key Deliverables |
|------|----------------|-----------------|
| **Orchestrator** | Multi-objective coordination, lifecycle management | Objective decomposition, squad assignments, risk register, completion reports |
| **Solution Architect** | System architecture, tech stack, high-level design | ADRs, C4 diagrams, tech specs, DB designs, API contracts |
| **Tech Lead** | Coding standards, code quality, technical decisions | Code review approvals, coding standards, tech debt register |
| **Frontend Developer** | UI implementation, client logic | Components, unit tests, API integration, state management |
| **Backend Developer** | API, services, data layer, business logic | API endpoints, DB schemas, business logic, integration tests |
| **Mobile Developer** | iOS/Android applications | Cross-platform UIs, push notifications, offline support, app store builds |

### Product & Design

| Role | Core Competency | Key Deliverables |
|------|----------------|-----------------|
| **Product Manager** | Requirements, priorities, stakeholder sign-off | PRDs, roadmaps, scope decisions, release plans, UAT sign-off |
| **Business Analyst** | Requirements analysis, gap detection | Structured requirements, gap analyses, user stories, dependency graphs |
| **UX Designer** | User research, wireframes, visual design | Mockups, prototypes, design assets, design systems |
| **UX Researcher** | User research, usability testing, personas | Research reports, personas, journey maps, usability findings |

### Data & ML

| Role | Core Competency | Key Deliverables |
|------|----------------|-----------------|
| **Data Engineer** | ETL/ELT pipelines, data warehousing | Pipelines, data schemas, data catalogs, lineage documentation |
| **Data Scientist** | Statistics, ML, A/B testing | Analysis reports, experiment results, dashboards, recommendations |
| **ML Engineer** | Model training, evaluation, serving, monitoring | Trained models, evaluation reports, serving endpoints, drift monitors |

### Quality & Security

| Role | Core Competency | Key Deliverables |
|------|----------------|-----------------|
| **QA Engineer** | Test planning, execution, bug tracking, sign-off | Test plans, test cases, bug reports, execution reports, QA sign-off |
| **Security Engineer** | Threat modeling, pentesting, SBOM | Threat models, pentest reports, security gate status, SBOMs |
| **SRE** | SLOs, incident response, capacity planning | Runbooks, SLI dashboards, postmortems, capacity reports |

### Operations & Delivery

| Role | Core Competency | Key Deliverables |
|------|----------------|-----------------|
| **DevOps Engineer** | Infrastructure, CI/CD, deployment, monitoring | Environments, CI/CD pipelines, deployed builds, monitoring dashboards |
| **Engineering Manager** | Sprint planning, team process, retrospectives | Sprint plans, capacity allocations, velocity reports, retro reports |
| **Technical Writer** | Documentation, API references, user guides | API docs, user guides, architecture docs, release notes, changelogs |

### Business & Strategy

| Role | Core Competency | Key Deliverables |
|------|----------------|-----------------|
| **Marketing** | Campaigns, content, brand, go-to-market | Campaign plans, marketing content, GTM strategies, brand assets |
| **Growth Marketing** | Growth experiments, funnel optimization | Experiment plans, funnel analyses, growth roadmaps |
| **Sales** | Pipeline management, forecasts, proposals | Sales pipelines, forecasts, proposals, account plans |
| **Business Development** | Partnerships, deals, strategic alliances | Partner agreements, deal memos, partnership roadmaps |
| **Customer Success** | Onboarding, retention, QBRs, advocacy | Success plans, health scores, QBRs, escalation reports |
| **SEO Specialist** | Technical SEO, keyword research, content optimization | SEO audits, keyword strategies, content optimizations, ranking reports |
| **Content Strategist** | Content strategy, editorial calendar | Content calendars, editorial guidelines, content audits |
| **Solutions Architect** | Pre-sales, solution designs, POCs | Solution designs, proposals, proofs-of-concept, technical demos |

### Governance & Support

| Role | Core Competency | Key Deliverables |
|------|----------------|-----------------|
| **HR / People Operations** | Hiring, onboarding, performance, culture | Hiring plans, onboarding documentation, performance reviews, culture initiatives |
| **Finance / Operations** | Budgets, financial reporting, compliance | Budgets, financial reports, compliance documentation, vendor assessments |
| **Legal / Compliance** | Contracts, privacy, regulatory compliance | Contract reviews, compliance reports, privacy assessments |
| **General Management** | OKRs, strategy, resource allocation | OKRs, strategy documents, resource plans, executive summaries |

### Collaboration

| Role | Core Competency | Key Deliverables |
|------|----------------|-----------------|
| **Meeting Facilitator** | Meeting orchestration, agenda setting, decision capture | Agendas, discussion summaries, decision logs, action item lists, minutes |
| **Debate Facilitator** | Structured debate, neutrality, resolution | Debate briefs, panel assemblies, scoring leadership, decision records |

Each role is invocable via `"[Role], do [task]"` for solo execution or assembled dynamically into squads per objective.

---

## Quick Start

Get CrewMarkdown running in any project in under a minute.

```bash
# 1. Copy to your project
cp -r .crewmarkdown ./your-project/

# 2. Generate a codebase map (AI navigation index)
./.crewmarkdown/scripts/generate-codebase-map.ps1

# 3. Configure your AI agent
./.crewmarkdown/config/setup.ps1        # Windows
./.crewmarkdown/config/setup.sh --all   # Linux / macOS

# 4. Make your first request
#    "PM, write a PRD for user authentication"
#    "Squad (QA, Security), verify the release build"
#    "Build the full platform — start to finish"
```

Your AI agent reads `.crewmarkdown/00-objectives.md`, routes your request to the matching objective, assembles the appropriate squad, and executes the full workflow with quality gates.

---

## Project Structure

```
.crewmarkdown/
├── 00-objectives.md       # Request → objective routing table (YAML)
├── 00-roles.md            # All 33 roles at a glance
├── 00-team.md             # Invocation patterns with YAML frontmatter
├── objectives/            # 11 lifecycle objectives with squads
├── roles/                 # 33 role contracts + workflows + 58 sub-specializations
├── procedures/            # Step-by-step how-to guides by phase (38 total)
├── config/                # AI agent configuration templates
├── debate/                # Structured decision-making framework
├── meeting/               # Meeting mode workflow
├── custom/                # Project-specific phase overrides
├── scripts/               # State dashboard, validation, workflow logs
├── state/workflow.json    # Real-time progress tracking
├── logs/                  # Structured execution logs
└── light/                 # Compressed 7-step variant for MVPs
```

### Supported SDLC Models

| Model | Style | Best For |
|-------|-------|----------|
| Waterfall | Linear-sequential | Stable, well-understood requirements |
| V-Model | Verification & Validation parallel | Safety-critical systems |
| Spiral | Risk-driven iterative | High-risk, complex projects |
| Agile (Scrum) | Iterative-incremental | Cross-functional teams |
| Iterative | Repeated refinement | Evolving or unclear requirements |
| Incremental | Piecewise delivery | Phased feature rollouts |
| Big Bang | Monolithic delivery | Very small projects, prototypes |
| RAD | Rapid prototyping | Fast user feedback cycles |

---

## Variants

| Variant | When To Use |
|---------|------------|
| **Full** (default) | Production systems — 11 objectives, full squads, all quality gates |
| **Light** (`.crewmarkdown/light/`) | MVPs, prototypes, solo development — 7 compressed steps, reduced ceremony |
| **Meeting** (`.crewmarkdown/meeting/`) | Brainstorming, retrospectives, decision-making — dynamic role assembly |

---

## Requirements

- **Any AI agent** that reads markdown — opencode, Claude Code, Cursor, GitHub Copilot, Cline
- **PowerShell 5.1+** or **Bash** (optional — for codebase map generation, setup scripts, and state management)

---

## With vs. Without CrewMarkdown

| Dimension | Without CrewMarkdown | With CrewMarkdown |
|-----------|---------------------|-------------------|
| **Outputs** | Inconsistent, varies per prompt | Standardized artifacts every time |
| **Quality** | Random, depends on the day | Quality checklists per role, gated |
| **Security** | Forgotten until incident | Security Engineer gate in every build |
| **Process** | No repeatable workflow | 11 objectives with defined squads |
| **Memory** | No cross-session tracking | Logged objectives + state persistence |
| **Portability** | Tied to one agent or prompt style | Portable markdown — any AI agent reads it |
| **Architecture** | No decision records | ADRs with rationale and trade-offs |

---

<div align="center">

**MIT Licensed** — Built for AI-native software engineering

[Star on GitHub](https://github.com/ShaikhAryanBilal/CrewMarkdown) · [Report an Issue](https://github.com/ShaikhAryanBilal/CrewMarkdown/issues) · [Contributions Welcome](CONTRIBUTING.md)

[Read the Documentation](docs/index.md)

</div>
