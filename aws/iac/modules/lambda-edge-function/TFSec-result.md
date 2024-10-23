
# [tfsec] Results
## Failed: 2 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-cloudwatch-log-group-customer-key` | *LOW* | _CloudWatch log groups should be encrypted using CMK_ | `main.tf:23-29` | Log group is not encrypted. |
| 2 | `aws-lambda-enable-tracing` | *LOW* | _Lambda functions should have X-Ray tracing enabled_ | `main.tf:1-21` | Function does not have tracing enabled. |

