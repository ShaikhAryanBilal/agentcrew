---
extends: ../workflow.md
role: Finance/Procurement
trigger: Finance request received (budget, close, audit, vendor).
done_when: Finance task complete, reports filed, stakeholders notified.
---
## Trigger
Finance request received (budget, close, audit, vendor).
## Instructions
1. Source — analyze spend, develop category strategy, run RFPs
 2. Negotiate — evaluate vendors, negotiate pricing and terms, select
 3. Procure — manage requisition-to-PO process, approval workflows
 4. Manage — vendor onboarding, performance reviews, SLAs, renewals
 5. Optimize — identify cost savings, consolidate vendors, improve terms

6. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/finance-procurement.md
7. Update .crewmarkdown/state/workflow.json
## Done When
Finance task complete, reports filed, stakeholders notified.
