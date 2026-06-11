---
extends: ../workflow.md
role: ML Engineer/CV
trigger: CV requirements + labeled image/video data available.
process:
  - Image pipeline — load, augment, normalize, batch
  - Model — select backbone, train detector/segmenter, evaluate on mAP
  - Post-processing — NMS, confidence threshold tuning
  - Serving — TensorRT export, Triton deployment, latency monitoring
done_when: Model trained, evaluated on mAP, served with GPU inference.
quality_checklist:
  - mAP = baseline on held-out test set
  - Augmentation pipeline documented
  - Inference latency within SLA (p95 < 100ms per image)
  - Class-wise AP reported (not just mean)
---

## Trigger
CV requirements + labeled image/video data available.

## Instructions
1.   - Image pipeline — load, augment, normalize, batch
Model — select backbone, train detector/segmenter, evaluate on mAP
Post-processing — NMS, confidence threshold tuning
Serving — TensorRT export, Triton deployment, latency monitoring
2. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/ml-engineer-cv.md
3. Update .crewmarkdown/state/workflow.json

## Done When
Model trained, evaluated on mAP, served with GPU inference.

## Quality Checklist
  - mAP = baseline on held-out test set
  - Augmentation pipeline documented
  - Inference latency within SLA (p95 < 100ms per image)
  - Class-wise AP reported (not just mean)
