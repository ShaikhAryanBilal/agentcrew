---
extends: ../workflow.md
role: HR/Comp-Benefits
trigger: HR request received (hiring, L&D, comp review, etc.).
done_when: People ops task complete, records updated, stakeholders notified.
---
## Trigger
HR request received (hiring, L&D, comp review, etc.).
## Instructions
1. Benchmark — survey market data, compare internal bands, identify gaps
 2. Review — prepare merit matrix, manage promotion adjustments, get approvals
 3. Communicate — prepare total comp statements, educate employees on equity
 4. Benefits — manage enrollment, evaluate vendor proposals, negotiate rates
 5. Compliance — run pay equity analysis, prepare annual filings, audit bands

6. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/hr-comp-benefits.md
7. Update .crewmarkdown/state/workflow.json
## Done When
People ops task complete, records updated, stakeholders notified.
