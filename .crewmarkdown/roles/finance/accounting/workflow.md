---
extends: ../workflow.md
role: Finance/Accounting
trigger: Finance request received (budget, close, audit, vendor).
done_when: Finance task complete, reports filed, stakeholders notified.
---
## Trigger
Finance request received (budget, close, audit, vendor).
## Instructions
1. Close — run month-end close, prepare journal entries, reconcile accounts
 2. Process — manage AP (invoices, payments) and AR (invoicing, collections)
 3. Report — prepare P&L, balance sheet, cash flow, BS flux analysis
 4. Comply — maintain GAAP compliance, support annual audit
 5. Improve — automate manual processes, shorten close cycle

6. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/finance-accounting.md
7. Update .crewmarkdown/state/workflow.json
## Done When
Finance task complete, reports filed, stakeholders notified.
