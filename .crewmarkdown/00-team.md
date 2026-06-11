---
roles:
  - name: Product Manager
    contract: roles/product-manager/contract.md
    workflow: roles/product-manager/workflow.md
    specialty: Requirements, priorities, sign-off
  - name: Business Analyst
    contract: roles/ba/contract.md
    workflow: roles/ba/workflow.md
    specialty: Requirements analysis, user stories
  - name: Solution Architect
    contract: roles/architect/contract.md
    workflow: roles/architect/workflow.md
    specialty: Architecture, tech stack
  - name: Tech Lead
    contract: roles/tech-lead/contract.md
    workflow: roles/tech-lead/workflow.md
    specialty: Standards, code quality, ADRs
  - name: Frontend Developer
    contract: roles/frontend/contract.md
    workflow: roles/frontend/workflow.md
    specialty: UI, client logic
  - name: Backend Developer
    contract: roles/backend/contract.md
    workflow: roles/backend/workflow.md
    specialty: API, data, services
  - name: Mobile Developer
    contract: roles/mobile-dev/contract.md
    workflow: roles/mobile-dev/workflow.md
    specialty: iOS/Android, offline, push
  - name: UX Designer
    contract: roles/ux-designer/contract.md
    workflow: roles/ux-designer/workflow.md
    specialty: Research, wireframes, visual
  - name: Data Engineer
    contract: roles/data-engineer/contract.md
    workflow: roles/data-engineer/workflow.md
    specialty: ETL/ELT, data warehouse, pipelines
  - name: ML Engineer
    contract: roles/ml-engineer/contract.md
    workflow: roles/ml-engineer/workflow.md
    specialty: Models, training, serving, drift
  - name: QA Engineer
    contract: roles/qa/contract.md
    workflow: roles/qa/workflow.md
    specialty: Testing, quality, sign-off
  - name: Security Engineer
    contract: roles/security/contract.md
    workflow: roles/security/workflow.md
    specialty: Threat model, pentest, SBOM
  - name: DevOps Engineer
    contract: roles/devops/contract.md
    workflow: roles/devops/workflow.md
    specialty: Infrastructure, CI/CD
  - name: Engineering Manager
    contract: roles/engineering-manager/contract.md
    workflow: roles/engineering-manager/workflow.md
    specialty: Sprint planning, capacity, retro
  - name: Technical Writer
    contract: roles/technical-writer/contract.md
    workflow: roles/technical-writer/workflow.md
    specialty: API docs, user guides, release notes
  - name: Debator
    contract: roles/debator/contract.md
    workflow: roles/debator/workflow.md
    specialty: Structured debate, scoring, resolution
  - name: Orchestrator
    contract: roles/orchestrator/contract.md
    workflow: roles/orchestrator/workflow.md
    specialty: Multi-objective coordinator
  - name: Meeting Facilitator
    contract: roles/meeting-facilitator/contract.md
    workflow: roles/meeting-facilitator/workflow.md
    specialty: Meeting mode, agenda, brainstorm, decisions, action items
  - name: Marketing
    contract: roles/marketing/contract.md
    workflow: roles/marketing/workflow.md
    specialty: Campaigns, content, brand, GTM, analytics
  - name: Sales
    contract: roles/sales/contract.md
    workflow: roles/sales/workflow.md
    specialty: Pipeline, forecasts, proposals, account management
  - name: HR / People
    contract: roles/hr/contract.md
    workflow: roles/hr/workflow.md
    specialty: Hiring, onboarding, performance, culture, compliance
  - name: Finance / Operations
    contract: roles/finance/contract.md
    workflow: roles/finance/workflow.md
    specialty: Budgets, reporting, compliance, vendor management
  - name: General Management
    contract: roles/general-management/contract.md
    workflow: roles/general-management/workflow.md
    specialty: OKRs, strategy, resource allocation, cross-team coordination
  - name: SEO Specialist
    contract: roles/seo-specialist/contract.md
    workflow: roles/seo-specialist/workflow.md
    specialty: Technical SEO, keyword strategy, content optimization, link building
  - name: UX Researcher
    contract: roles/ux-researcher/contract.md
    workflow: roles/ux-researcher/workflow.md
    specialty: User research, usability testing, personas, journey mapping
  - name: Data Scientist
    contract: roles/data-scientist/contract.md
    workflow: roles/data-scientist/workflow.md
    specialty: Statistical analysis, ML, experimentation, A/B testing
  - name: Growth / Product Marketing
    contract: roles/growth-marketing/contract.md
    workflow: roles/growth-marketing/workflow.md
    specialty: Growth experiments, funnel optimization, activation, retention
  - name: Customer Success Manager
    contract: roles/customer-success/contract.md
    workflow: roles/customer-success/workflow.md
    specialty: Onboarding, adoption, QBRs, churn reduction, expansion
  - name: Site Reliability Engineer
    contract: roles/sre/contract.md
    workflow: roles/sre/workflow.md
    specialty: SLOs, incident response, capacity planning, reliability
  - name: Legal / Compliance
    contract: roles/legal/contract.md
    workflow: roles/legal/workflow.md
    specialty: Contracts, privacy, regulatory compliance, risk management
  - name: Business Development
    contract: roles/bizdev/contract.md
    workflow: roles/bizdev/workflow.md
    specialty: Partnerships, channel development, deal structuring, alliances
  - name: Solutions Architect
    contract: roles/solutions-architect/contract.md
    workflow: roles/solutions-architect/workflow.md
    specialty: Technical pre-sales, solution design, POCs, integration architecture
  - name: Content Strategist
    contract: roles/content-strategist/contract.md
    workflow: roles/content-strategist/workflow.md
    specialty: Content strategy, editorial calendar, SEO content, brand voice
---

# CrewMarkdown � Crew Orchestration Hub

## Invocation Patterns

### 1. Solo
Syntax: `"[Role], do [task]"`
Effect: Load contract ? load workflow ? produce artifact ? log ? update state

### 2. Squad
Syntax: `"Squad ([roles]), achieve [objective]"`
Effect: Load objective ? each role loads contract+workflow ? parallel/sequential work ? assemble ? verify acceptance ? log ? update state

### 3. Orchestrate
Syntax: `"Build [feature]" / "Full lifecycle for [project]"`
Effect: Orchestrator decomposes ? orders objectives ? assigns squads ? monitors ? verifies ? reports ? logs ? updates state

### 4. Meeting
Syntax: `"/meeting [topic]" / "brainstorm [topic]"`
Effect: Load meeting objective ? spawn roles via matrix ? convene ? brainstorm ? decide ? action items ? minutes ? log

### 5. Sub-Spec Invocation
Syntax: `"[Role]/<subspec>, [task]"` or implicit via keyword match
Effect: Routing scans `keywords:` in sub-spec contracts → if match found, load sub-spec instead of parent. Parent cached as fallback. Sub-specs live at `roles/<family>/<subspec>/{contract,workflow}.md`

### 6. Reroute
Syntax: `"/reroute <objective-id>"` or `"wrong route, should be <objective-id>"`
Effect: Abandon current objective (log as cancelled) ? load specified objective ? log correction to `state/reroute-feedback.json` ? update `state/routing-cache.json`

## State
`.crewmarkdown/state/workflow.json` � achieved objectives + artifacts
`.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/<role>.md` � per-role logs per request
