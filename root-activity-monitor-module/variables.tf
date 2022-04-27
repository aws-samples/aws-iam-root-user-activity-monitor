variable "tags" {
  description = "Add tags to set on module resources."
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "Add the region code where resources will be deployed."
  type        = string
  default = "eu-west-1"
}

variable "OrganizationId" {
  description = "Add the Organization ID of your AWS environment."
  type        = string
  default = "__REPLACE_ORG_ID__"
}

variable "SNSTopicName" {
  description = "Add SNS topic name."
  type        = string
  default = "aws-iam-root-user-activity-monitor"
}

variable "SNSSubscriptions" {
  description = "Add your email here to be able to receive notifications"
  type        = string
  default = "__REPLACE_EMAIL_ADDRESS__"
}

