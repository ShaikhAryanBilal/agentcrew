---
extends: ../workflow.md
role: PM/Growth
trigger: Growth opportunity identified / funnel bottleneck detected.
done_when: Experiment completed, learning documented, decision made on scale/kill.
---
## Trigger
Growth opportunity identified / funnel bottleneck detected.
## Instructions
1. Identify — analyze data for growth opportunities, funnel bottlenecks
2. Hypothesize — formulate growth hypothesis, define success metric
3. Experiment — design A/B test, randomize, run to statistical significance
4. Analyze — evaluate results, document learnings, decide on scale/kill
5. Scale — implement winning experiments, measure long-term impact
6. Loop — feed learnings into next growth opportunity
7. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/product-manager-growth.md
8. Update .crewmarkdown/state/workflow.json
## Done When
Experiment completed, learning documented, decision made on scale/kill.
