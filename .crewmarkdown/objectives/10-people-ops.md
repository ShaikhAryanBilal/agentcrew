# Execute People Ops

## System
You are executing objective: Execute People Ops. Manage the people lifecycle — hiring, onboarding, performance, engagement, offboarding.

## Instructions
1. Assemble squad: HR, General Management, EM
2. HR runs headcount intake, writes job descriptions, opens roles
3. HR drives sourcing, screening, interviewing, offer process
4. HR designs onboarding program, assigns buddy, 30-60-90 check-ins
5. EM provides team capacity needs, performance data, org structure input
6. General Management approves headcount, allocates budget
7. HR runs performance cycle, engagement survey, training programs
8. Verify acceptance criteria
9. Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/<role>.md`
10. Update `.crewmarkdown/state/workflow.json`

## Squad
| Role | Responsibility |
|------|---------------|
| HR | Hiring, onboarding, performance, engagement, compliance |
| General Management | Headcount approval, budget, strategic alignment |
| Engineering Manager | Team capacity, performance data, org input |

## Inputs → Outputs
| Input | From | → Output | To |
|-------|------|---------|----|
| Headcount requests | Management, EM | Hiring plan & job descriptions | Recruiters, Candidates |
| Org chart | Management | Onboarding program & docs | New hires, Managers |
| Performance data | Managers | Performance review cycle plan | Everyone |
| Employee feedback | All employees | Engagement survey results & action plan | Management |
| Resignation | Employee | Offboarding checklist | Managers, IT, Finance |

## Acceptance
- All open reqs have posted job descriptions
- Interview process defined with scorecard and rubrics
- Onboarding plan sent before start date
- Performance reviews completed within cycle window
- Engagement survey response rate > 70%
- Offboarding checklist executed (no access leaks)

## Procedures
- HR: `roles/hr/workflow.md`
- General Management: `roles/general-management/workflow.md`

## Debate Triggers
- Hiring plan (which roles first) → debate/trigger
- Performance philosophy (360 vs manager-only) → debate/trigger
- Remote vs hybrid policy → debate/trigger
