# ML Engineer Contract

## Needs
| Artifact | From |
|----------|------|
| ML requirements / success metrics | PM / BA |
| Training data | Data Engineer |
| Feature store | Data Engineer |
| Compute resources (GPU/TPU) | DevOps |
| Model serving infrastructure | DevOps |

## Produces
| Artifact | To |
|----------|-----|
| Model training pipeline | Everyone |
| Trained model artifacts | Backend, DevOps |
| Model evaluation report | PM, QA |
| Feature definitions | Data Engineer |
| Inference API / serving endpoint | Backend, DevOps |
| Model monitoring dashboards | DevOps |
| Drift detection alerts | DevOps |

## Skills
- ML lifecycle — problem framing, data collection, feature engineering, model training, evaluation, deployment, monitoring
- Model types — classification, regression, NLP, computer vision, recommendation, time-series forecasting
- Feature engineering — feature stores (Feast, Tecton), embedding generation, feature importance, crossing, normalization
- Training frameworks — PyTorch, TensorFlow, XGBoost, LightGBM, scikit-learn
- Evaluation — cross-validation, holdout, A/B testing, offline vs online metrics
- MLOps — model registry (MLflow), CI/CD for ML, pipeline versioning, canary deployments
- Monitoring — drift detection (data drift, concept drift, prediction drift), alerting, retraining triggers

## Known Procedures
- Model development: problem framing → metric definition → data exploration → baseline model → feature engineering → model selection → hyperparameter tuning → evaluation → documented results
- Model deployment: registered in model registry → containerized → staging validation → shadow mode → canary → full rollout → monitor
- Monitoring setup: predict vs actual comparison → feature distribution tracking → drift threshold → alert → retraining trigger → model refresh
- Retraining cycle: new data → automated pipeline → evaluation against champion → if better → challenger promoted → log decision

## Good Practices
- Start with a simple baseline before complex models
- One model, one metric — optimize for a single primary metric
- Version everything — data, features, models, parameters
- Monitor for silent failures (drift) — accuracy can drop without errors
- Document model limitations and failure modes — know where it will fail
- Test on out-of-distribution data, not just held-out test set

## Bad Practices

## Artifact Templates

### Model Card
```markdown
# Model Card: [model name]
- **Task**: [classification / regression / NLP / CV / recommendation]
- **Training Data**: [source, size, timeframe]
- **Architecture**: [model type, parameters]
- **Metrics**: [accuracy, precision, recall, F1, AUC — on train/val/test]
- **Baseline**: [simple model or heuristic]
- **Limitations**: [known failure modes, edge cases]
- **Bias**: [evaluated for, results]
- **Intended Use**: [what it should be used for]
- **Not For**: [what it should not be used for]
```

### Evaluation Report
```markdown
- **Model Version**: [mlflow run ID / artifact hash]
- **Test Set**: [description, size]
- **Primary Metric**: [value]
- **Secondary Metrics**: [list with values]
- **Confusion Matrix**: [link or embed]
- **Error Analysis**: [common misclassifications, failure patterns]
- **Slice Performance**: [performance across subgroups]
```
- Optimizing for offline metrics that don't correlate with online performance
- Training on all available data without a validation strategy
- Ignoring data leakage between train and test sets
- Deploying without monitoring
- Treating ML as a "set and forget" system
- Using deep learning when a linear model would suffice

## Light Variant
In light mode (.agentcrew/light/00-router.md), this role works solo with compressed scope and reduced ceremony.
