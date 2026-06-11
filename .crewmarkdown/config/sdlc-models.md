---
models:
  waterfall:
    alias: Waterfall
    style: Linear-sequential
    description: Phases completed one after another with no overlap. Full phase completion before next begins.
  v-model:
    alias: V-Model
    style: Verification & Validation parallel
    description: Each development phase has a corresponding test phase. Forms a V shape.
  spiral:
    alias: Spiral
    style: Risk-driven iterative
    description: Repeated cycles (spirals) each with planning, risk analysis, engineering, evaluation.
  agile:
    alias: Agile (Scrum)
    style: Iterative-incremental
    description: Timeboxed sprints with cross-functional teams. Continuous delivery, adaptation.
  iterative:
    alias: Iterative
    style: Repeated refinement
    description: Build rough → refine in cycles. Each iteration improves fidelity.
  incremental:
    alias: Incremental
    style: Piecewise delivery
    description: System built in increments. Each increment adds working functionality.
  big-bang:
    alias: Big Bang
    style: Monolithic delivery
    description: All development done in one phase, then tested and deployed as one unit.
  rad:
    alias: RAD
    style: Rapid prototyping
    description: Fast prototyping cycles with heavy user feedback. Timeboxed iterations.

selection_criteria:
  - dimension: Requirement clarity
    low: Waterfall, V-Model
    medium: Spiral, Incremental
    high: Agile, Iterative, RAD
  - dimension: Risk tolerance
    low: Waterfall, V-Model
    medium: Incremental, Iterative
    high: Spiral, Agile, RAD
  - dimension: Team size
    small: Agile, RAD, Iterative
    medium: Incremental, Spiral
    large: Waterfall, V-Model
  - dimension: Project complexity
    low: Big Bang, RAD
    medium: Agile, Iterative, Incremental
    high: Spiral, Waterfall, V-Model
  - dimension: User involvement
    low: Waterfall, V-Model, Big Bang
    medium: Spiral, Incremental
    high: Agile, Iterative, RAD
  - dimension: Delivery speed
    slow: Waterfall, V-Model
    medium: Spiral, Incremental, Iterative
    fast: Agile, RAD, Big Bang
---

# SDLC Models — Full Definitions

## 1. Waterfall

### Summary
Linear-sequential model where each phase must be fully completed before the next begins. No phase overlap. Best when requirements are stable and fully understood upfront.

### Phase Map
```
Requirements → Design → Implementation → Testing → Deployment → Maintenance
```

### Phase Details

| Phase | AgentCraft Objective | Roles | Artifacts | Gates |
|-------|---------------------|-------|-----------|-------|
| Requirements | Clarify Vision | PM, BA | PRD, user stories, reqs matrix | SG0: PRD signed off |
| Design | Design Solution | Architect, UX, Security, Tech Lead | Architecture spec, DB schema, API spec, threat model, wireframes | SG1: Threat model complete |
| Implementation | Build Feature | Dev(s), Tech Lead, Technical Writer | Source code, unit tests, integration tests, API docs | SG2: SAST + secret + dep scan clean |
| Testing | Verify Quality | QA, Security, Dev(s) | Test cases, test reports, pentest report, UAT sign-off | SG3: DAST + pentest + supply chain clean |
| Deployment | Ship Release | DevOps, PM, Technical Writer | Release notes, deploy plan, SBOM, prod deploy log | SG4: All scans clean, SBOM verified |
| Maintenance | Operate & Learn | DevOps, EM, PM | Monitoring dashboards, feedback log, hotfixes | — |

### Transitions
| From | To | Criteria |
|------|----|----------|
| Requirements | Design | PRD signed off, scope frozen |
| Design | Implementation | Architecture approved, threat model complete, design reviewed |
| Implementation | Testing | Code merged, unit tests pass, integration tests pass, SG2 cleared |
| Testing | Deployment | All test suites pass, pentest clean, UAT signed off, SG3 cleared |
| Deployment | Maintenance | Production deploy confirmed, monitoring active, SBOM verified, SG4 cleared |

### Gate Sequence
SG0 → SG1 → SG2 → SG3 → SG4 (strict sequential)

### Risk Pattern
Requirements drift → cascading cost. Late discovery means full rework of earlier phases.

---

## 2. V-Model

### Summary
Verification & Validation model. Each development phase has a corresponding test phase. Testing is planned in parallel with development.

### Phase Map
```
Requirements ←→ Acceptance Testing
  Design ←→ System Testing
  Architecture ←→ Integration Testing
  Module Design ←→ Unit Testing
    Coding
```

### Phase Details

| Phase | Corresponding Test Phase | AgentCraft Objective | Roles | Artifacts | Gates |
|-------|------------------------|---------------------|-------|-----------|-------|
| Requirements | Acceptance Testing | Clarify Vision + Verify Quality | PM, BA, QA | PRD, acceptance test plan | SG0: Reqs review + test plan |
| Design (System) | System Testing | Design Solution + Verify Quality | Architect, UX, Security, QA | System arch, system test plan | SG1: Design + test plan review |
| Architecture | Integration Testing | Design Solution + Verify Quality | Architect, Tech Lead, QA | Module spec, integration test plan | — |
| Module Design | Unit Testing | Design Solution | Architect, Backend, Frontend | Detailed design, unit test spec | — |
| Coding | — | Build Feature | Dev(s), Tech Lead | Source code | SG2: Code quality gates |

