
# [tfsec] Results
## Failed: 1 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-ec2-no-public-egress-sgr` | *CRITICAL* | _An egress security group rule allows traffic to /0._ | `sg.tf:41` | Security group rule allows egress to multiple public internet addresses. |

