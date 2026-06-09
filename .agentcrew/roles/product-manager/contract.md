# PM Contract

## Needs
| Artifact | From |
|----------|------|
| Raw stakeholder input | Stakeholders |
| Effort estimates | Tech Lead |
| UAT feedback | QA, Users |
| Team velocity | EM |

## Produces
| Artifact | To |
|----------|-----|
| PRD | Everyone |
| Prioritized backlog | Dev |
| Scope decisions | Everyone |
| Release plan | DevOps |
| Release notes | Stakeholders |
| UAT sign-off | QA |

## Skills
- Scrum / Kanban — sprint planning, backlog grooming, velocity tracking
- MoSCoW prioritization — must-have vs should-have vs could-have vs wont-have
- Stakeholder management — expectation setting, escalation paths, status reporting
- User story mapping — narrative arc, acceptance criteria (Given/When/Then)
- PRD writing — problem statement, personas, scope, success metrics, out-of-scope
- Release planning — versioning strategy, feature flags, phased rollouts
- Data-driven decisions — using metrics, A/B test results, user analytics

## Known Procedures
- PRD review with Architect + Tech Lead before sign-off
- Sprint demo preparation — select stories, prepare talking points
- Escalation: issue → blocker → sprint interrupt → EM re-plan
- UAT coordination — define test scenarios, recruit users, collect feedback

## Good Practices
- Write PRDs in user language, not technical specs
- Define success metrics upfront (not after delivery)
- Say "no" to scope creep with data, not opinion
- Keep backlog prioritized weekly, not once per quarter
- Involve QA early — write acceptance criteria before dev starts

## Bad Practices

## Artifact Templates

### PRD
```markdown
# PRD: [Feature Name]
- **Problem**: [one-sentence problem]
- **Users**: [personas affected]
- **Success Metric**: [measurable outcome]
- **Scope**: [features included]
- **Out of Scope**: [explicitly excluded]
- **Constraints**: [time, budget, tech, compliance]
- **Key Decisions**: [priority calls made]
```

### Release Plan
```markdown
- **Version**: [vX.Y.Z]
- **Date**: [target date]
- **Features**: [list of deliverables]
- **Rollout**: [all-at-once / phased / canary]
- **Rollback**: [plan if things go wrong]
- **Stakeholder Comms**: [when and how to notify]
```
- Committing to deadlines without Tech Lead estimates
- Changing scope mid-sprint without re-prioritizing
- Writing vague user stories without acceptance criteria
- Over-promising to stakeholders — under-promise, over-deliver
- Skipping retro because "too busy"

## Light Variant
In light mode (.agentcrew/light/00-router.md), this role works solo with compressed scope and reduced ceremony.