### Transitions
| From | To | Criteria |
|------|----|----------|
| Requirements | Acceptance Testing | PRD approved, acceptance criteria defined |
| System Design | System Testing | Architecture approved, system test cases ready |
| Architecture | Integration Testing | Module interfaces defined, integration test cases ready |
| Module Design | Unit Testing | Detailed design complete, unit test cases ready |
| Coding | → all test phases active after coding | Code complete, SG2 cleared |

### Gate Sequence
SG0 (reqs+test plan) → SG1 (design+test plan) → SG2 (code complete)

### Risk Pattern
Heavy documentation overhead. Test plans become outdated if requirements change.

---

## 3. Spiral

### Summary
Risk-driven iterative model. Each spiral passes through planning, risk analysis, engineering, and evaluation. Number of spirals determined by risk.

### Phase Map
```
Spiral 1: Plan → Risk Analysis → Prototype → Evaluate → Next spiral or done
Spiral 2: Plan → Risk Analysis → Refine → Evaluate → Next spiral or done
...repeat until acceptable risk level...
```

### Phase Details (per spiral)

| Spiral Step | AgentCraft Objective | Roles | Artifacts | Gates |
|-------------|---------------------|-------|-----------|-------|
| Plan | Plan Work | EM, PM, Tech Lead | Sprint plan, spiral scope, effort estimate | — |
| Risk Analysis | Design Solution (risk track) | Architect, Security, Tech Lead | Risk register, mitigation plan, prototype spec | Risk evaluation gate |
| Engineering (build) | Build Feature | Dev(s), Tech Lead | Prototype code, unit tests, docs | SG2: Code quality |
| Evaluate | Verify Quality + Operate Learn | QA, PM, EM | Test results, stakeholder feedback, risk reassessment | SG3: Risk acceptable? Continue? |

### Transitions
| From | To | Criteria |
|------|----|----------|
| Evaluate | Next spiral | Identified risks remain above threshold, next spiral scoped |
| Evaluate | Ship Release | All risks at acceptable level, product ready |
| Evaluate | Terminate | Risk too high, project cancelled |

### Gate Sequence
Risk evaluation gate at end of each spiral. SG2 per spiral. SG3 at final spiral.

### Risk Pattern
Unlimited spirals if risk never drops. Needs clear "acceptable risk" threshold upfront.

---

## 4. Agile (Scrum)

### Summary
Timeboxed sprints (1-4 weeks). Cross-functional team delivers working increments each sprint. Continuous refinement of backlog.

### Phase Map
```
Backlog Grooming → Sprint Planning → Sprint (Dev + Test) → Sprint Review → Retro → Repeat
```

### Phase Details (per sprint)

| Sprint Event | AgentCraft Objective | Roles | Artifacts | Gates |
|-------------|---------------------|-------|-----------|-------|
| Backlog Grooming | Clarify Vision (ongoing) | PM, BA | Refined backlog, updated user stories | — |
| Sprint Planning | Plan Work | EM, PM, Tech Lead, Dev(s) | Sprint goal, sprint backlog, task breakdown | Sprint scope frozen |
| Sprint Execution | Build Feature + Verify Quality | Dev(s), QA, Tech Lead | Working code, tests, automated test results | SG2: Per PR merge |
| Sprint Review | Verify Quality (demo) | All roles, Stakeholder | Demo, feedback log, updated backlog | Stakeholder sign-off per sprint |
| Retrospective | Operate & Learn | EM, Dev(s), QA, PM | Action items, process improvements | — |

### Transitions
| From | To | Criteria |
|------|----|----------|
| Review | Next sprint planning | Feedback incorporated into backlog |
| Retro | Next sprint planning | Action items documented |
| Final sprint | Ship Release | Product increment accepted, release criteria met |

### Gate Sequence
SG2 per PR within sprint. SG4 at release boundary. Lightweight gates.

### Risk Pattern
Scope creep via continuous backlog refinement. Technical debt if refactoring skipped.

---

## 5. Iterative

### Summary
Repeated refinement cycles. Start with a rough implementation of the whole system, then refine each iteration. Unlike Agile, no fixed timeboxes.

### Phase Map
```
Iteration 1: Rough cut (all layers basic)
Iteration 2: Refine core features
Iteration 3: Polish + edge cases
...repeat until quality threshold met...
```

### Phase Details (per iteration)

| Step | AgentCraft Objective | Roles | Artifacts | Entry Criteria |
|------|---------------------|-------|-----------|---------------|
| Plan iteration scope | Plan Work | PM, EM, Tech Lead | Iteration scope, effort estimate | Previous iteration evaluated |
| Design refinements | Design Solution | Architect, UX | Refined design docs, updated specs | Scope defined |
| Build | Build Feature | Dev(s), Tech Lead | Code, tests | Design updated |
| Evaluate | Verify Quality | QA, PM | Test results, gap analysis | Build complete |
| Retro | Operate & Learn | EM, PM, Dev(s) | Lessons learned, next iteration focus | Evaluate done |

