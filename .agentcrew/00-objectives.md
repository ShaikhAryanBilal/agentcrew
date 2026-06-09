---
routing:
  - request: Build this feature / Full SDLC
    objective: Orchestrator routes O1→O2→...→O6
    squad: All roles
    mode: Orchestrate
  - request: Define requirements / Write PRD
    objective: Clarify Vision
    squad: PM, BA
    mode: Squad
  - request: Design the system / Architecture
    objective: Design Solution
    squad: Architect, UX, Security
    mode: Squad
  - request: Plan the sprint / Break down work
    objective: Plan Work
    squad: EM, PM, Tech Lead
    mode: Squad
  - request: Implement X / Write code for X
    objective: Build Feature
    squad: Dev(s), Tech Lead, Mobile Dev
    mode: Solo/Squad
  - request: Build a mobile app / iOS/Android feature
    objective: Build Feature
    squad: Mobile Dev, Backend
    mode: Solo/Squad
  - request: Build data pipeline / ETL
    objective: Build Feature
    squad: Data Engineer
    mode: Solo
  - request: Train a model / ML pipeline
    objective: Build Feature
    squad: ML Engineer, Data Engineer
    mode: Solo/Squad
  - request: Write API docs / Document the API
    objective: Build Feature
    squad: Technical Writer, Backend
    mode: Solo/Squad
  - request: Write release notes / Changelog
    objective: Ship Release
    squad: Technical Writer, DevOps, PM
    mode: Solo/Squad
  - request: Write user guide / Onboarding docs
    objective: Solo role call → Technical Writer
    squad: Technical Writer
    mode: Solo
  - request: Test this / QA sign-off / Security audit
    objective: Verify Quality
    squad: QA, Security, Dev(s), ML Engineer
    mode: Squad
  - request: Deploy to prod / Release
    objective: Ship Release
    squad: DevOps, PM, Technical Writer
    mode: Solo/Squad
  - request: Set up monitoring / Hotfix / Feedback
    objective: Operate & Learn
    squad: DevOps, EM, PM
    mode: Solo/Squad
  - request: Model monitoring / Data quality alert
    objective: Operate & Learn
    squad: ML Engineer, Data Engineer
    mode: Solo
  - request: Meeting mode / /meeting / brainstorm [topic]
    objective: Conduct Meeting
    squad: Meeting Facilitator + dynamic roles
    mode: Meeting
  - request: Retro / retrospective
    objective: Operate & Learn / Conduct Meeting
    squad: EM, PM, Meeting Facilitator
    mode: Meeting
  - request: Single role call: "[Role], do X"
    objective: Load role's contract.md directly
    squad: That role only
    mode: Solo
objectives_index:
  - id: obj/clarify-vision
    file: objectives/01-clarify-vision.md
    squad: PM, BA
    default_mode: Squad
  - id: obj/design-solution
    file: objectives/02-design-solution.md
    squad: Architect, UX, Security, Data Engineer
    default_mode: Squad
  - id: obj/plan-work
    file: objectives/03-plan-work.md
    squad: EM, PM, Tech Lead
    default_mode: Squad
  - id: obj/build-feature
    file: objectives/04-build-feature.md
    squad: Dev(s), Mobile Dev, Data Engineer, ML Engineer, Tech Lead, Technical Writer
    default_mode: Squad
  - id: obj/verify-quality
    file: objectives/05-verify-quality.md
    squad: QA, Security, Dev(s), ML Engineer
    default_mode: Squad
  - id: obj/ship-release
    file: objectives/06-ship-release.md
    squad: DevOps, PM, Technical Writer
    default_mode: Squad
  - id: obj/operate-learn
    file: objectives/07-operate-learn.md
    squad: DevOps, EM, PM, ML Engineer, Data Engineer
    default_mode: Solo/Squad
  - id: obj/conduct-meeting
    file: objectives/08-conduct-meeting.md
    squad: Meeting Facilitator + dynamic roles
    default_mode: Meeting
phase_mapping:
  - phase: procedures/01-requirements/
    maps_to: Clarify Vision
    used_by: PM, BA
  - phase: procedures/02-design/
    maps_to: Design Solution
    used_by: Architect, UX, Security
  - phase: procedures/03-development/
    maps_to: Plan Work + Build Feature
    used_by: EM, Tech Lead, Dev(s)
  - phase: procedures/04-qa/
    maps_to: Verify Quality
    used_by: QA, Security
  - phase: procedures/05-deployment/
    maps_to: Ship Release
    used_by: DevOps, PM
  - phase: procedures/06-maintenance/
    maps_to: Operate & Learn
    used_by: DevOps, EM, PM
  - phase: debate/
    maps_to: Cross-cutting (any objective)
    used_by: Facilitator, Panelists
  - phase: meeting/
    maps_to: Meeting mode (any topic)
    used_by: Meeting Facilitator, dynamic roles
security_gates:
  - gate: SG1
    before: Design review
    in_objective: Design Solution
    must_pass: Threat model complete, high threats mitigated
  - gate: SG2
    before: Merge to main
    in_objective: Build Feature
    must_pass: SAST + secret scan + dependency scan clean
  - gate: SG3
    before: QA sign-off
    in_objective: Verify Quality
    must_pass: DAST + pentest + supply chain scan — no Critical/High
  - gate: SG4
    before: Production deploy
    in_objective: Ship Release
    must_pass: All scans clean, no Critical/High bugs, SBOM verified
---

# Objective-Based SDLC — Router

## Model
```
Request → Objective → Squad(s) → Artifacts → Acceptance → Log → State
```

## Modes
| Mode | Pattern | When |
|------|---------|------|
| Solo | "[Role], do [task]" | Single role |
| Squad | "Squad ([roles]), achieve [objective]" | Multiple roles, one objective |
| Orchestrate | "Build this [feature/system]" | Multiple objectives |

## State
`.agentcrew/state/workflow.json` tracks: achievedObjectives, currentObjective, artifacts, phaseGates

## Logging
`.agentcrew/log/<objective-id>/<role>/<timestamp>.md`
