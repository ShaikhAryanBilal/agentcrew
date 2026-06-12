---
routing:
  - request: Select SDLC model / Choose methodology
    synonyms: methodology, process model, waterfall, agile, hybrid
    objective: Select SDLC Model
    squad: PM, Architect, EM
    mode: Squad
    confidence: high
  - request: Build this feature / Full lifecycle
    synonyms: full stack, end to end, complete project, new system
    objective: Orchestrator routes O1?O2?...?O6
    squad: All roles
    mode: Orchestrate
    confidence: high
  - request: Define requirements / Write PRD
    synonyms: spec, specification, user stories, backlog, scope, needs
    objective: Clarify Vision
    squad: PM, BA
    mode: Squad
    confidence: high
  - request: Design the system / Architecture
    synonyms: tech design, system design, high level, component, module, microservices
    objective: Design Solution
    squad: Architect, UX, Security
    mode: Squad
    confidence: high
  - request: Plan the sprint / Break down work
    synonyms: schedule, timeline, estimate, task breakdown, assign, capacity
    objective: Plan Work
    squad: EM, PM, Tech Lead
    mode: Squad
    confidence: high
  - request: Implement X / Write code for X
    synonyms: code, develop, program, build feature, add feature, create module, react, vue, angular, svelte, node, express, fastify, nextjs, nuxt, api, worker, cron, ui, component, page
    objective: Build Feature
    squad: Dev(s), Tech Lead, Mobile Dev
    mode: Solo/Squad
    confidence: high
  - request: Build a mobile app / iOS/Android feature
    synonyms: mobile, app, ios, android, swift, kotlin, react native, flutter
    objective: Build Feature
    squad: Mobile Dev, Backend
    mode: Solo/Squad
    confidence: high
  - request: Build data pipeline / ETL
    synonyms: data pipeline, etl, elt, data warehouse, lake, ingest, stream
    objective: Build Feature
    squad: Data Engineer
    mode: Solo
    confidence: high
  - request: Train a model / ML pipeline
    synonyms: ml, machine learning, ai, model, training, inference, llm, rag
    objective: Build Feature
    squad: ML Engineer, Data Engineer
    mode: Solo/Squad
    confidence: high
  - request: Write API docs / Document the API
    synonyms: api documentation, openapi, swagger, endpoint docs, reference
    objective: Build Feature
    squad: Technical Writer, Backend
    mode: Solo/Squad
    confidence: high
  - request: Write release notes / Changelog
    synonyms: changelog, release, version notes, what's new
    objective: Ship Release
    squad: Technical Writer, DevOps, PM
    mode: Solo/Squad
    confidence: medium
  - request: Write user guide / Onboarding docs
    synonyms: user manual, how to guide, getting started, tutorial, documentation
    objective: Solo role call ? Technical Writer
    squad: Technical Writer
    mode: Solo
    confidence: high
  - request: Test this / QA sign-off / Security audit
    synonyms: qa, quality, testing, test cases, regression, pentest, security review
    objective: Verify Quality
    squad: QA, Security, Dev(s), ML Engineer
    mode: Squad
    confidence: high
  - request: Deploy to prod / Release
    synonyms: deployment, go live, launch, release, ci/cd, pipeline publish
    objective: Ship Release
    squad: DevOps, PM, Technical Writer
    mode: Solo/Squad
    confidence: high
  - request: Set up monitoring / Hotfix / Feedback
    synonyms: monitor, observability, alert, dashboard, incident, oncall
    objective: Operate & Learn
    squad: DevOps, EM, PM
    mode: Solo/Squad
    confidence: high
  - request: Model monitoring / Data quality alert
    synonyms: model drift, data quality, pipeline alert, anomaly, schema change
    objective: Operate & Learn
    squad: ML Engineer, Data Engineer
    mode: Solo
    confidence: medium
  - request: Meeting mode / /meeting / brainstorm [topic]
    synonyms: /meeting, meeting, brainstorm, discuss, convene, sync, huddle
    objective: Conduct Meeting
    squad: Meeting Facilitator + dynamic roles
    mode: Meeting
    confidence: high
  - request: Retro / retrospective
    synonyms: retro, retrospective, sprint review, lessons learned, postmortem
    objective: Operate & Learn / Conduct Meeting
    squad: EM, PM, Meeting Facilitator
    mode: Meeting
    confidence: high
  - request: Single role call: "[Role], do X"
    synonyms: roledo, solo role, single role, just this role
    objective: Load role's contract.md directly
    squad: That role only
    mode: Solo
    confidence: high
  - request: Incident mode / /incident [signal]
    synonyms: incident, outage, sev1, sev2, production issue, down, broken in prod, on-call
    objective: Respond to Incident
    squad: Incident Commander + dynamic roles
    mode: Incident
    confidence: high
  - request: Review mode / /review [artifact]
    synonyms: review, code review, design review, PR review, walkthrough, inspect
    objective: Conduct Review
    squad: Review Facilitator + dynamic roles
    mode: Review
    confidence: high
  - request: Interview mode / /interview [topic]
    synonyms: interview, user research, stakeholder interview, discovery, 1-on-1
    objective: Conduct Interview
    squad: Interviewer + dynamic roles
    mode: Interview
    confidence: high
  - request: Negotiation mode / /negotiate [issue]
    synonyms: negotiate, mediation, conflict, trade-off, dispute, bargaining
    objective: Facilitate Negotiation
    squad: Mediator + dynamic roles
    mode: Negotiation
    confidence: high
  - request: Retro mode / /retro [period]
    synonyms: retro, retrospective, sprint retro, lessons learned, reflect
    objective: Conduct Retrospective
    squad: Retro Facilitator + dynamic roles
    mode: Retrospective
    confidence: high
  - request: Hackathon mode / /hackathon [theme]
    synonyms: hackathon, hack, innovation sprint, buildathon, codefest
    objective: Run Hackathon
    squad: Hackathon Champion + dynamic roles
    mode: Hackathon
    confidence: high
  - request: Onboarding mode / /onboard [role]
    synonyms: onboarding, onboard, new hire, ramp up, orientation, buddy
    objective: Execute Onboarding
    squad: Onboarding Buddy + dynamic roles
    mode: Onboarding
    confidence: high
  - request: Tactical mode / /tactical [thread]
    synonyms: tactical, always on, continuous, standing, persistent, ongoing, never stop, live thread
    objective: Run Tactical Thread
    squad: Tactical Commander + dynamic roles
    mode: Tactical
    confidence: high
  - request: Create campaign / Launch marketing
    synonyms: campaign, marketing, go to market, gtm, content, ad
    objective: Execute Campaign
    squad: Marketing, Sales, PM
    mode: Squad
    confidence: high
  - request: Budget planning / Financial review
    synonyms: budget, finance, cost, spending, forecast, revenue, p&l
    objective: Plan Work
    squad: Finance, Management, PM
    mode: Squad
    confidence: high
  - request: Hiring / People ops / Onboard
    synonyms: hire, recruit, onboarding, people, hr, culture, talent
    objective: Execute People Ops
    squad: HR, Management, EM
    mode: Squad
    confidence: high
