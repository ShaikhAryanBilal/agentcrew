---
extends: ../workflow.md
role: HR/Recruiting
trigger: HR request received (hiring, L&D, comp review, etc.).
done_when: People ops task complete, records updated, stakeholders notified.
---
## Trigger
HR request received (hiring, L&D, comp review, etc.).
## Instructions
1. Intake — review req, define role, align on target profile and level
 2. Source — run Boolean search, post job, engage passive candidates
 3. Screen — review resumes, conduct phone screens, coordinate interviews
 4. Interview — schedule panels, collect feedback, debrief with hiring team
 5. Offer — prepare offer, negotiate, send, close accepted candidate
 6. Onboard — coordinate day-1, equipment, benefits, buddy

7. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/hr-recruiting.md
8. Update .crewmarkdown/state/workflow.json
## Done When
People ops task complete, records updated, stakeholders notified.
