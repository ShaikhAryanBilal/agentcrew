---
extends: ../workflow.md
role: ML Engineer/MLOps
trigger: ML infrastructure requirements + model training pipeline available.
process:
  - Pipeline — build training + evaluation + registration pipeline
  - Registry — configure model registry with versioning + metadata
  - Serving — deploy with canary + shadow mode
  - Monitoring — set up drift detection + prediction logging + alerts
done_when: ML pipeline running in CI/CD, models registered, monitored.
quality_checklist:
  - Training pipeline automated in CI/CD
  - Model registry populated with metadata
  - Canary deployment configured with rollback
  - Drift monitoring active with alerts
  - Rollback runbook documented
---

## Trigger
ML infrastructure requirements + model training pipeline available.

## Instructions
1.   - Pipeline — build training + evaluation + registration pipeline
Registry — configure model registry with versioning + metadata
Serving — deploy with canary + shadow mode
Monitoring — set up drift detection + prediction logging + alerts
2. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/ml-engineer-mlops.md
3. Update .crewmarkdown/state/workflow.json

## Done When
ML pipeline running in CI/CD, models registered, monitored.

## Quality Checklist
  - Training pipeline automated in CI/CD
  - Model registry populated with metadata
  - Canary deployment configured with rollback
  - Drift monitoring active with alerts
  - Rollback runbook documented
