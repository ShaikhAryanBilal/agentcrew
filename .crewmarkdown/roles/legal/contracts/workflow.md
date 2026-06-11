---
extends: ../workflow.md
role: Legal/Contracts
trigger: Legal matter assigned + relevant regulations identified.
done_when: Documents reviewed/ drafted, advice given, record logged.
---
## Trigger
Legal matter assigned + relevant regulations identified.
## Instructions
1. - Intake — gather business context, identify contract type, select template
 2. - Draft — customize template, flag risk items, send for business review
 3. - Negotiate — track redlines, manage fallback positions, escalate if needed
 4. - Execute — coordinate signatures, archive executed copy
 5. - Post-sign — set renewal reminders, populate CLM with key terms

6. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/legal-contracts.md
7. Update .crewmarkdown/state/workflow.json
## Done When
Documents reviewed/ drafted, advice given, record logged.
