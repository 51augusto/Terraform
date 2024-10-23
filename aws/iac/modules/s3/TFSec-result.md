
# [tfsec] Results
## Failed: 3 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-s3-enable-bucket-logging` | *MEDIUM* | _S3 Bucket does not have logging enabled._ | `main.tf:1-8` | Bucket does not have logging enabled |
| 2 | `aws-s3-enable-versioning` | *MEDIUM* | _S3 Data should be versioned_ | `main.tf:33` | Bucket does not have versioning enabled |
| 3 | `aws-s3-encryption-customer-key` | *HIGH* | _S3 encryption should use Customer Managed Keys_ | `main.tf:18-27` | Bucket does not encrypt data with a customer managed key. |

