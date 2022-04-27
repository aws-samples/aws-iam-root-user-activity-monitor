module "root-activity-monitor-euw1" {
    providers = {
      aws = aws.euw1
     }
  source = "./root-activity-monitor-module"

  //Add the Organization ID of your AWS environment.
  OrganizationId = "__REPLACE_ORG_ID__"
  // Add SNS topic name.
  SNSTopicName = "monitor-root-API-calls"
  // Add your email here to be able to receive notifications
  SNSSubscriptions = "__REPLACE_EMAIL_ADDRESS__"
  // Add the region code where resources will be deployed.
  region = "eu-west-1"
  // Add tags to set on module resources.
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
