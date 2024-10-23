
# [tfsec] Results
## Failed: 7 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-cloudwatch-log-group-customer-key` | *LOW* | _CloudWatch log groups should be encrypted using CMK_ | `cloudwatch.tf:28-35` | Log group is not encrypted. |
| 2 | `aws-cloudwatch-log-group-customer-key` | *LOW* | _CloudWatch log groups should be encrypted using CMK_ | `cloudwatch.tf:19-26` | Log group is not encrypted. |
| 3 | `aws-cloudwatch-log-group-customer-key` | *LOW* | _CloudWatch log groups should be encrypted using CMK_ | `cloudwatch.tf:10-17` | Log group is not encrypted. |
| 4 | `aws-cloudwatch-log-group-customer-key` | *LOW* | _CloudWatch log groups should be encrypted using CMK_ | `cloudwatch.tf:1-8` | Log group is not encrypted. |
| 5 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `sg.tf:13-21` | Security group rule does not have a description. |
| 6 | `aws-ec2-no-public-egress-sgr` | *CRITICAL* | _An egress security group rule allows traffic to /0._ | `sg.tf:20` | Security group rule allows egress to multiple public internet addresses. |
| 7 | `aws-kms-auto-rotate-keys` | *MEDIUM* | _A KMS key is not configured to auto-rotate._ | `main.tf:146` | Key does not have rotation enabled. |

