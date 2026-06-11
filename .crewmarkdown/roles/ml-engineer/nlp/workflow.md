---
extends: ../workflow.md
role: ML Engineer/NLP
trigger: NLP requirements + training data available.
process:
  - Text pipeline — ingest, clean, tokenize, augment
  - Model — select pretrained, fine-tune, evaluate on BLEU/ROUGE
  - RAG — chunk corpus, build embedding index, set up retriever
  - Serving — deploy with vLLM, set up monitoring for drift
done_when: Model fine-tuned, evaluated, served with monitoring.
quality_checklist:
  - Dataset versioned and splits documented
  - Evaluation on held-out test set = baseline
  - RAG retrieval recall > 80% on edge cases
  - Serving latency within SLA (p95 < 2s)
  - Drift monitoring configured
---

## Trigger
NLP requirements + training data available.

## Instructions
1.   - Text pipeline — ingest, clean, tokenize, augment
Model — select pretrained, fine-tune, evaluate on BLEU/ROUGE
RAG — chunk corpus, build embedding index, set up retriever
Serving — deploy with vLLM, set up monitoring for drift
2. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/ml-engineer-nlp.md
3. Update .crewmarkdown/state/workflow.json

## Done When
Model fine-tuned, evaluated, served with monitoring.

## Quality Checklist
  - Dataset versioned and splits documented
  - Evaluation on held-out test set = baseline
  - RAG retrieval recall > 80% on edge cases
  - Serving latency within SLA (p95 < 2s)
  - Drift monitoring configured
