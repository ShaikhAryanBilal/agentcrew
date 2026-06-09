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
---

# AgentCrew — Crew Orchestration Hub

## Invocation Patterns

### 1. Solo
Syntax: `"[Role], do [task]"`
Effect: Load contract → load workflow → produce artifact → log → update state

### 2. Squad
Syntax: `"Squad ([roles]), achieve [objective]"`
Effect: Load objective → each role loads contract+workflow → parallel/sequential work → assemble → verify acceptance → log → update state

### 3. Orchestrate
Syntax: `"Build [feature]" / "Full SDLC for [project]"`
Effect: Orchestrator decomposes → orders objectives → assigns squads → monitors → verifies → reports → logs → updates state

### 4. Meeting
Syntax: `"/meeting [topic]" / "brainstorm [topic]"`
Effect: Load meeting objective → spawn roles via matrix → convene → brainstorm → decide → action items → minutes → log

## State
`.agentcrew/state/workflow.json` — achieved objectives + artifacts
`.agentcrew/log/<objective-id>/<role>/<timestamp>.md` — per-role logs
