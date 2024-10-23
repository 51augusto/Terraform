
# [tfsec] Results
## Failed: 29 issue(s)
| # | ID | Severity | Title | Location | Description |
|---|----|----------|-------|----------|-------------|
| 1 | `aws-ec2-add-description-to-security-group` | *LOW* | _Missing description for security group._ | `r53resolver-use1.tf:1-32` | Security group explicitly uses the default description. |
| 2 | `aws-ec2-add-description-to-security-group` | *LOW* | _Missing description for security group._ | `r53resolver-sae1.tf:1-32` | Security group explicitly uses the default description. |
| 3 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `r53resolver-use1.tf:6-11` | Security group rule does not have a description. |
| 4 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `r53resolver-sae1.tf:6-11` | Security group rule does not have a description. |
| 5 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `ec2-dns.tf:204` | Security group rule does not have a description. |
| 6 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `ec2-dns.tf:188` | Security group rule does not have a description. |
| 7 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `ec2-dns.tf:180` | Security group rule does not have a description. |
| 8 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `ec2-dns.tf:172` | Security group rule does not have a description. |
| 9 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `ec2-dns.tf:164` | Security group rule does not have a description. |
| 10 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `ec2-dns.tf:156` | Security group rule does not have a description. |
| 11 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `ec2-dns.tf:148` | Security group rule does not have a description. |
| 12 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `ec2-dns.tf:140` | Security group rule does not have a description. |
| 13 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `ec2-dns.tf:132` | Security group rule does not have a description. |
| 14 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `ec2-dns.tf:116` | Security group rule does not have a description. |
| 15 | `aws-ec2-add-description-to-security-group-rule` | *LOW* | _Missing description for security group rule._ | `ec2-dns.tf:100` | Security group rule does not have a description. |
| 16 | `aws-ec2-enforce-http-token-imds` | *HIGH* | _aws_instance should activate session tokens for Instance Metadata Service._ | `ec2-dns.tf:47-73` | Instance does not require IMDS access to require a token |
| 17 | `aws-ec2-no-public-egress-sgr` | *CRITICAL* | _An egress security group rule allows traffic to /0._ | `r53resolver-use1.tf:10` | Security group rule allows egress to multiple public internet addresses. |
| 18 | `aws-ec2-no-public-egress-sgr` | *CRITICAL* | _An egress security group rule allows traffic to /0._ | `r53resolver-sae1.tf:10` | Security group rule allows egress to multiple public internet addresses. |
| 19 | `aws-ec2-no-public-egress-sgr` | *CRITICAL* | _An egress security group rule allows traffic to /0._ | `ec2-dns.tf:104` | Security group rule allows egress to multiple public internet addresses. |
| 20 | `aws-ec2-volume-encryption-customer-key` | *LOW* | _EBS volume encryption should use Customer Managed Keys_ | `ec2-dns.tf:75-84` | EBS volume does not use a customer-managed KMS key. |
| 21 | `aws-s3-block-public-acls` | *HIGH* | _S3 Access block should block public ACL_ | `flow-logs.tf:1-4` | No public access block so not blocking public acls |
| 22 | `aws-s3-block-public-policy` | *HIGH* | _S3 Access block should block public policy_ | `flow-logs.tf:1-4` | No public access block so not blocking public policies |
| 23 | `aws-s3-enable-bucket-encryption` | *HIGH* | _Unencrypted S3 bucket._ | `flow-logs.tf:1-4` | Bucket does not have encryption enabled |
| 24 | `aws-s3-enable-bucket-logging` | *MEDIUM* | _S3 Bucket does not have logging enabled._ | `flow-logs.tf:1-4` | Bucket does not have logging enabled |
| 25 | `aws-s3-enable-versioning` | *MEDIUM* | _S3 Data should be versioned_ | `flow-logs.tf:1-4` | Bucket does not have versioning enabled |
| 26 | `aws-s3-encryption-customer-key` | *HIGH* | _S3 encryption should use Customer Managed Keys_ | `flow-logs.tf:1-4` | Bucket does not encrypt data with a customer managed key. |
| 27 | `aws-s3-ignore-public-acls` | *HIGH* | _S3 Access Block should Ignore Public Acl_ | `flow-logs.tf:1-4` | No public access block so not ignoring public acls |
| 28 | `aws-s3-no-public-buckets` | *HIGH* | _S3 Access block should restrict public bucket to limit access_ | `flow-logs.tf:1-4` | No public access block so not restricting public buckets |
| 29 | `aws-s3-specify-public-access-block` | *LOW* | _S3 buckets should each define an aws_s3_bucket_public_access_block_ | `flow-logs.tf:1-4` | Bucket does not have a corresponding public access block. |

