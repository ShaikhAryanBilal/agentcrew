# Roles & Responsibilities

## Role Table
| # | Role | Owns | Contract | Sub-specs | Workflow | Solo Invocation | Squad Invocation |
|---|------|------|----------|----------|----------|-----------------|------------------|
| 1 | Product Manager | Requirements, priorities, sign-off | `roles/product-manager/contract.md` | b2b, b2c, growth, platform | `roles/product-manager/workflow.md` | "PM, [do task]" | Clarify Vision with BA |
| 2 | Business Analyst | Requirements analysis, user stories | `roles/ba/contract.md` | — | `roles/ba/workflow.md` | "BA, [do task]" | Clarify Vision with PM |
| 3 | Solution Architect | System architecture, tech stack | `roles/architect/contract.md` | — | `roles/architect/workflow.md` | "Architect, [do task]" | Design Solution with UX+Security |
| 4 | Tech Lead | Code quality, standards, ADRs | `roles/tech-lead/contract.md` | — | `roles/tech-lead/workflow.md` | "Tech Lead, [do task]" | Build Feature with Devs |
| 5 | Frontend Developer | UI implementation, client logic | `roles/frontend/contract.md` | ui-react, html-css, vue, angular, svelte, vanilla | `roles/frontend/workflow.md` | "Frontend, [do task]" | Build Feature with Backend |
| 6 | Backend Developer | API, services, data layer | `roles/backend/contract.md` | api-express, php, node, python, go, java, rust, dotnet | `roles/backend/workflow.md` | "Backend, [do task]" | Build Feature with Frontend |
| 7 | Mobile Developer | iOS/Android, offline, push | `roles/mobile-dev/contract.md` | ios-swift, android-kotlin, cross-platform-rn | `roles/mobile-dev/workflow.md` | "Mobile Dev, [do task]" | Build Feature with Backend |
| 8 | Data Engineer | ETL/ELT, data warehouse, pipelines | `roles/data-engineer/contract.md` | batch-etl, streaming, warehouse, data-lake | `roles/data-engineer/workflow.md` | "Data Engineer, [do task]" | Build Feature with Backend |
| 9 | Database Administrator (DBA) | Database ops, performance, backup/recovery | `roles/dba/contract.md` | relational, nosql, cloud, data-warehouse | `roles/dba/workflow.md` | "DBA, [do task]" | Build Feature with Backend + DevOps |
| 10 | ML Engineer | Models, training, serving, drift | `roles/ml-engineer/contract.md` | nlp, cv, recsys, mlops | `roles/ml-engineer/workflow.md` | "ML Engineer, [do task]" | Build Feature with Data Engineer |
| 11 | QA Engineer | Testing, quality, sign-off | `roles/qa/contract.md` | — | `roles/qa/workflow.md` | "QA, [do task]" | Verify Quality with Security |
| 12 | Security Engineer | Threat model, pentest, SBOM | `roles/security/contract.md` | — | `roles/security/workflow.md` | "Security, [do task]" | Verify Quality with QA |
| 13 | DevOps Engineer | Infrastructure, CI/CD, deployment | `roles/devops/contract.md` | aws, azure, gcp | `roles/devops/workflow.md` | "DevOps, [do task]" | Ship Release with PM |
| 14 | UX Designer | Research, wireframes, visual design | `roles/ux-designer/contract.md` | — | `roles/ux-designer/workflow.md` | "UX Designer, [do task]" | Design Solution with Architect |
| 15 | Engineering Manager | Sprint planning, capacity, retro | `roles/engineering-manager/contract.md` | — | `roles/engineering-manager/workflow.md` | "EM, [do task]" | Plan Work with PM+Tech Lead |
| 16 | Scrum Master | Agile process, impediments, coaching | `roles/scrum-master/contract.md` | scrum, kanban, safe, agile-coach | `roles/scrum-master/workflow.md` | "Scrum Master, [do task]" | Plan Work with EM + PM |
| 17 | Technical Writer | API docs, user guides, release notes | `roles/technical-writer/contract.md` | — | `roles/technical-writer/workflow.md` | "Tech Writer, [do task]" | Build Feature (API docs) / Ship Release (release notes) |
| 18 | Meeting Facilitator | Meeting mode, agenda, decisions | `roles/meeting-facilitator/contract.md` | — | `roles/meeting-facilitator/workflow.md` | "/meeting [topic]" | Conduct Meeting with dynamic roles |
| 19 | Debator | Structured debate, scoring, resolution | `roles/debator/contract.md` | — | `roles/debator/workflow.md` | "Debate [topic]" | Cross-cutting, any objective |
| 20 | Orchestrator | Multi-objective coordination | `roles/orchestrator/contract.md` | — | `roles/orchestrator/workflow.md` | Auto on multi-objective requests | Coordinates all objectives |
| 21 | Marketing | Campaigns, content, brand, GTM | `roles/marketing/contract.md` | brand, performance, content, social, product-marketing | `roles/marketing/workflow.md` | "Marketing, [do task]" | Build Feature (GTM) with PM & Sales |
| 22 | Sales | Pipeline, forecasts, proposals, accounts | `roles/sales/contract.md` | enterprise, smb, channel | `roles/sales/workflow.md` | "Sales, [do task]" | Build Feature with Marketing |
| 23 | HR / People | Hiring, onboarding, performance, culture | `roles/hr/contract.md` | recruiting, learning-dev, comp-benefits, employee-relations, hr-ops | `roles/hr/workflow.md` | "HR, [do task]" | Plan Work with EM & PM |
| 24 | Finance / Operations | Budgets, reporting, compliance, vendors | `roles/finance/contract.md` | fpa, accounting, audit, procurement | `roles/finance/workflow.md` | "Finance, [do task]" | Plan Work with Management |
| 25 | General Management | OKRs, strategy, resource allocation | `roles/general-management/contract.md` | — | `roles/general-management/workflow.md` | "Management, [do task]" | Orchestrates all objectives |
| 26 | SEO Specialist | Technical SEO, keywords, content optimization | `roles/seo-specialist/contract.md` | technical, on-page, off-page, local | `roles/seo-specialist/workflow.md` | "SEO Specialist, [do task]" | Build Feature with Content & Marketing |
| 27 | UX Researcher | User research, testing, personas | `roles/ux-researcher/contract.md` | — | `roles/ux-researcher/workflow.md` | "UX Researcher, [do task]" | Design Solution with UX & PM |
| 28 | Data Scientist | Stats, ML, A/B testing | `roles/data-scientist/contract.md` | — | `roles/data-scientist/workflow.md` | "Data Scientist, [do task]" | Build Feature with ML Engineer |
| 29 | Growth / Product Marketing | Growth experiments, funnel, activation | `roles/growth-marketing/contract.md` | — | `roles/growth-marketing/workflow.md` | "Growth, [do task]" | Build Feature with Marketing & PM |
| 30 | Customer Success Manager | Onboarding, retention, QBRs | `roles/customer-success/contract.md` | enterprise, smb, technical | `roles/customer-success/workflow.md` | "Customer Success, [do task]" | Ship Release with Sales |
| 31 | Site Reliability Engineer | SLOs, incidents, capacity | `roles/sre/contract.md` | — | `roles/sre/workflow.md` | "SRE, [do task]" | Operate & Learn with DevOps |
| 32 | Legal / Compliance | Contracts, privacy, compliance | `roles/legal/contract.md` | contracts, privacy, ip, employment, corporate | `roles/legal/workflow.md` | "Legal, [do task]" | Plan Work with Management |
| 33 | Business Development | Partnerships, deals, alliances | `roles/bizdev/contract.md` | strategic-partnerships, channel, ma | `roles/bizdev/workflow.md` | "BizDev, [do task]" | Execute Campaign with Marketing |
| 34 | Solutions Architect | Pre-sales, solution design, POC | `roles/solutions-architect/contract.md` | aws, azure, gcp | `roles/solutions-architect/workflow.md` | "Solutions Architect, [do task]" | Build Feature with Sales & PM |
| 35 | Content Strategist | Content strategy, editorial, SEO | `roles/content-strategist/contract.md` | seo-content, brand-content, technical-content | `roles/content-strategist/workflow.md` | "Content Strategist, [do task]" | Execute Campaign with Marketing & SEO |
| 36 | Incident Commander | Incident response, triage, SEV management | `roles/incident-commander/contract.md` | — | `roles/incident-commander/workflow.md` | "/incident [signal]" | Respond to Incident with responders |
| 37 | Review Facilitator | Structured review of code, design, docs | `roles/review-facilitator/contract.md` | — | `roles/review-facilitator/workflow.md` | "/review [artifact]" | Conduct Review with reviewers |
| 38 | Interviewer | Structured interviews, user research, synthesis | `roles/interviewer/contract.md` | — | `roles/interviewer/workflow.md` | "/interview [topic]" | Conduct Interview with subject |
| 39 | Mediator | Facilitated negotiation, conflict resolution | `roles/mediator/contract.md` | — | `roles/mediator/workflow.md` | "/negotiate [issue]" | Facilitate Negotiation with parties |
| 40 | Retro Facilitator | Retrospectives, root cause analysis, improvement | `roles/retro-facilitator/contract.md` | — | `roles/retro-facilitator/workflow.md` | "/retro [period]" | Conduct Retrospective with team |
| 41 | Hackathon Champion | Hackathon organization, mentoring, demo day | `roles/hackathon-champion/contract.md` | — | `roles/hackathon-champion/workflow.md` | "/hackathon [theme]" | Run Hackathon with participants |
| 42 | Onboarding Buddy | New hire onboarding, mentoring, ramp-up | `roles/onboarding-buddy/contract.md` | — | `roles/onboarding-buddy/workflow.md` | "/onboard [role]" | Execute Onboarding with newcomer |
| 43 | Tactical Commander | Continuous thread, dynamic role dispatch | `roles/tactical-commander/contract.md` | — | `roles/tactical-commander/workflow.md` | "/tactical" | Run Tactical Thread with dynamic roles |

