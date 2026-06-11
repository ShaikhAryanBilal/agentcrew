---
extends: ../workflow.md
role: Legal/IP
trigger: Legal matter assigned + relevant regulations identified.
done_when: Documents reviewed/ drafted, advice given, record logged.
---
## Trigger
Legal matter assigned + relevant regulations identified.
## Instructions
1. - Patent — evaluate invention, run prior art search, file provisional/non-provisional
 2. - Trademark — run clearance search, file application, monitor for conflicts
 3. - OSS — audit codebase dependencies, flag copyleft licenses, resolve compliance
 4. - Trade secrets — identify crown jewels, implement protection measures
 5. - Licensing — draft/negotiate IP clauses in commercial agreements

6. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/legal-ip.md
7. Update .crewmarkdown/state/workflow.json
## Done When
Documents reviewed/ drafted, advice given, record logged.