objectives_index:
  - id: obj/select-sdlc
    file: objectives/00-select-sdlc.md
    squad: PM, Architect, EM
    default_mode: Squad
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
    squad: EM, PM, Tech Lead, Finance, HR, General Management
    default_mode: Squad
  - id: obj/build-feature
    file: objectives/04-build-feature.md
    squad: Dev(s), Mobile Dev, Data Engineer, ML Engineer, Tech Lead, Technical Writer, Marketing, Sales
    default_mode: Squad
  - id: obj/verify-quality
    file: objectives/05-verify-quality.md
    squad: QA, Security, Dev(s), ML Engineer
    default_mode: Squad
  - id: obj/ship-release
    file: objectives/06-ship-release.md
    squad: DevOps, PM, Technical Writer
    default_mode: Solo/Squad
  - id: obj/operate-learn
    file: objectives/07-operate-learn.md
    squad: DevOps, EM, PM, ML Engineer, Data Engineer
    default_mode: Solo/Squad
  - id: obj/conduct-meeting
    file: objectives/08-conduct-meeting.md
    squad: Meeting Facilitator + dynamic roles
    default_mode: Meeting
  - id: obj/execute-campaign
    file: objectives/09-execute-campaign.md
    squad: Marketing, Sales, PM
    default_mode: Squad
  - id: obj/execute-people-ops
    file: objectives/10-people-ops.md
    squad: HR, Management, EM
    default_mode: Squad
  - id: obj/respond-incident
    file: incident/
    squad: Incident Commander + dynamic roles
    default_mode: Incident
  - id: obj/conduct-review
    file: review/
    squad: Review Facilitator + dynamic roles
    default_mode: Review
  - id: obj/conduct-interview
    file: interview/
    squad: Interviewer + dynamic roles
    default_mode: Interview
  - id: obj/facilitate-negotiation
    file: negotiation/
    squad: Mediator + dynamic roles
    default_mode: Negotiation
  - id: obj/conduct-retrospective
    file: retrospective/
    squad: Retro Facilitator + dynamic roles
    default_mode: Retrospective
  - id: obj/run-hackathon
    file: hackathon/
    squad: Hackathon Champion + dynamic roles
    default_mode: Hackathon
  - id: obj/execute-onboarding
    file: onboarding/
    squad: Onboarding Buddy + dynamic roles
    default_mode: Onboarding
  - id: obj/run-tactical
    file: tactical/
    squad: Tactical Commander + dynamic roles
    default_mode: Tactical
