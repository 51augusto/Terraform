
# [tfsec] Results
## Failed: 6 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-cloudwatch-log-group-customer-key` | *LOW* | _CloudWatch log groups should be encrypted using CMK_ | `main.tf:19-25` | Log group is not encrypted. |
| 2 | `aws-cloudwatch-log-group-customer-key` | *LOW* | _CloudWatch log groups should be encrypted using CMK_ | `main.tf:11-17` | Log group is not encrypted. |
| 3 | `aws-documentdb-encryption-customer-key` | *LOW* | _DocumentDB encryption should use Customer Managed Keys_ | `main.tf:58-78` | Instance encryption does not use a customer-managed KMS key. |
| 4 | `aws-documentdb-encryption-customer-key` | *LOW* | _DocumentDB encryption should use Customer Managed Keys_ | `main.tf:27-56` | Cluster encryption does not use a customer-managed KMS key. |
| 5 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `sg.tf:25-32` | Security group rule does not have a description. |
| 6 | `aws-ec2-no-public-egress-sgr` | *CRITICAL* | _An egress security group rule allows traffic to /0._ | `sg.tf:31` | Security group rule allows egress to multiple public internet addresses. |