### Transitions
| From | To | Criteria |
|------|----|----------|
| Evaluate | Next iteration | Quality gaps identified, scope for next iteration exists |
| Evaluate | Ship Release | Quality threshold met, no critical gaps remaining |

### Gate Sequence
Per-iteration evaluation gate. SG2 per build within iteration. SG3 at final iteration.

### Risk Pattern
Can cycle indefinitely without clear "done" definition. Needs explicit exit criteria.

---

## 6. Incremental

### Summary
System built and delivered in increments. Each increment adds a complete slice of functionality (design → build → test → deploy). First increment delivers core, later increments add features.

### Phase Map
```
Increment 1: Core (auth, data model, basic UI) → Deploy
Increment 2: Feature set A → Deploy
Increment 3: Feature set B → Deploy
...until feature-complete...
```

### Phase Details (per increment)

| Step | AgentCraft Objective | Roles | Artifacts | Gates |
|------|---------------------|-------|-----------|-------|
| Plan increment | Plan Work + Design Solution | PM, Architect, EM | Increment scope, design delta, plan | Increment scope frozen |
| Build | Build Feature | Dev(s), Tech Lead | Working increment features + tests | SG2: Per PR |
| Verify | Verify Quality | QA, Security | Increment test report, regression pass | SG3: Increment quality gate |
| Deploy | Ship Release | DevOps, PM | Increment deployed, release notes | SG4: Deploy gate |

### Transitions
| From | To | Criteria |
|------|----|----------|
| Deploy (increment N) | Plan (increment N+1) | Increment N deployed and verified |
| Deploy (final) | Operate & Learn | All increments complete, system feature-complete |

### Gate Sequence
SG2 → SG3 → SG4 per increment. Each increment repeats full gate chain.

### Risk Pattern
Integration complexity between increments. Late-arriving increments may require refactoring of early increments.

---

## 7. Big Bang

### Summary
All development done in one phase. No intermediate deliveries. Everything built, then everything tested, then everything deployed. Minimal planning overhead.

### Phase Map
```
Requirements (light) → Build Everything → Test Everything → Deploy
```

### Phase Details

| Phase | AgentCraft Objective | Roles | Artifacts | Gates |
|-------|---------------------|-------|-----------|-------|
| Light Requirements | Clarify Vision | PM, BA | Brief scope doc, feature list | SG0: Scope list approved |
| Build Everything | Build Feature | Dev(s), Tech Lead, All dev roles | Complete source code | SG2: Final code quality sweep |
| Test Everything | Verify Quality | QA, Security, Dev(s) | Full test report, pentest report | SG3: Full suite pass |
| Deploy | Ship Release | DevOps, PM | Deploy log, release notes | SG4: Deploy gate |

### Transitions
| From | To | Criteria |
|------|----|----------|
| Light Requirements | Build | Feature list approved |
| Build | Test | All features code-complete, SG2 cleared |
| Test | Deploy | All tests pass, SG3 cleared |

### Gate Sequence
SG0 → SG2 (late) → SG3 → SG4. No intermediate quality checks.

### Risk Pattern
Highest risk model. Integration issues discovered late. No early feedback. Suitable only for very small projects (< 2 weeks effort) or prototypes.

---

## 8. RAD (Rapid Application Development)

### Summary
Timeboxed prototyping cycles with heavy user feedback. Build → show → refine in rapid loops. Emphasizes speed over documentation.

### Phase Map
```
Requirements Workshop → Prototype Cycle 1 → User Feedback → Refine → Prototype Cycle 2 → ... → Finalize → Deploy
```

### Phase Details

| Phase | AgentCraft Objective | Roles | Artifacts | Gates |
|-------|---------------------|-------|-----------|-------|
| Requirements Workshop | Clarify Vision | PM, BA, UX, Stakeholder | Workshop notes, priority list, scope | Scope agreed |
| Prototype Cycle (each) | Build Feature | Dev(s), UX, Tech Lead | Working prototype, UI mockups | Cycle demo accepted |
| User Feedback | Verify Quality (light) | PM, UX, QA | Feedback log, change requests | — |
| Finalize | Ship Release | DevOps, PM, Technical Writer | Release notes, deploy log, user guide | SG4: Deploy gate |

### Transitions
| From | To | Criteria |
|------|----|----------|
| Requirements Workshop | Prototype Cycle 1 | Priority list agreed |
| User Feedback | Next prototype cycle | Feedback incorporated, scope adjusted |
| User Feedback | Finalize | Product meets user needs, no major changes requested |

### Gate Sequence
Per-cycle acceptance (demo). SG4 at final deployment. Lightweight throughout.

### Risk Pattern
Scope creep via "one more cycle." Needs hard timeboxes. Documentation debt accumulates.