phase_mapping:
  - phase: config/sdlc-models.md
    maps_to: Select SDLC Model (optional)
    used_by: PM, Architect, EM
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
  - phase: roles/marketing/
    maps_to: Execute Campaign
    used_by: Marketing, Sales, PM
  - phase: roles/sales/
    maps_to: Execute Campaign, Build Feature
    used_by: Sales, Marketing
  - phase: roles/hr/
    maps_to: Execute People Ops, Plan Work
    used_by: HR, Management, EM
  - phase: roles/finance/
    maps_to: Plan Work, Operate & Learn
    used_by: Finance, Management
  - phase: roles/general-management/
    maps_to: Cross-cutting (all objectives)
    used_by: General Management
  - phase: incident/
    maps_to: Incident response (any objective)
    used_by: Incident Commander + responders
  - phase: review/
    maps_to: Structured review (any artifact)
    used_by: Review Facilitator + reviewers
  - phase: interview/
    maps_to: Structured interview (any topic)
    used_by: Interviewer + subject
  - phase: negotiation/
    maps_to: Facilitated negotiation (any conflict)
    used_by: Mediator + parties
  - phase: retrospective/
    maps_to: Retrospective (any period)
    used_by: Retro Facilitator + team
  - phase: hackathon/
    maps_to: Hackathon (any theme)
    used_by: Hackathon Champion + participants
  - phase: onboarding/
    maps_to: Onboarding (any role)
    used_by: Onboarding Buddy + newcomer
  - phase: tactical/
    maps_to: Tactical mode (continuous thread)
    used_by: Tactical Commander + dynamic roles
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
    must_pass: DAST + pentest + supply chain scan � no Critical/High
  - gate: SG4
    before: Production deploy
    in_objective: Ship Release
    must_pass: All scans clean, no Critical/High bugs, SBOM verified
---

# Objective-Based Workflow � Router

## Model
```
Request → Objective → Squad(s) → Artifacts → Acceptance → Log → State
```
CrewMarkdown routes any request — engineering, business, creative, or operational — to the right objective. SDLC model selection (`obj/select-sdlc`) is optional. Only invoked when explicitly requested ("Select SDLC model"). Default objective ordering: O1→O2→...→O8 for engineering; non-engineering objectives (campaign, people-ops, meeting modes) route independently.

## Routing Strategy

