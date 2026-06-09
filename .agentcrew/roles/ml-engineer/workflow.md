# ML Engineer Workflow

## Trigger
ML requirements defined / labeled data available.

## Process
1. Problem Framing — define prediction target, success metric (accuracy, precision-recall, F1), baseline
2. Data Exploration — analyze distributions, correlations, class balance, missing values
3. Feature Engineering — design features, validate against business logic
4. Model Training — experiment with architectures, hyperparameter tuning, cross-validation
5. Model Evaluation — compare against baseline, test on holdout set, check for bias/fairness
6. Model Packaging — export to standard format (ONNX, MLflow), version artifacts
7. Model Serving — deploy inference endpoint with batching, caching, autoscaling
8. Model Monitoring — track prediction drift, data drift, feature distribution shifts

## Done When
- Model meets success metric, evaluated on holdout, packaged, deployed, monitored

## Needs
| What | From |
|------|------|
| ML requirements | PM / BA |
| Training data | Data Engineer |
| Feature store | Data Engineer |
| Compute resources | DevOps |
| Serving infra | DevOps |

## Gives
| What | To |
|------|-----|
| Trained model | Backend, DevOps |
| Training pipeline | DevOps (CI) |
| Evaluation report | PM, QA |
| Serving endpoint | Backend |
| Monitoring dashboards | DevOps |

## Quality Checklist
- [ ] Baseline model established before complex approaches
- [ ] Train/test split verified — no data leakage
- [ ] Model evaluated against holdout set, not just training metrics
- [ ] Feature definitions versioned and stored in feature registry
- [ ] Model artifact versioned in model registry (MLflow or equivalent)
- [ ] Inference endpoint includes input validation and error handling
- [ ] Drift monitoring configured: data drift, concept drift, prediction drift
- [ ] Model card written: limitations, bias, intended use, failure modes
