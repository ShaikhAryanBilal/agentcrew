# Roles & Responsibilities

## System Model

This project uses **objective-based SDLC**. Each role is an invocable unit that can:
- **Work solo**: Invoked independently to produce specific artifacts
- **Join a squad**: Combined with other roles to achieve an objective
- **Be orchestrated**: Coordinated by the Orchestrator for multi-objective work

See `00-team.md` for invocation patterns and `00-objectives.md` for routing.

## Role Definitions

### 1. Product Manager
**Owns:** Requirements, prioritization, stakeholder communication, sign-off
**Provides:** PRD, priorities, scope decisions, sign-off
**Consumes:** Stakeholder input, feedback
**Invoke:** "PM, [do task]" — Solo on req intake, PRD, sign-off. Squad with BA for Clarify Vision.
**Contracts:** `roles/product-manager/contract.md` | `roles/product-manager/workflow.md`

### 2. Business Analyst
**Owns:** Requirements analysis, gap detection, clarification
**Provides:** Structured reqs, gap list, user stories, dependency graph
**Consumes:** Raw input from stakeholders, domain context
**Invoke:** "BA, [do task]" — Solo on analysis. Squad with PM for Clarify Vision.
**Contracts:** `roles/ba/contract.md` | `roles/ba/workflow.md`

### 3. Solution Architect
**Owns:** System architecture, tech stack, high-level design
**Provides:** Architecture diagram, tech decisions, threat model input
**Consumes:** Signed-off PRD
**Invoke:** "Architect, [do task]" — Solo on arch/DB/API design. Squad with UX+Security for Design Solution.
**Contracts:** `roles/architect/contract.md` | `roles/architect/workflow.md`

### 4. Tech Lead
**Owns:** Coding standards, code quality, technical decisions, ADRs
**Provides:** Standards, review approval, technical guidance, tech debt register
**Consumes:** Architecture, PRD
**Invoke:** "Tech Lead, [do task]" — Solo on standards, review. Squad with Devs for Build Feature.
**Contracts:** `roles/tech-lead/contract.md` | `roles/tech-lead/workflow.md`

### 5. Frontend Developer
**Owns:** UI implementation, client logic
**Provides:** UI code, component tests
**Consumes:** Designs, API specs
**Invoke:** "Frontend Dev, [do task]" — Solo on UI implementation. Squad with Backend for Build Feature.
**Contracts:** `roles/frontend/contract.md` | `roles/frontend/workflow.md`

### 6. Backend Developer
**Owns:** API, services, data layer, business logic
**Provides:** API, services, DB migrations, integration tests
**Consumes:** Tech spec, DB design
**Invoke:** "Backend Dev, [do task]" — Solo on API/db implementation. Squad with Frontend for Build Feature.
**Contracts:** `roles/backend/contract.md` | `roles/backend/workflow.md`

### 7. Full Stack Developer
**Owns:** Both frontend + backend (end-to-end delivery)
**Provides:** Full feature implementation
**Consumes:** Tech spec, designs
**Invoke:** "Full Stack Dev, [do task]" — Solo on full feature build. Squad with Tech Lead for Build Feature.
**Contracts:** Uses frontend + backend role files

### 8. Mobile Developer
**Owns:** iOS/Android app, offline support, push notifications, app store submission
**Provides:** Mobile app code, UI tests, app store build
**Consumes:** Wireframes, API contracts, design tokens, CI pipeline
**Invoke:** "Mobile Dev, [do task]" — Solo on mobile feature. Squad with Backend for API integration.
**Contracts:** `roles/mobile-dev/contract.md` | `roles/mobile-dev/workflow.md`

### 9. Data Engineer
**Owns:** ETL/ELT pipelines, data warehouse/lake, data quality
**Provides:** Pipelines, schemas, data catalog, lineage docs
**Consumes:** Data requirements, source access, storage infrastructure
**Invoke:** "Data Engineer, [do task]" — Solo on pipeline. Squad with Backend for data API.
**Contracts:** `roles/data-engineer/contract.md` | `roles/data-engineer/workflow.md`

### 10. ML Engineer
**Owns:** Model training, evaluation, serving, monitoring
**Provides:** Trained models, evaluation reports, serving endpoints, drift monitors
**Consumes:** ML requirements, training data, compute resources, serving infra
**Invoke:** "ML Engineer, [do task]" — Solo on model training. Squad with Data Engineer for feature pipeline.
**Contracts:** `roles/ml-engineer/contract.md` | `roles/ml-engineer/workflow.md`

