---
extends: ../workflow.md
role: DevOps/GCP
trigger: Tech stack decisions + build config available.
done_when: Infrastructure provisioned, CI/CD running, monitoring active.
---

## Trigger
Tech stack decisions + build config available.

## Instructions
1.   - Network — design Shared VPC with Cloud NAT, Private Google Access
 2.   - Compute — provision GKE cluster (Autopilot or Standard), configure Cloud Run
 3.   - CI/CD — set up Cloud Build triggers, Cloud Deploy rollout pipelines
 4.   - IAM — configure Workload Identity, custom roles, service accounts
 5.   - Monitoring — deploy Cloud Monitoring + Logging + Managed Prometheus
 6.   - Backup — configure Cloud SQL backups, object lifecycle policies, DR plan

7. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/devops-gcp.md
8. Update .crewmarkdown/state/workflow.json

## Done When
Infrastructure provisioned, CI/CD running, monitoring active.
