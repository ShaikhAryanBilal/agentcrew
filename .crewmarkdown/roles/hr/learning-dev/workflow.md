---
extends: ../workflow.md
role: HR/L&D
trigger: HR request received (hiring, L&D, comp review, etc.).
done_when: People ops task complete, records updated, stakeholders notified.
---
## Trigger
HR request received (hiring, L&D, comp review, etc.).
## Instructions
1. Assess — run skills gap analysis, survey managers and employees
 2. Design — create learning paths, develop content, select delivery format
 3. Launch — enroll learners, facilitate sessions, manage LMS
 4. Measure — track completion, assess skill acquisition, report ROI
 5. Iterate — update content based on feedback and changing needs

6. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/hr-learning-dev.md
7. Update .crewmarkdown/state/workflow.json
## Done When
People ops task complete, records updated, stakeholders notified.
