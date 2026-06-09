# Objectives

8 lifecycle objectives — each with goal, squad, schedule, artifacts, and acceptance criteria.

1. **Clarify Vision** → 2. **Design Solution** → 3. **Plan Work** → 4. **Build Feature** → 5. **Verify Quality** → 6. **Ship Release** → 7. **Operate & Learn**

Also includes **Meeting Mode** as a cross-cutting objective.

## Request → Objective Routing

| You Say | Objective | Squad |
|---------|-----------|-------|
| *"Define requirements" / "Write PRD"* | 1. Clarify Vision | PM, BA |
| *"Design the system" / "Architecture"* | 2. Design Solution | Architect, UX, Security |
| *"Plan the sprint" / "Break down work"* | 3. Plan Work | EM, PM, Tech Lead |
| *"Implement X" / "Write code for X"* | 4. Build Feature | Dev(s), Tech Lead |
| *"Test this" / "QA sign-off"* | 5. Verify Quality | QA, Security |
| *"Deploy to prod" / "Release"* | 6. Ship Release | DevOps, PM |
| *"Set up monitoring" / "Hotfix"* | 7. Operate & Learn | DevOps, EM, PM |
| *"/meeting brainstorm" / "Meeting on [topic]"* | 8. Conduct Meeting | Meeting Facilitator + dynamic roles |

## Security Gates

| Gate | Before | Must Pass |
|------|--------|-----------|
| **SG1** | Design review | Threat model complete, high threats mitigated |
| **SG2** | Merge to main | SAST + secret scan + dependency scan clean |
| **SG3** | QA sign-off | DAST + pentest + supply chain scan — no Critical/High |
| **SG4** | Production deploy | All scans clean, SBOM verified |

---

## Objective 1: Clarify Vision

**Squad:** PM + BA (Squad mode)

Transform raw stakeholder input into a signed-off PRD with clear scope, priorities, and user stories.

**Schedule:**
```
PM:  Intake → PRD Draft → Review → Sign-off
BA:  Analysis → User Stories
```
**Parallel:** PM gathers requirements while BA analyzes.
**Sequential:** PRD needs analysis done.

**Artifacts:**
- PM: Structured requirement list, PRD document, sign-off record
- BA: Gap analysis, prioritized reqs, P0/P1 user stories

**Acceptance:**
- All requirements captured and classified ([F], [NF], [B], [T], [C])
- MoSCoW priorities assigned (P0-P3), scope frozen
- P0/P1 user stories written with 2-3 acceptance criteria each
- PRD reviewed and signed off

---

## Objective 2: Design Solution

**Squad:** Architect + UX + Security (Squad mode)

Design system architecture, UX, and security model to satisfy the signed-off PRD.

**Schedule:**
```
Architect: Options → ADRs → Tech Spec → Design Review
UX:        Research → Wireframes → Prototype
Security:  Threat Model → Security Reqs
```

**Artifacts:**
- Architect: ADRs, C4 diagrams, tech spec, DB design, API contracts
- UX Designer: User flows, wireframes, prototypes, design assets
- Security: Threat model with mitigations

**Security Gate: SG1** — Threat model must be complete, all high-severity threats must have documented mitigations.

---

## Objective 3: Plan Work

**Squad:** EM + PM + Tech Lead (Squad mode)

Break approved design into actionable tasks, assign capacity, create sprint plan.

**Artifacts:**
- EM: Sprint plan with capacity allocation
- PM: Prioritized backlog with sprint goal
- Tech Lead: Technical task breakdown with estimates

**Acceptance:**
- All tasks estimated, capacity allocated, sprint goal defined
- Dependencies mapped, team committed

---

## Objective 4: Build Feature

**Squad:** Dev(s) + Tech Lead (Solo/Squad mode)

Implement, review, unit test, and integrate working code per approved design.

**Schedule:**
```
Dev:  Analysis → Implementation → PR
Tech Lead:                    Code Review → Merge
Dev:                Unit Tests → Integration
```

**Artifacts:**
- Dev: Implementation code, unit tests (≥80% coverage), integration tests
- Tech Lead: Code review comments, merge commit

**Security Gate: SG2** — Before merge to main: SAST, secret detection, dependency scan must pass.

---

## Objective 5: Verify Quality

**Squad:** QA + Security (Squad mode)

Validate feature meets quality standards through testing, security validation, and acceptance.

**Artifacts:**
- QA: Test plan, test cases, bug reports, execution report, QA sign-off
- Security: Pentest report, supply chain scan, SG3 gate status

**Security Gate: SG3** — DAST + pentest + supply chain scan: no Critical or High findings.

---

## Objective 6: Ship Release

**Squad:** DevOps + PM (Solo/Squad mode)

Deploy verified build to production with rollout plan, monitoring, and rollback.

**Artifacts:**
- PM: Release plan, release notes
- DevOps: Deployment runbook, deployed build, monitoring dashboards

**Security Gate: SG4** — All scans clean, no Critical/High bugs, SBOM verified before production traffic.

---

## Objective 7: Operate & Learn

**Squad:** DevOps + EM + PM (Solo/Squad mode)

Monitor production system, respond to incidents, gather feedback, plan improvements.

**Artifacts:**
- DevOps: Monitoring dashboards, incident reports, runbooks
- EM: Retro reports, velocity metrics, process improvements
- PM: User feedback summary, feature requests

---

## Objective 8: Conduct Meeting

**Squad:** Meeting Facilitator + Dynamic Roles (Meeting mode)

Run a structured real-time meeting with dynamically assembled roles to brainstorm, decide, and produce action items for a given topic.

**Schedule:**
```
Facilitator: Convene → Agenda → Brainstorm → Decisions → Action Items → Minutes
Dynamic roles join based on topic relevance
```

**Role Selection** (topic keywords determine spawned roles):
- **feature, product, roadmap** → PM, BA, Architect
- **architecture, design, tech-stack** → Architect, Tech Lead, Security, DevOps
- **sprint, planning, capacity** → EM, PM, Tech Lead
- **bug, defect, qa, quality** → QA, Security, relevant Dev
- **deploy, release, ci/cd** → DevOps, PM, Tech Lead
- **security, threat** → Security, Architect, DevOps
- **data, pipeline, etl, database** → Data Engineer, Backend, Architect
- **ui, ux, design, frontend** → UX Designer, Frontend
- **general, brainstorm, ideation** → PM, Architect, Tech Lead

**Artifacts:**
- Meeting Facilitator: Agenda, discussion summary, decision log, action items, minutes
- Dynamic roles: Ideas, opinions, perspectives, proposals

---

*MIT Licensed — Built for AI-native development*
