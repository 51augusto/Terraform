
# [tfsec] Results
## Failed: 2 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `sg.tf:13-20` | Security group rule does not have a description. |
| 2 | `aws-ec2-no-public-egress-sgr` | *CRITICAL* | _An egress security group rule allows traffic to /0._ | `sg.tf:19` | Security group rule allows egress to multiple public internet addresses. |

