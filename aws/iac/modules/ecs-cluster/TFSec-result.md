
# [tfsec] Results
## Failed: 1 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-ecs-enable-container-insight` | *LOW* | _ECS clusters should have container insights enabled_ | `.terraform/modules/ecs/modules/cluster/main.tf:88` | Cluster does not have container insights enabled. |