### 1. Semantic Matching (Primary)
Match request text against routing entries using this priority:
1. **Exact match** � request matches `request:` field ? 100% confidence, route immediately
2. **Synonym match** � request contains keywords from `synonyms:` field ? 90% confidence, route immediately
3. **Partial match** � request shares 2+ tokens with `request:` or `synonyms:` ? 75% confidence, route with note
4. **Fuzzy match** � request semantically related (e.g., "fix login" ? Implement, not QA) ? 50% confidence, ask user to confirm
5. **No match** � no routing entry triggers ? 0% confidence, ask "Which objective?"

### 2. Confidence Scoring
Each routing entry has a `confidence:` level (high/medium/low) that reflects how well-defined the match is:
- **high** � keyword set is specific, unlikely to false-positive. Route silently.
- **medium** � broader terms, minor ambiguity possible. Add brief rationale when routing.
- **low** � very general, easy to misroute. Always ask user to confirm.

### 3. Routing Cache
Recent routing decisions are stored in `.crewmarkdown/state/routing-cache.json`:
```
{ "cache": [
  { "request": "need login page", "objective": "Build Feature", "timestamp": "..." },
  { "request": "design reports dashboard", "objective": "Design Solution", "timestamp": "..." }
]}
```
- Before scanning the routing table, check cache for exact or near-exact past matches
- Cache keeps last 50 entries; evict oldest when full
- Add entry to cache after every successful route

### 4. Feedback Loop
When a route is wrong and user corrects it:
1. Log the correction to `.crewmarkdown/state/reroute-feedback.json`
2. Agent updates routing table mentally (add missing keyword/synonym to match future requests)
3. Cache the corrected route so same request routes correctly next time

### 5. Sub-Spec Resolution (Role Level)
After routing to an objective, each role's contract may be refined per **sub-spec**:
1. Scan request for `keywords:` in each sub-spec's YAML frontmatter (`roles/<family>/<subspec>/contract.md`)
2. Match found → load sub-spec contract + workflow; parent cached as fallback
3. No match → load parent (generic)
4. See `procedures/role-subspec.md` for full schema and inheritance rules

### 6. /reroute Command
If user types `/reroute <objective-id>` at any point:
1. Abandon current objective immediately (log as cancelled)
2. Load the specified objective
3. Log the reroute to `.crewmarkdown/state/reroute-feedback.json`
4. Update `.crewmarkdown/state/routing-cache.json` with the corrected mapping

## Modes
| Mode | Pattern | When |
|------|---------|------|
| Solo | "[Role], do [task]" | Single role |
| Squad | "Squad ([roles]), achieve [objective]" | Multiple roles, one objective |
| Orchestrate | "Build this [feature/system]" | Multiple objectives |
| Meeting | "/meeting [topic]" | Brainstorm, discuss, converge |
| Debate | "Debate [topic]" | Evidence-based decision from multiple perspectives |
| Incident | "/incident [signal]" | Production issue, outage, SEV |
| Review | "/review [artifact]" | Code, design, PRD, test plan, docs review |
| Interview | "/interview [topic]" | User research, stakeholder discovery |
| Negotiation | "/negotiate [issue]" | Conflict resolution, trade-off bargaining |
| Retrospective | "/retro [period]" | Sprint/project reflection, continuous improvement |
| Hackathon | "/hackathon [theme]" | Rapid prototyping, innovation sprint |
| Onboarding | "/onboard [role]" | New hire ramp-up, guided orientation |
| Tactical | "/tactical" | Continuous always-on thread, dynamic role dispatch per request |

## State
`.crewmarkdown/state/workflow.json` tracks: achievedObjectives, currentObjective, artifacts, phaseGates
`.crewmarkdown/state/sdlc-selection.json` (optional) tracks: selected model, phase order, gate overrides
`.crewmarkdown/state/routing-cache.json` tracks: recent request?objective mappings (last 50)
`.crewmarkdown/state/reroute-feedback.json` tracks: user corrections for continuous improvement

## Logging
`.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/<role>.md`

## SDLC Model Routing (optional)
If `sdlc-selection.json` exists, Orchestrator applies model-specific phase ordering. Otherwise, default sequential order O1?O2?...?O8.
