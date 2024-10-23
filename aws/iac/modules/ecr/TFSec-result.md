
# [tfsec] Results
## Failed: 3 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-ecr-enable-image-scans` | *HIGH* | _ECR repository has image scans disabled._ | `main.tf:1-6` | Image scanning is not enabled. |
| 2 | `aws-ecr-enforce-immutable-repository` | *HIGH* | _ECR images tags shouldn't be mutable._ | `main.tf:1-6` | Repository tags are mutable. |
| 3 | `aws-ecr-repository-customer-key` | *LOW* | _ECR Repository should use customer managed keys to allow more control_ | `main.tf:1-6` | Repository is not encrypted using KMS. |

