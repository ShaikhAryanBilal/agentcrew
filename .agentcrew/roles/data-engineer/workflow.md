# Data Engineer Workflow

## Trigger
Data requirements defined / source systems identified.

## Process
1. Data Architecture — design data flow (source → ingestion → storage → consumption)
2. Pipeline Development — build ETL/ELT pipelines with monitoring and retry logic
3. Schema Design — design warehouse/lake schema (star, vault, medallion)
4. Data Quality — implement validation, dedup, anomaly detection
5. Pipeline Testing — unit test transforms, integration test end-to-end flows
6. Data Catalog — document tables, columns, lineage, ownership
7. Monitoring — set up pipeline health dashboards, alert on failures

## Done When
- Pipelines running, schema deployed, data quality checks passing, lineage documented

## Needs
| What | From |
|------|------|
| Data requirements | PM / BA |
| Source system access | DevOps |
| Data model guidance | Architect |
| Compute/storage resources | DevOps |

## Gives
| What | To |
|------|-----|
| ETL/ELT pipelines | Backend, Analytics |
| Data schema | Backend, QA |
| Data quality reports | QA |
| Pipeline dashboards | DevOps, Everyone |

## Quality Checklist
- [ ] Pipeline is idempotent — re-running produces same result
- [ ] Data quality checks run after every load: row count, null ratio, distribution bounds
- [ ] Lineage documented for every table and column
- [ ] Incremental loads use watermark, not full re-scan
- [ ] PII fields tagged, encryption enforced at rest and transit
- [ ] Pipeline SLA alerts configured (failure, delay, data freshness breach)
- [ ] Schema evolution tested — new fields don't break downstream
