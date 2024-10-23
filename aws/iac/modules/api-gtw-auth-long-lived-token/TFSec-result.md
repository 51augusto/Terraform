
# [tfsec] Results
## Failed: 5 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-cloudwatch-log-group-customer-key` | *LOW* | _CloudWatch log groups should be encrypted using CMK_ | `main.tf:36-42` | Log group is not encrypted. |
| 2 | `aws-dynamodb-enable-at-rest-encryption` | *HIGH* | _DAX Cluster and tables should always encrypt data at rest_ | `main.tf:44-64` | Table encryption is not enabled. |
| 3 | `aws-dynamodb-enable-recovery` | *MEDIUM* | _Point in time recovery should be enabled to protect DynamoDB table_ | `main.tf:44-64` | Point-in-time recovery is not enabled. |
| 4 | `aws-dynamodb-table-customer-key` | *LOW* | _DynamoDB tables should use at rest encryption with a Customer Managed Key_ | `main.tf:44-64` | Table encryption does not use a customer-managed KMS key. |
| 5 | `aws-lambda-enable-tracing` | *LOW* | _Lambda functions should have X-Ray tracing enabled_ | `main.tf:13-34` | Function does not have tracing enabled. |

