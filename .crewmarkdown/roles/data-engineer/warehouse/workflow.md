---
extends: ../workflow.md
role: Data Engineer/Warehouse
trigger: Data requirements + source system access + data model available.
done_when: Data pipeline built, data loaded and validated, documentation complete.
---
## Trigger
Data requirements + source system access + data model available.
## Instructions
1. Model — design fact and dimension tables, SCD strategy
 2. Build — create warehouse objects, define ETL/ELT to load
 3. Optimize — set up partitioning, clustering, materialized views
 4. Govern — implement row/column security, data masking
 5. Document — maintain data dictionary, lineage, business definitions

6. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/data-engineer-warehouse.md
7. Update .crewmarkdown/state/workflow.json
## Done When
Data pipeline built, data loaded and validated, documentation complete.
