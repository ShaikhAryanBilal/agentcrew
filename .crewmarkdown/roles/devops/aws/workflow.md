---
extends: ../workflow.md
role: DevOps/AWS
trigger: Tech stack decisions + build config available.
done_when: Infrastructure provisioned, CI/CD running, monitoring active.
---

## Trigger
Tech stack decisions + build config available.

## Instructions
1.   - Network — design VPC with public/private subnets across 3 AZs
 2.   - Compute — provision EKS cluster with Karpenter, configure node groups
 3.   - CI/CD — set up GitHub Actions pipelines, ArgoCD for GitOps deploy
 4.   - IAM — define roles, policies, and service accounts for each service
 5.   - Monitoring — deploy Prometheus + Grafana + CloudWatch dashboards
 6.   - Backup — configure RDS backups, S3 lifecycle policies, disaster recovery

7. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/devops-aws.md
8. Update .crewmarkdown/state/workflow.json

## Done When
Infrastructure provisioned, CI/CD running, monitoring active.