### 11. QA Engineer
**Owns:** Test planning, execution, bug tracking, sign-off
**Provides:** Test plan, test cases, bug reports, sign-off
**Consumes:** Build artifact, requirements
**Invoke:** "QA, [do task]" — Solo on test plan/cases/execution. Squad with Security for Verify Quality.
**Contracts:** `roles/qa/contract.md` | `roles/qa/workflow.md`

### 12. Security Engineer
**Owns:** Threat modeling, security testing, pentest, SBOM
**Provides:** Threat model, pentest report, security gate
**Consumes:** Architecture, staging build
**Invoke:** "Security, [do task]" — Solo on threat model/pentest. Squad with QA for Verify Quality.
**Contracts:** `roles/security/contract.md` | `roles/security/workflow.md`

### 13. DevOps Engineer
**Owns:** Infrastructure, CI/CD, deployment, monitoring
**Provides:** Environments, pipelines, deployment, monitoring
**Consumes:** Build artifact, deployment plan
**Invoke:** "DevOps, [do task]" — Solo on CI/CD/deploy/monitoring. Squad with PM for Ship Release.
**Contracts:** `roles/devops/contract.md` | `roles/devops/workflow.md`

### 14. UX Designer
**Owns:** User research, wireframes, visual design, prototyping
**Provides:** Mockups, prototype, design assets
**Consumes:** PRD with personas
**Invoke:** "UX Designer, [do task]" — Solo on wireframes/prototypes. Squad with Architect for Design Solution.
**Contracts:** `roles/ux-designer/contract.md` | `roles/ux-designer/workflow.md`

### 15. Engineering Manager
**Owns:** Sprint planning, team process, retrospectives, capacity
**Provides:** Sprint plan, capacity allocation, task breakdown, retro report
**Consumes:** Team capacity, velocity data, priority from PM
**Invoke:** "EM, [do task]" — Solo on sprint planning/retro. Squad with PM+Tech Lead for Plan Work.
**Contracts:** `roles/engineering-manager/contract.md` | `roles/engineering-manager/workflow.md`

### 16. Debate Facilitator
**Owns:** Debate process, neutrality, timebox enforcement, resolution
**Provides:** Debate brief, panel assembly, scoring leadership, decision record
**Consumes:** Decision question, viable options, role stances
**Serves as:** Neutral arbitrator — does NOT advocate for any option
**Invoke:** "Facilitator, run debate on [topic]" — Cross-cutting, invoked from any objective.
**Contracts:** `roles/debator/contract.md` | `roles/debator/workflow.md`

### 17. Panelist (any role wearing debate hat)
**Owns:** Stance from role perspective, evidence-based argument, rebuttal
**Provides:** Opening statement, cross-examination, criteria scores, final recommendation
**Consumes:** Decision brief, option descriptions, scoring criteria
**Rule:** Argue the role's interest, not personal preference

### 18. Orchestrator
**Owns:** Multi-objective decomposition, squad assembly, cross-objective coordination
**Provides:** Objective breakdown, squad assignments, status reports, completion summary
**Consumes:** High-level user request, role roster, objective definitions
**Invoke:** Auto-activated on multi-objective requests like "build this feature".
**Skip:** Single-objective or solo role requests bypass orchestration.
**Contracts:** `roles/orchestrator/contract.md` | `roles/orchestrator/workflow.md`

## Debate Integration Points

Debate activates when a decision point in any objective has multiple viable solutions:

| Objective | Typical Debate Trigger | Who Facilitates | Typical Panel |
|-----------|----------------------|-----------------|---------------|
| Clarify Vision | Feature priority, scope trade-off | PM | BA, Architect, Dev |
| Design Solution | Tech stack, architecture fork, DB choice | Architect | Backend, Frontend, Security, DevOps, Data Engineer |
| Plan Work | Sprint scope, capacity allocation | EM | PM, Tech Lead |
| Build Feature | Implementation approach, library choice | Tech Lead | Dev, QA, DevOps, Mobile Dev |
| Verify Quality | Test strategy, automation, ML eval | QA Lead | Dev, DevOps, ML Engineer |
| Ship Release | Deployment strategy, rollback plan | DevOps | PM, Tech Lead, Security |
| Operate & Learn | Refactor vs rewrite, model retrain, data quality | Tech Lead | Architect, DevOps, PM, ML Engineer |

