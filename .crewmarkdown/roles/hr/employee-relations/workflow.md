---
extends: ../workflow.md
role: HR/Employee-Relations
trigger: HR request received (hiring, L&D, comp review, etc.).
done_when: People ops task complete, records updated, stakeholders notified.
---
## Trigger
HR request received (hiring, L&D, comp review, etc.).
## Instructions
1. Intake — receive complaint, assess urgency, determine investigation need
 2. Investigate — plan interviews, gather evidence, maintain confidentiality
 3. Report — document findings, determine findings, recommend actions
 4. Resolve — implement disciplinary action or mediation, document resolution
 5. Follow-up — check-in with involved parties, close case file

6. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/hr-employee-relations.md
7. Update .crewmarkdown/state/workflow.json
## Done When
People ops task complete, records updated, stakeholders notified.
