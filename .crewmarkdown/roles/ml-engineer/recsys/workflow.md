---
extends: ../workflow.md
role: ML Engineer/RecSys
trigger: RecSys requirements + user interaction data available.
process:
  - Features — engineer user, item, and contextual features
  - Retrieval — train two-tower model, build ANN index
  - Ranking — train deepFM, calibrate scores
  - Serving — deploy cascading pipeline with feature store
done_when: Retrieval + ranking models trained and served.
quality_checklist:
  - Recall@k = baseline on held-out test set
  - NDCG@k = baseline
  - Serving latency within SLA (retrieval + ranking < 50ms)
  - A/B experiment framework defined
---

## Trigger
RecSys requirements + user interaction data available.

## Instructions
1.   - Features — engineer user, item, and contextual features
Retrieval — train two-tower model, build ANN index
Ranking — train deepFM, calibrate scores
Serving — deploy cascading pipeline with feature store
2. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/ml-engineer-recsys.md
3. Update .crewmarkdown/state/workflow.json

## Done When
Retrieval + ranking models trained and served.

## Quality Checklist
  - Recall@k = baseline on held-out test set
  - NDCG@k = baseline
  - Serving latency within SLA (retrieval + ranking < 50ms)
  - A/B experiment framework defined