## Step → Procedure Reference
| Step ID | Procedure File | Used By |
|---------|---------------|---------|
| sdlc/select | `config/sdlc-models.md` | PM, Architect, EM |
| sdlc/selection-store | `objectives/00-select-sdlc.md` | PM, Architect, EM |
| req/gather | `procedures/01-requirements/01-requirements-gathering.md` | PM |
| req/analysis | `procedures/01-requirements/02-requirements-analysis.md` | BA |
| req/prd | `procedures/01-requirements/03-prd.md` | PM |
| req/signoff | `procedures/01-requirements/04-requirements-review-and-signoff.md` | PM |
| design/arch | `procedures/02-design/01-system-architecture.md` | Architect |
| design/spec | `procedures/02-design/02-technical-specification.md` | Tech Lead |
| design/db | `procedures/02-design/03-database-design.md` | Backend |
| design/api | `procedures/02-design/04-api-design.md` | Backend |
| design/threat | `procedures/02-design/06-threat-modeling.md` | Security |
| design/review | `procedures/02-design/05-design-review.md` | Tech Lead |
| dev/planning | `procedures/03-development/01-sprint-planning.md` | EM |
| dev/analysis | `procedures/03-development/02-codebase-analysis.md` | Tech Lead / Dev |
| dev/standards | `procedures/03-development/03-coding-standards.md` | Tech Lead |
| dev/impl | `procedures/03-development/04-implementation.md` | Dev |
| dev/review | `procedures/03-development/05-code-review.md` | Tech Lead |
| dev/unit | `procedures/03-development/06-unit-testing.md` | Dev |
| dev/integration | `procedures/03-development/07-integration.md` | Backend/DevOps |
| qa/plan | `procedures/04-qa/01-test-planning.md` | QA |
| qa/cases | `procedures/04-qa/02-test-case-development.md` | QA |
| qa/functional | `procedures/04-qa/03-functional-testing.md` | QA |
| qa/nonfunctional | `procedures/04-qa/04-non-functional-testing.md` | QA |
| qa/regression | `procedures/04-qa/05-regression-testing.md` | QA |
| qa/bugs | `procedures/04-qa/06-bug-tracking.md` | QA |
| qa/uat | `procedures/04-qa/07-uat.md` | PM |
| qa/pentest | `procedures/04-qa/09-security-pentest.md` | Security |
| qa/signoff | `procedures/04-qa/08-qa-signoff.md` | QA |
| deploy/plan | `procedures/05-deployment/01-release-planning.md` | PM |
| deploy/staging | `procedures/05-deployment/02-staging-deployment.md` | DevOps |
| deploy/prod | `procedures/05-deployment/03-production-deployment.md` | DevOps |
| deploy/post | `procedures/05-deployment/04-post-deployment.md` | DevOps |
| ops/monitor | `procedures/06-maintenance/01-monitoring-and-observability.md` | DevOps |
| ops/hotfix | `procedures/06-maintenance/02-hotfix-process.md` | Dev |
| ops/feedback | `procedures/06-maintenance/03-feedback-loop.md` | EM / PM |
| debate/trigger | `debate/01-debate-trigger.md` | Facilitator |
| debate/panel | `debate/02-debate-panel.md` | Facilitator |
| debate/rounds | `debate/03-debate-rounds.md` | Panelists |
| debate/resolution | `debate/04-debate-resolution.md` | Facilitator |
| debate/log | `debate/05-debate-log.md` | Scribe |
| incident/detect | `incident/01-detect-triage.md` | Incident Commander |
| incident/diagnose | `incident/02-diagnose.md` | Incident Commander |
| incident/mitigate | `incident/03-mitigate.md` | Incident Commander |
| incident/resolve | `incident/04-resolve.md` | Incident Commander |
| incident/postmortem | `incident/05-postmortem.md` | Incident Commander |
| review/prepare | `review/01-prepare.md` | Review Facilitator |
| review/present | `review/02-present.md` | Review Facilitator |
| review/discuss | `review/03-discuss.md` | Review Facilitator |
| review/decide | `review/04-decide.md` | Review Facilitator |
| review/log | `review/05-log.md` | Review Facilitator |
| interview/plan | `interview/01-plan.md` | Interviewer |
| interview/conduct | `interview/02-conduct.md` | Interviewer |
| interview/synthesize | `interview/03-synthesize.md` | Interviewer |
| interview/decide | `interview/04-decide.md` | Interviewer |
| interview/log | `interview/05-log.md` | Interviewer |
| negotiation/prepare | `negotiation/01-prepare.md` | Mediator |
| negotiation/discuss | `negotiation/02-discuss.md` | Mediator |
| negotiation/negotiate | `negotiation/03-negotiate.md` | Mediator |
| negotiation/agree | `negotiation/04-agree.md` | Mediator |
| negotiation/log | `negotiation/05-log.md` | Mediator |
| retro/set-stage | `retrospective/01-set-stage.md` | Retro Facilitator |
| retro/gather-data | `retrospective/02-gather-data.md` | Retro Facilitator |
| retro/insights | `retrospective/03-generate-insights.md` | Retro Facilitator |
| retro/actions | `retrospective/04-decide-actions.md` | Retro Facilitator |
| retro/log | `retrospective/05-log.md` | Retro Facilitator |
| hackathon/pitch | `hackathon/01-pitch.md` | Hackathon Champion |
| hackathon/plan | `hackathon/02-plan.md` | Hackathon Champion |
| hackathon/build | `hackathon/03-build.md` | Hackathon Champion |
| hackathon/demo | `hackathon/04-demo.md` | Hackathon Champion |
| hackathon/followup | `hackathon/05-followup.md` | Hackathon Champion |
| onboarding/plan | `onboarding/01-plan.md` | Onboarding Buddy |
| onboarding/orient | `onboarding/02-orient.md` | Onboarding Buddy |
| onboarding/learn | `onboarding/03-learn.md` | Onboarding Buddy |
| onboarding/check | `onboarding/04-check.md` | Onboarding Buddy |
| onboarding/ramp | `onboarding/05-ramp.md` | Onboarding Buddy |
| tactical/activate | `tactical/01-activate.md` | Tactical Commander |
| tactical/dispatch | `tactical/02-dispatch.md` | Tactical Commander |
| tactical/track | `tactical/03-track.md` | Tactical Commander |
| tactical/decide | `tactical/04-decide.md` | Tactical Commander |
| tactical/summarize | `tactical/05-summarize.md` | Tactical Commander |
