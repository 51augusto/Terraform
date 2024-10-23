# Para reativar o waf, descomentar os próximos 3 recursos!! (Manter comentarios com #)

/*
resource "aws_cloudformation_stack" "waf_use1" {
  name = "waf-internal-cer-use1-01"
  provider = aws.use1
  template_url = "https://s3.amazonaws.com/solutions-reference/aws-waf-security-automations/latest/aws-waf-security-automations.template"
  capabilities = ["CAPABILITY_IAM"]

 parameters = {
  ActivateAWSManagedRulesParam = "yes"
#  ActivateSqlInjectionProtectionParam = "yes"
#  ActivateCrossSiteScriptingProtectionParam = "yes"
#  ActivateHttpFloodProtectionParam = "yes"
#  ActivateScannersProbesProtectionParam = "yes"
#  ActivateReputationListsProtectionParam = "yes"
#  ActivateBadBotProtectionParam = "yes"
  EndpointType = "ALB"
  AppAccessLogBucket = "s3-internal-cer-use1-accesslogs"
#  ErrorThreshold = "50"
#  RequestThreshold = "100"
#  WAFBlockPeriod = "240"
#  KeepDataInOriginalS3Location = "No"
#  IPRetentionPeriodAllowedParam = "-1"
#  IPRetentionPeriodDeniedParam = "-1"
#  SNSEmailParam = ""
 }   
}

resource "aws_cloudformation_stack" "waf_sae1" {
  name = "waf-internal-cer-sae1-01"
  provider = aws.sae1
  template_url = "https://s3.amazonaws.com/solutions-reference/aws-waf-security-automations/latest/aws-waf-security-automations.template"
  capabilities = ["CAPABILITY_IAM"]

 parameters = {
  ActivateAWSManagedRulesParam = "yes"
#  ActivateSqlInjectionProtectionParam = "yes"
#  ActivateCrossSiteScriptingProtectionParam = "yes"
#  ActivateHttpFloodProtectionParam = "yes"
#  ActivateScannersProbesProtectionParam = "yes"
#  ActivateReputationListsProtectionParam = "yes"
#  ActivateBadBotProtectionParam = "yes"
  EndpointType = "ALB"
  AppAccessLogBucket = "s3-internal-cer-sae1-accesslogs"
#  ErrorThreshold = "50"
#  RequestThreshold = "100"
#  WAFBlockPeriod = "240"
#  KeepDataInOriginalS3Location = "No"
#  IPRetentionPeriodAllowedParam = "-1"
#  IPRetentionPeriodDeniedParam = "-1"
#  SNSEmailParam = ""
 }   
}
*/