## Ownership Matrix

Objectives → Role ownership:

| Objective | Lead | Squad |
|-----------|------|-------|
| Clarify Vision | PM | BA |
| Design Solution | Architect | UX, Security |
| Plan Work | EM | PM, Tech Lead |
| Build Feature | Tech Lead | Dev(s) |
| Verify Quality | QA | Security, Dev(s) |
| Ship Release | DevOps | PM |
| Operate & Learn | DevOps | EM, PM |

### Old Step → Role Reference

Old step files still serve as procedure guides for roles:

| Step ID | Procedure File | Used By Role(s) |
|---------|---------------|-----------------|
| req/gather | procedures/01-requirements/01-requirements-gathering.md | PM |
| req/analysis | procedures/01-requirements/02-requirements-analysis.md | BA |
| req/prd | procedures/01-requirements/03-prd.md | PM |
| req/signoff | procedures/01-requirements/04-requirements-review-and-signoff.md | PM |
| design/arch | procedures/02-design/01-system-architecture.md | Architect |
| design/spec | procedures/02-design/02-technical-specification.md | Tech Lead |
| design/db | procedures/02-design/03-database-design.md | Backend |
| design/api | procedures/02-design/04-api-design.md | Backend |
| design/threat | procedures/02-design/06-threat-modeling.md | Security |
| design/review | procedures/02-design/05-design-review.md | Tech Lead |
| dev/planning | procedures/03-development/01-sprint-planning.md | EM |
| dev/analysis | procedures/03-development/02-codebase-analysis.md | Tech Lead / Dev |
| dev/standards | procedures/03-development/03-coding-standards.md | Tech Lead |
| dev/impl | procedures/03-development/04-implementation.md | Dev |
| dev/review | procedures/03-development/05-code-review.md | Tech Lead |
| dev/unit | procedures/03-development/06-unit-testing.md | Dev |
| dev/integration | procedures/03-development/07-integration.md | Backend/DevOps |
| qa/plan | procedures/04-qa/01-test-planning.md | QA |
| qa/cases | procedures/04-qa/02-test-case-development.md | QA |
| qa/functional | procedures/04-qa/03-functional-testing.md | QA |
| qa/nonfunctional | procedures/04-qa/04-non-functional-testing.md | QA |
| qa/regression | procedures/04-qa/05-regression-testing.md | QA |
| qa/bugs | procedures/04-qa/06-bug-tracking.md | QA |
| qa/uat | procedures/04-qa/07-uat.md | PM |
| qa/pentest | procedures/04-qa/09-security-pentest.md | Security |
| qa/signoff | procedures/04-qa/08-qa-signoff.md | QA |
| deploy/plan | procedures/05-deployment/01-release-planning.md | PM |
| deploy/staging | procedures/05-deployment/02-staging-deployment.md | DevOps |
| deploy/prod | procedures/05-deployment/03-production-deployment.md | DevOps |
| deploy/post | procedures/05-deployment/04-post-deployment.md | DevOps |
| ops/monitor | procedures/06-maintenance/01-monitoring-and-observability.md | DevOps |
| ops/hotfix | procedures/06-maintenance/02-hotfix-process.md | Dev |
| ops/feedback | procedures/06-maintenance/03-feedback-loop.md | EM / PM |
| adr/propose | procedures/adr/02-adr-workflow.md | Tech Lead, Architect |
| adr/template | procedures/adr/01-adr-template.md | Everyone |
| postmortem | procedures/postmortem/01-postmortem-template.md | Everyone (post-incident) |
| postmortem/workflow | procedures/postmortem/02-postmortem-workflow.md | Facilitator |
| supply-chain | procedures/supply-chain-security.md | Security, DevOps |

### Debate Steps (Cross-Cutting)

| ID | Facilitator | Panelists |
|-----|-------------|-----------|
| debate/trigger | PM / Facilitator | Roles with stake in decision |
| debate/panel | Facilitator | All panelists |
| debate/rounds | Facilitator | All panelists |
| debate/resolution | Facilitator | All panelists (scores) |
| debate/log | Scribe / Facilitator | — |
