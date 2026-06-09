# Procedures

Step-by-step guides organized by SDLC phase — the how-to references roles use during execution.

## Phase Mapping

| Phase | Maps To Objective | Used By |
|-------|-------------------|---------|
| Requirements | Clarify Vision | PM, BA |
| Design | Design Solution | Architect, UX, Security |
| Development | Plan Work + Build Feature | EM, Tech Lead, Dev(s) |
| QA | Verify Quality | QA, Security |
| Deployment | Ship Release | DevOps, PM |
| Maintenance | Operate & Learn | DevOps, EM, PM |
| Meeting | Conduct Meeting | Meeting Facilitator + dynamic roles |

---

## Requirements Phase

4 steps guiding PM and BA through gathering, analyzing, documenting, and signing off requirements.

| Step | File | Owner |
|------|------|-------|
| 1. Requirements Gathering | `01-requirements-gathering.md` | PM |
| 2. Requirements Analysis | `02-requirements-analysis.md` | BA |
| 3. PRD Writing | `03-prd.md` | PM |
| 4. Review & Sign-off | `04-requirements-review-and-signoff.md` | PM |

Location: `.agentcrew/procedures/01-requirements/`

---

## Design Phase

6 steps guiding Architect, UX, and Security through system design.

| Step | File | Owner |
|------|------|-------|
| 1. System Architecture | `01-system-architecture.md` | Architect |
| 2. Technical Specification | `02-technical-specification.md` | Tech Lead |
| 3. Database Design | `03-database-design.md` | Backend |
| 4. API Design | `04-api-design.md` | Backend |
| 5. Design Review | `05-design-review.md` | Tech Lead |
| 6. Threat Modeling | `06-threat-modeling.md` | Security |

Location: `.agentcrew/procedures/02-design/`

---

## Development Phase

7 steps guiding EM, Tech Lead, and Developers through implementation.

| Step | File | Owner |
|------|------|-------|
| 1. Sprint Planning | `01-sprint-planning.md` | EM |
| 2. Codebase Analysis | `02-codebase-analysis.md` | Tech Lead / Dev |
| 3. Coding Standards | `03-coding-standards.md` | Tech Lead |
| 4. Implementation | `04-implementation.md` | Dev |
| 5. Code Review | `05-code-review.md` | Tech Lead |
| 6. Unit Testing | `06-unit-testing.md` | Dev |
| 7. Integration | `07-integration.md` | Backend/DevOps |

Location: `.agentcrew/procedures/03-development/`

---

## QA Phase

9 steps guiding QA and Security through validation.

| Step | File | Owner |
|------|------|-------|
| 1. Test Planning | `01-test-planning.md` | QA |
| 2. Test Case Development | `02-test-case-development.md` | QA |
| 3. Functional Testing | `03-functional-testing.md` | QA |
| 4. Non-Functional Testing | `04-non-functional-testing.md` | QA |
| 5. Regression Testing | `05-regression-testing.md` | QA |
| 6. Bug Tracking | `06-bug-tracking.md` | QA |
| 7. UAT | `07-uat.md` | PM |
| 8. QA Sign-off | `08-qa-signoff.md` | QA |
| 9. Security Pentest | `09-security-pentest.md` | Security |

Location: `.agentcrew/procedures/04-qa/`

---

## Deployment Phase

4 steps guiding DevOps and PM through release.

| Step | File | Owner |
|------|------|-------|
| 1. Release Planning | `01-release-planning.md` | PM |
| 2. Staging Deployment | `02-staging-deployment.md` | DevOps |
| 3. Production Deployment | `03-production-deployment.md` | DevOps |
| 4. Post-Deployment | `04-post-deployment.md` | DevOps |

Location: `.agentcrew/procedures/05-deployment/`

---

## Maintenance Phase

3 steps + cross-cutting guides for production operations.

| Step | File | Owner |
|------|------|-------|
| 1. Monitoring & Observability | `01-monitoring-and-observability.md` | DevOps |
| 2. Hotfix Process | `02-hotfix-process.md` | Dev |
| 3. Feedback Loop | `03-feedback-loop.md` | EM / PM |

Location: `.agentcrew/procedures/06-maintenance/`

---

## Cross-Cutting Procedures

| Procedure | File | Used By |
|-----------|------|---------|
| ADR Template | `procedures/adr/01-adr-template.md` | Everyone |
| ADR Workflow | `procedures/adr/02-adr-workflow.md` | Tech Lead, Architect |
| Postmortem Template | `procedures/postmortem/01-postmortem-template.md` | Everyone |
| Postmortem Workflow | `procedures/postmortem/02-postmortem-workflow.md` | Facilitator |
| Supply Chain Security | `procedures/supply-chain-security.md` | Security, DevOps |

*All 33 procedures are in `.agentcrew/procedures/` organized by SDLC phase.*

---

*MIT Licensed — Built for AI-native development*
