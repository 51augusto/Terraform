
# [tfsec] Results
## Failed: 3 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `sg.tf:35-42` | Security group rule does not have a description. |
| 2 | `aws-ec2-no-public-egress-sgr` | *CRITICAL* | _An egress security group rule allows traffic to /0._ | `sg.tf:41` | Security group rule allows egress to multiple public internet addresses. |
| 3 | `aws-redshift-encryption-customer-key` | *HIGH* | _Redshift clusters should use at rest encryption_ | `main.tf:11-44` | Cluster does not use a customer managed encryption key. |

