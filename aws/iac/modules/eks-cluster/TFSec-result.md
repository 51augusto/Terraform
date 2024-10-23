
# [tfsec] Results
## Failed: 1 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-ec2-enforce-launch-config-http-token-imds` | *HIGH* | _aws_instance should activate session tokens for Instance Metadata Service._ | `.terraform/modules/eks/modules/node_groups/launch_template.tf:96` | Launch template does not require IMDS access to require a token |

