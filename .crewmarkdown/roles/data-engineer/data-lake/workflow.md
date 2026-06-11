---
extends: ../workflow.md
role: Data Engineer/Data-Lake
trigger: Data requirements + source system access + data model available.
done_when: Data pipeline built, data loaded and validated, documentation complete.
---
## Trigger
Data requirements + source system access + data model available.
## Instructions
1. Design — lake architecture (medallion), table format, catalog
 2. Ingest — set up raw ingest from sources, schema enforcement
 3. Transform — build bronze ? silver ? gold pipelines
 4. Catalog — register tables, set up governance and lineage
 5. Optimize — compaction, partitioning, file sizing, vacuum old versions
 6. Serve — configure query engine (Trino/Athena) for consumers

7. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/data-engineer-data-lake.md
8. Update .crewmarkdown/state/workflow.json
## Done When
Data pipeline built, data loaded and validated, documentation complete.
