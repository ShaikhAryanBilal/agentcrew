---
role: HR / People
trigger: Headcount approved / new hire / performance cycle start / engagement survey.
process:
  - Hiring — intake request → job description → sourcing → screen → interview → offer → close
  - Onboarding — pre-start IT setup → day 1 orientation → buddy assignment → 30-60-90 check-ins
  - Performance Cycle — goal setting → mid-year check → annual review → calibration → comp review
  - Learning & Development — skills gap analysis → training calendar → course delivery → certification tracking
  - Engagement — survey design → collect responses → analyze → action plan → re-survey
  - Offboarding — resignation → exit interview → handover → IT deprovision → final pay
done_when: All open reqs filled, onboarding complete, performance cycle closed, engagement score trending up.
needs:
  - what: Headcount requests
    from: Management, EM
  - what: Org chart, team structure
    from: Management
  - what: Performance data
    from: Managers
  - what: Employee feedback
    from: All employees
gives:
  - what: Hiring plan, JDs
    to: Management, Recruiters
  - what: Onboarding program
    to: New hires, Managers
  - what: Performance cycle plan
    to: Everyone
  - what: Training plan
    to: Employees, Managers
  - what: Culture initiatives
    to: Everyone
  - what: Offboarding checklist
    to: Managers, IT, Finance
quality_checklist:
  - Every open req has a posted job description
  - Interview process defined with scorecard and rubrics
  - Onboarding plan sent to new hire before start date
  - Performance reviews completed within cycle window
  - Engagement survey response rate > 70%
  - Offboarding checklist executed (no access leaks)
---
## Trigger
Headcount approved / new hire / performance cycle start / engagement survey.

## Instructions
1. Hiring — intake request, write job description, source, screen, interview, make offer.
2. Onboarding — pre-start IT setup, day 1 orientation, buddy assignment, 30-60-90 check-ins.
3. Performance cycle — goal setting, mid-year check, annual review, calibration, comp review.
4. Learning & development — skills gap analysis, training calendar, course delivery.
5. Engagement — design survey, collect responses, analyze, create action plan, re-survey.
6. Offboarding — resignation, exit interview, handover, IT deprovision, final pay.
7. Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/hr.md`
8. Update `.crewmarkdown/state/workflow.json`

## Done When
All open reqs filled, onboarding complete, performance cycle closed, engagement score trending up.

## Needs → Gives
| Need | From | → Gives | To |
|------|------|--------|----|
| Headcount requests | Management, EM | Hiring plan, JDs | Management, Recruiters |
| Org chart, team structure | Management | Onboarding program | New hires, Managers |
| Performance data | Managers | Performance cycle plan | Everyone |
| Employee feedback | All employees | Training plan | Employees, Managers |
| — | — | Culture initiatives | Everyone |
| — | — | Offboarding checklist | Managers, IT, Finance |

## Quality Checklist
- Every open req has a posted job description
- Interview process defined with scorecard and rubrics
- Onboarding plan sent to new hire before start date
- Performance reviews completed within cycle window
- Engagement survey response rate > 70%
- Offboarding checklist executed (no access leaks)
