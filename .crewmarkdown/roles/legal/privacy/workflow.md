---
extends: ../workflow.md
role: Legal/Privacy
trigger: Legal matter assigned + relevant regulations identified.
done_when: Documents reviewed/ drafted, advice given, record logged.
---
## Trigger
Legal matter assigned + relevant regulations identified.
## Instructions
1. - Map — conduct data inventory and processing mapping
 2. - Assess — run DPIA for high-risk processing activities
 3. - Consent — audit current consent flows, design compliant mechanisms
 4. - DSR — implement process for data subject requests (access/delete/port)
 5. - Monitor — track regulatory changes, update policies annually

6. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/legal-privacy.md
7. Update .crewmarkdown/state/workflow.json
## Done When
Documents reviewed/ drafted, advice given, record logged.
