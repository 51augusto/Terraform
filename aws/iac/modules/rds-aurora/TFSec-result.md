
# [tfsec] Results
## Failed: 5 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-cloudwatch-log-group-customer-key` | *LOW* | _CloudWatch log groups should be encrypted using CMK_ | `main.tf:39-46` | Log group is not encrypted. |
| 2 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `sg.tf:35-42` | Security group rule does not have a description. |
| 3 | `aws-ec2-no-public-egress-sgr` | *CRITICAL* | _An egress security group rule allows traffic to /0._ | `sg.tf:41` | Security group rule allows egress to multiple public internet addresses. |
| 4 | `aws-rds-enable-performance-insights-encryption` | *HIGH* | _Encryption for RDS Performance Insights should be enabled._ | `main.tf:81-111` | Instance has performance insights enabled without encryption. |
| 5 | `aws-rds-encrypt-cluster-storage-data` | *HIGH* | _There is no encryption specified or encryption is disabled on the RDS Cluster._ | `main.tf:48-79` | Cluster does not specify a customer managed key for storage encryption. |

