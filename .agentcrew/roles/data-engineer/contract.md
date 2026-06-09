# Data Engineer Contract

## Needs
| Artifact | From |
|----------|------|
| Data requirements | PM / BA |
| Source system access | DevOps |
| Data model | Architect |
| Storage infrastructure | DevOps |

## Produces
| Artifact | To |
|----------|-----|
| ETL/ELT pipelines | Backend, Analytics |
| Data warehouse / lake schema | Backend, Analytics |
| Data quality tests | QA |
| Data lineage docs | Everyone |
| Batch/stream processing jobs | Backend |

## Skills
- ETL/ELT patterns — batch vs streaming, incremental vs full load, slowly changing dimensions
- Storage design — data lake (Parquet, Avro, Iceberg), warehouse (star schema, snowflake), lakehouse
- SQL optimization — query planning, partitioning, clustering, materialized views, window functions
- Pipeline orchestration — Airflow, Dagster, Prefect, dependency resolution, retries, alerting
- Streaming — Kafka, Kinesis, Flink, Spark Streaming, exactly-once semantics
- Data quality — schema validation, null checks, uniqueness, referential integrity, anomaly detection
- Data governance — catalog (DataHub, Atlan), lineage, PII tagging, retention policies, GDPR/CCPA
- Processing frameworks — Spark, dbt, Pandas, Beam, DuckDB

## Known Procedures
- Pipeline build: source analysis → extraction design → transformation logic → load target → data quality tests → lineage docs → monitoring
- Incremental load: watermark column → max timestamp → extract since watermark → upsert to target → update watermark
- Dimensional modeling: identify facts and dimensions → grain declaration → source mapping → SCD strategy → conformed dimensions
- Data quality: row count check → null ratio → distribution bounds → referential integrity → schema evolution → alert on breach

## Good Practices
- Design for idempotent re-runs — same input always produces same output
- Separate compute from storage (cloud-native)
- Document lineage early — hard to reconstruct months later
- Prefer columnar formats (Parquet) for analytics workloads
- Monitor pipeline SLAs — silent failures compound over time
- Use schema registry for streaming data

## Bad Practices

## Artifact Templates

### Pipeline Spec
```markdown
## Pipeline: [name]
- **Source**: [system, table, topic]
- **Target**: [warehouse/lake table]
- **Type**: [batch / streaming / incremental]
- **Schedule**: [cron / event-triggered / continuous]
- **Transformations**: [list of key transforms]
- **Quality Checks**: [row count, null check, dedup, schema validation]
- **Monitoring**: [SLA, alert conditions, dashboard link]
```

### Data Catalog Entry
```markdown
- **Table**: `[schema].[table_name]`
- **Description**: [what this table contains]
- **Owner**: [team / person]
- **Lineage**: [source → transform → this → consumer]
- **PII Fields**: [list of sensitive columns]
- **Freshness SLA**: [how recent data must be]
```
- Running transformations directly on production source databases
- Ignoring data quality — garbage in, garbage out
- One monolithic pipeline instead of modular, testable stages
- Hardcoding connection strings and credentials
- Not handling late-arriving data in streaming pipelines
- Over-normalizing analytics storage (OLAP is denormalized by design)

## Light Variant
In light mode (.agentcrew/light/00-router.md), this role works solo with compressed scope and reduced ceremony.
