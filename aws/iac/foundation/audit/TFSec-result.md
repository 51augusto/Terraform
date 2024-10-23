
# [tfsec] Results
## Failed: 9 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-s3-block-public-acls` | *HIGH* | _S3 Access block should block public ACL_ | `flow-logs.tf:1-7` | No public access block so not blocking public acls |
| 2 | `aws-s3-block-public-policy` | *HIGH* | _S3 Access block should block public policy_ | `flow-logs.tf:1-7` | No public access block so not blocking public policies |
| 3 | `aws-s3-enable-bucket-encryption` | *HIGH* | _Unencrypted S3 bucket._ | `flow-logs.tf:1-7` | Bucket does not have encryption enabled |
| 4 | `aws-s3-enable-bucket-logging` | *MEDIUM* | _S3 Bucket does not have logging enabled._ | `flow-logs.tf:1-7` | Bucket does not have logging enabled |
| 5 | `aws-s3-enable-versioning` | *MEDIUM* | _S3 Data should be versioned_ | `flow-logs.tf:1-7` | Bucket does not have versioning enabled |
| 6 | `aws-s3-encryption-customer-key` | *HIGH* | _S3 encryption should use Customer Managed Keys_ | `flow-logs.tf:1-7` | Bucket does not encrypt data with a customer managed key. |
| 7 | `aws-s3-ignore-public-acls` | *HIGH* | _S3 Access Block should Ignore Public Acl_ | `flow-logs.tf:1-7` | No public access block so not ignoring public acls |
| 8 | `aws-s3-no-public-buckets` | *HIGH* | _S3 Access block should restrict public bucket to limit access_ | `flow-logs.tf:1-7` | No public access block so not restricting public buckets |
| 9 | `aws-s3-specify-public-access-block` | *LOW* | _S3 buckets should each define an aws_s3_bucket_public_access_block_ | `flow-logs.tf:1-7` | Bucket does not have a corresponding public access block. |

