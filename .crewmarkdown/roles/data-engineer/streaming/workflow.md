---
extends: ../workflow.md
role: Data Engineer/Streaming
trigger: Data requirements + source system access + data model available.
done_when: Data pipeline built, data loaded and validated, documentation complete.
---
## Trigger
Data requirements + source system access + data model available.
## Instructions
1. Design — define stream topology, schema, windowing strategy
 2. Setup — configure broker topics, schema registry, consumers
 3. Build — implement stream processor, state stores, sink connectors
 4. Validate — end-to-end latency test, exactly-once verification
 5. Monitor — consumer lag, throughput, error rates, schema evolution

6. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/data-engineer-streaming.md
7. Update .crewmarkdown/state/workflow.json
## Done When
Data pipeline built, data loaded and validated, documentation complete.
