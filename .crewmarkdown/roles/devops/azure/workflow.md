---
extends: ../workflow.md
role: DevOps/Azure
trigger: Tech stack decisions + build config available.
done_when: Infrastructure provisioned, CI/CD running, monitoring active.
---

## Trigger
Tech stack decisions + build config available.

## Instructions
1.   - Network — design hub-spoke VNet with Azure Firewall
 2.   - Compute — provision AKS cluster with system + user node pools
 3.   - CI/CD — set up Azure DevOps pipelines with Bicep + GitHub Actions
 4.   - Identity — configure Entra ID, managed identities, RBAC roles
 5.   - Monitoring — deploy Azure Monitor + Application Insights + Log Analytics
 6.   - Backup — configure geo-redundant storage, SQL backups, disaster recovery

7. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/devops-azure.md
8. Update .crewmarkdown/state/workflow.json

## Done When
Infrastructure provisioned, CI/CD running, monitoring active.
