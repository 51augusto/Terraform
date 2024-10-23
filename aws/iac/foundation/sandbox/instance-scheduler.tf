resource "aws_cloudformation_stack" "instance_scheduler" {
  name         = "instance-scheduler-sbx"
  provider     = aws.use1
  template_url = "https://s3.amazonaws.com/solutions-reference/aws-instance-scheduler/v1.5.0/aws-instance-scheduler.template"
  capabilities = ["CAPABILITY_IAM"]
  parameters = {
    Regions             = "us-east-1,sa-east-1"
    StartedTags         = "StartStopScheduled"
    TagName             = "StartStopScheduled"
    StoppedTags         = "StartStopScheduled"
    ScheduleRdsClusters = "Yes"
    ScheduledServices   = "Both"
    SchedulerFrequency  = "5"
    SchedulingActive    = "Yes"
  }
}