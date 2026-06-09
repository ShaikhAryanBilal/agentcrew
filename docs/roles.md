# Roles

18 invocable AI roles with YAML-frontmatter contracts and workflows. Solo, squad, meeting, or orchestrated.

- [Orchestrator](#orchestrator)
- [Product Manager](#product-manager)
- [Business Analyst](#business-analyst)
- [Solution Architect](#solution-architect)
- [Tech Lead](#tech-lead)
- [Frontend Developer](#frontend-developer)
- [Backend Developer](#backend-developer)
- [Mobile Developer](#mobile-developer)
- [UX Designer](#ux-designer)
- [Data Engineer](#data-engineer)
- [ML Engineer](#ml-engineer)
- [QA Engineer](#qa-engineer)
- [Security Engineer](#security-engineer)
- [DevOps Engineer](#devops-engineer)
- [Engineering Manager](#engineering-manager)
- [Technical Writer](#technical-writer)
- [Debate Facilitator](#debate-facilitator)
- [Meeting Facilitator](#meeting-facilitator)

---

## Orchestrator

**Meta-role** — Activates on multi-objective requests

- **Owns:** Multi-objective decomposition, squad assembly, cross-objective coordination
- **Provides:** Objective breakdown, squad assignments, status reports, risk register, completion report
- **Consumes:** High-level user request, role roster, objective definitions, previous state
- **Invoke:** Auto-activated on "build this feature" requests. Single-objective or solo requests bypass.

### Key Workflow

```
User Request → Parse → Map to objectives → Order by dependencies
→ For each objective: assign squad → track → resolve → verify
→ All complete → Report to user
```

---

## Product Manager

- **Owns:** Requirements, prioritization, stakeholder communication, sign-off
- **Provides:** PRD, priorities, scope decisions, release plan, release notes, UAT sign-off
- **Consumes:** Stakeholder input, effort estimates (Tech Lead), UAT feedback (QA), team velocity (EM)
- **Invoke:** *"PM, write a PRD for user authentication"* — Solo or Squad with BA

### Key Skills

Scrum/Kanban, MoSCoW prioritization, stakeholder management, user story mapping, PRD writing, release planning

---

## Business Analyst

- **Owns:** Requirements analysis, gap detection, clarification
- **Provides:** Structured reqs, gap list, user stories, dependency graph
- **Consumes:** Raw input from stakeholders, domain context
- **Invoke:** *"BA, analyze these requirements"* — Solo or Squad with PM

### Key Skills

Requirements elicitation, gap analysis, user story mapping, dependency mapping, requirement classification

---

## Solution Architect

- **Owns:** System architecture, tech stack, high-level design
- **Provides:** Architecture diagram, ADRs, DB design, API contracts, tech spec, design review approval
- **Consumes:** Signed-off PRD, non-functional requirements, security requirements
- **Invoke:** *"Architect, design the database schema for the payment system"* — Solo or Squad with UX + Security

### Key Skills

Architecture patterns (microservices, event-driven, CQRS), C4 modeling, ADR writing, NFR evaluation, security architecture

---

## Tech Lead

- **Owns:** Coding standards, code quality, technical decisions, ADRs
- **Provides:** Standards, review approval, technical guidance, tech debt register
- **Consumes:** Architecture decisions, PRD
- **Invoke:** *"Tech Lead, review PR #42"* — Solo or Squad with Devs

---

## Frontend Developer

- **Owns:** UI implementation, client logic
- **Provides:** UI code, component tests, API integration
- **Consumes:** Designs/wireframes, API contracts, design tokens
- **Invoke:** *"Frontend Dev, implement the user profile component"* — Solo or Squad with Backend

---

## Backend Developer

- **Owns:** API, services, data layer, business logic
- **Provides:** API endpoints, business logic, DB migrations, integration tests
- **Consumes:** API contracts, DB design, tech spec, coding standards
- **Invoke:** *"Backend Dev, implement the order API"* — Solo or Squad with Frontend

### Key Skills

API design (REST, GraphQL, gRPC), database design, auth (JWT, OAuth2, RBAC), caching, error handling, security

---

## Mobile Developer

- **Owns:** iOS/Android apps, offline support, push notifications, app store submission
- **Provides:** Mobile app code, UI tests, app store build
- **Consumes:** Wireframes, API contracts, design tokens
- **Invoke:** *"Mobile Dev, implement the login screen"* — Solo or Squad with Backend

---

## UX Designer

- **Owns:** User research, wireframes, visual design, prototyping
- **Provides:** Mockups, prototypes, design assets, design system
- **Consumes:** PRD with personas, brand guidelines
- **Invoke:** *"UX Designer, create wireframes for the dashboard"* — Solo or Squad with Architect

---

## Data Engineer

- **Owns:** ETL/ELT pipelines, data warehouse/lake, data quality
- **Provides:** Pipelines, schemas, data catalog, lineage docs
- **Consumes:** Data requirements, source access, storage infrastructure
- **Invoke:** *"Data Engineer, build the customer analytics pipeline"*

---

## ML Engineer

- **Owns:** Model training, evaluation, serving, monitoring
- **Provides:** Trained models, evaluation reports, serving endpoints, drift monitors
- **Consumes:** ML requirements, training data, compute resources
- **Invoke:** *"ML Engineer, train a fraud detection model"*

---

## QA Engineer

- **Owns:** Test planning, execution, bug tracking, sign-off
- **Provides:** Test plan, test cases, bug reports, execution report, QA sign-off
- **Consumes:** Build artifact, PRD + acceptance criteria, API contracts
- **Invoke:** *"QA, create test cases for the checkout flow"* — Solo or Squad with Security

### Key Skills

Test planning (risk-based), test design (equivalence partitioning), automation (Playwright, Cypress), performance testing

---

## Security Engineer

- **Owns:** Threat modeling, security testing, pentest, SBOM
- **Provides:** Threat model, pentest report, security gate status, SBOM
- **Consumes:** Architecture diagrams, staging build, dependency list
- **Invoke:** *"Security, review the threat model for the portal"* — Solo or Squad with QA

### Security Gates

| Gate | Before | Must Pass |
|------|--------|-----------|
| **SG1** | Design review | Threat model complete, high threats mitigated |
| **SG2** | Merge to main | SAST + secret scan + dependency scan clean |
| **SG3** | QA sign-off | DAST + pentest + supply chain scan — no Critical/High |
| **SG4** | Production deploy | All scans clean, SBOM verified |

---

## DevOps Engineer

- **Owns:** Infrastructure, CI/CD, deployment, monitoring
- **Provides:** Environments, CI/CD pipelines, deployed builds, monitoring dashboards
- **Consumes:** Tech stack decisions, build config, secrets, release plan
- **Invoke:** *"DevOps, set up the CI/CD pipeline for this project"* — Solo or Squad with PM

### Key Skills

CI/CD (GitHub Actions, GitLab CI), Docker, Kubernetes, Terraform, cloud (AWS/Azure/GCP), monitoring (Prometheus/Grafana)

---

## Engineering Manager

- **Owns:** Sprint planning, team process, retrospectives, capacity
- **Provides:** Sprint plan, capacity allocation, task breakdown, retro report
- **Consumes:** Team capacity, velocity data, priorities from PM
- **Invoke:** *"EM, plan the sprint for these features"* — Solo or Squad with PM + Tech Lead

---

## Technical Writer

- **Owns:** User-facing docs, API reference, architecture docs, release notes, onboarding guides
- **Provides:** API docs, user guides, architecture docs, release notes, README, changelog
- **Consumes:** Technical specs, architecture diagrams, PRD, UI mockups, release scope
- **Invoke:** *"Technical Writer, write API docs for the payment endpoints"* — Solo or Squad with Backend / DevOps+PM

---

## Debate Facilitator

**Cross-cutting** — Invoked from any objective

- **Owns:** Debate process, neutrality, timebox enforcement, resolution
- **Provides:** Debate brief, panel assembly, scoring leadership, decision record
- **Consumes:** Decision question, viable options, role stances
- **Invoke:** *"Facilitator, run debate on tech stack choice"*
- **Role:** Neutral arbitrator — does NOT advocate for any option

### Key Process

```
Decision question → Panel assembly → Opening statements
→ Cross-examination rounds → Scoring → Resolution → Logging
```

---

## Meeting Facilitator

**Cross-cutting** — Activates on `/meeting` requests

- **Owns:** Meeting mode, agenda setting, brainstorming facilitation, decision capture, action items, minutes
- **Provides:** Agenda, discussion summary, decision log, action item list, meeting minutes
- **Consumes:** Meeting topic, role roster, role selection matrix
- **Invoke:** *"/meeting brainstorm the new dashboard"* — Auto-spawns relevant roles based on topic

### Key Process

```
Meeting topic → Role selection (by topic keywords) → Agenda → Brainstorm
→ Decisions → Action items → Minutes → Logging
```

---

*MIT Licensed — Built for AI-native development*
