
# [tfsec] Results
## Failed: 3 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-dynamodb-enable-at-rest-encryption` | *HIGH* | _DAX Cluster and tables should always encrypt data at rest_ | `main.tf:1-53` | Table encryption is not enabled. |
| 2 | `aws-dynamodb-enable-recovery` | *MEDIUM* | _Point in time recovery should be enabled to protect DynamoDB table_ | `main.tf:1-53` | Point-in-time recovery is not enabled. |
| 3 | `aws-dynamodb-table-customer-key` | *LOW* | _DynamoDB tables should use at rest encryption with a Customer Managed Key_ | `main.tf:1-53` | Table encryption does not use a customer-managed KMS key. |

