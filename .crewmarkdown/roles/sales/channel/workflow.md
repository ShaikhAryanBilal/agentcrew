---
extends: ../workflow.md
role: Sales/Channel
---
## Trigger
Sales/Channel task received.
## Instructions
1. Execute per sales/channel specialization.
2. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/sales-channel.md
3. Update .crewmarkdown/state/workflow.json
## Done When
Deliverable produced per sales/channel specialization.
