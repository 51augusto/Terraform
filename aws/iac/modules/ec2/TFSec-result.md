
# [tfsec] Results
## Failed: 2 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-ec2-enforce-http-token-imds` | *HIGH* | _aws_instance should activate session tokens for Instance Metadata Service._ | `main.tf:21` | Instance does not require IMDS access to require a token |
| 2 | `aws-ec2-no-public-egress-sgr` | *CRITICAL* | _An egress security group rule allows traffic to /0._ | `sg.tf:70` | Security group rule allows egress to multiple public internet addresses. |

