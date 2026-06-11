---
extends: ../workflow.md
role: Data Engineer/Batch-ETL
trigger: Data requirements + source system access + data model available.
done_when: Data pipeline built, data loaded and validated, documentation complete.
---
## Trigger
Data requirements + source system access + data model available.
## Instructions
1. Analyze — understand data sources, volume, frequency, schema
 2. Design — define pipeline DAG, transformation logic, load strategy
 3. Build — implement extraction, transformation, and loading
 4. Orchestrate — configure Airflow/Dagster schedule, dependencies, retries
 5. Validate — row count checks, null checks, freshness SLA, data quality tests
 6. Monitor — set up alerting on failures and delays

7. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/data-engineer-batch-etl.md
8. Update .crewmarkdown/state/workflow.json
## Done When
Data pipeline built, data loaded and validated, documentation complete.
