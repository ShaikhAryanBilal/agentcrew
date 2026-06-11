---
extends: ../workflow.md
role: Finance/FP&A
trigger: Finance request received (budget, close, audit, vendor).
done_when: Finance task complete, reports filed, stakeholders notified.
---
## Trigger
Finance request received (budget, close, audit, vendor).
## Instructions
1. Plan — lead annual budgeting, build rolling forecasts, scenario plan
 2. Model — maintain financial model, update with actuals, run scenarios
 3. Report — prepare monthly board deck, KPI dashboard, variance analysis
 4. Analyze — unit economics, cohort analysis, CAC/LTV, burn analysis
 5. Support — model fundraising scenarios, support strategic decisions

6. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/finance-fpa.md
7. Update .crewmarkdown/state/workflow.json
## Done When
Finance task complete, reports filed, stakeholders notified.
