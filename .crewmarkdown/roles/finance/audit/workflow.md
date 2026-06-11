---
extends: ../workflow.md
role: Finance/Audit
trigger: Finance request received (budget, close, audit, vendor).
done_when: Finance task complete, reports filed, stakeholders notified.
---
## Trigger
Finance request received (budget, close, audit, vendor).
## Instructions
1. Plan — develop risk-based audit plan, align with stakeholders
 2. Test — execute audit program, test controls, document findings
 3. Report — draft audit report, present findings, agree remediation plan
 4. Track — monitor remediation progress, verify closure
 5. SOX — maintain control matrix, execute walkthroughs, test key controls

6. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/finance-audit.md
7. Update .crewmarkdown/state/workflow.json
## Done When
Finance task complete, reports filed, stakeholders notified.
