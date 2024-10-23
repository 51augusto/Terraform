
# [tfsec] Results
## Failed: 22 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-ec2-add-description-to-security-group` | *LOW* | _Missing description for security group._ | `auto-scaling-group/sg.tf:1-12` | Security group explicitly uses the default description. |
| 2 | `aws-ec2-add-description-to-security-group` | *LOW* | _Missing description for security group._ | `auto-scaling-group/sg.tf:1-12` | Security group explicitly uses the default description. |
| 3 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `auto-scaling-group/sg.tf:5-11` | Security group rule does not have a description. |
| 4 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `auto-scaling-group/sg.tf:5-11` | Security group rule does not have a description. |
| 5 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `auto-scaling-group/sg.tf:32-39` | Security group rule does not have a description. |
| 6 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `auto-scaling-group/sg.tf:32-39` | Security group rule does not have a description. |
| 7 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `auto-scaling-group/sg.tf:32-39` | Security group rule does not have a description. |
| 8 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `auto-scaling-group/sg.tf:32-39` | Security group rule does not have a description. |
| 9 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `auto-scaling-group/sg.tf:23-30` | Security group rule does not have a description. |
| 10 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `auto-scaling-group/sg.tf:23-30` | Security group rule does not have a description. |
| 11 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `auto-scaling-group/sg.tf:23-30` | Security group rule does not have a description. |
| 12 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `auto-scaling-group/sg.tf:23-30` | Security group rule does not have a description. |
| 13 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `auto-scaling-group/sg.tf:14-21` | Security group rule does not have a description. |
| 14 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `auto-scaling-group/sg.tf:14-21` | Security group rule does not have a description. |
| 15 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `auto-scaling-group/sg.tf:14-21` | Security group rule does not have a description. |
| 16 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `auto-scaling-group/sg.tf:14-21` | Security group rule does not have a description. |
| 17 | `aws-ec2-enforce-launch-config-http-token-imds` | *HIGH* | _aws_instance should activate session tokens for Instance Metadata Service._ | `auto-scaling-group/main.tf:21-58` | Launch template does not require IMDS access to require a token |
| 18 | `aws-ec2-enforce-launch-config-http-token-imds` | *HIGH* | _aws_instance should activate session tokens for Instance Metadata Service._ | `auto-scaling-group/main.tf:21-58` | Launch template does not require IMDS access to require a token |
| 19 | `aws-ec2-no-public-egress-sgr` | *CRITICAL* | _An egress security group rule allows traffic to /0._ | `auto-scaling-group/sg.tf:9` | Security group rule allows egress to multiple public internet addresses. |
| 20 | `aws-ec2-no-public-egress-sgr` | *CRITICAL* | _An egress security group rule allows traffic to /0._ | `auto-scaling-group/sg.tf:9` | Security group rule allows egress to multiple public internet addresses. |
| 21 | `aws-ec2-no-public-egress-sgr` | *CRITICAL* | _An egress security group rule allows traffic to /0._ | `auto-scaling-group/sg.tf:10` | Security group rule allows egress to multiple public internet addresses. |
| 22 | `aws-ec2-no-public-egress-sgr` | *CRITICAL* | _An egress security group rule allows traffic to /0._ | `auto-scaling-group/sg.tf:10` | Security group rule allows egress to multiple public internet addresses. |

