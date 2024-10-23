
# [tfsec] Results
## Failed: 4 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `sg.tf:36-43` | Security group rule does not have a description. |
| 2 | `aws-ec2-no-public-egress-sgr` | *CRITICAL* | _An egress security group rule allows traffic to /0._ | `sg.tf:42` | Security group rule allows egress to multiple public internet addresses. |
| 3 | `aws-rds-enable-deletion-protection` | *MEDIUM* | _RDS Deletion Protection Disabled_ | `main.tf:112` | Instance does not have Deletion Protection enabled |
| 4 | `aws-rds-enable-performance-insights-encryption` | *HIGH* | _Encryption for RDS Performance Insights should be enabled._ | `main.tf:99-149` | Instance has performance insights enabled without encryption. |

