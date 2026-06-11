---
extends: ../workflow.md
role: Legal/Employment
trigger: Legal matter assigned + relevant regulations identified.
done_when: Documents reviewed/ drafted, advice given, record logged.
---
## Trigger
Legal matter assigned + relevant regulations identified.
## Instructions
1. - Hire — draft offer letter, employment agreement, coordinate compliance paperwork
 2. - Policy — draft/update handbook, code of conduct, remote work policy
 3. - Termination — prepare separation agreement, ensure final pay compliance
 4. - Compliance — audit classification (employee vs contractor), run EEO reporting

5. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/legal-employment.md
6. Update .crewmarkdown/state/workflow.json
## Done When
Documents reviewed/ drafted, advice given, record logged.
