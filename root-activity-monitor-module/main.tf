// Lambda function resources

resource "aws_iam_role_policy" "LambdaRootAPIMonitorPolicy" {
  name   = "LambdaRootAPIMonitorPolicy"
  role   = aws_iam_role.LambdaRootAPIMonitorRole.id
  policy = file("${path.module}/iam/lambda-policy.json")
}

resource "aws_iam_role" "LambdaRootAPIMonitorRole" {
  name               = "LambdaRootAPIMonitorRole"
  assume_role_policy = file("${path.module}/iam/lambda-assume-policy.json")
  tags               = var.tags
}

resource "aws_lambda_permission" "allow_events" {
  statement_id  = "AllowExecutionFromEvents"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.RootActivityLambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.hub-root-activity-rule.arn
  depends_on = [

    aws_lambda_function.RootActivityLambda
  ]
}

data "archive_file" "RootActivityLambda" {
  type        = "zip"
  source_file = "${path.module}/RootActivityLambda.py"
  output_path = "${path.module}/outputs/RootActivityLambda.zip"
}

resource "aws_lambda_function" "RootActivityLambda" {
  #checkov:skip=CKV_AWS_116:The Lambda function is triggered by an EventBridge pattern-based rule.
  #checkov:skip=CKV_AWS_117:The Lambda function is part of a serverless implementation.
  #checkov:skip=CKV_AWS_173:No AWS KMS key provided to encrypt environment variables. Using AWS Lambda owned key.
  #checkov:skip=CKV_AWS_50:The Lambda function does not require X-Ray tracing and relies on CloudWatch Logs.

  filename      = "${path.module}/outputs/RootActivityLambda.zip"
  function_name = "root-activity-monitor"
  role          = aws_iam_role.LambdaRootAPIMonitorRole.arn
  handler       = "RootActivityLambda.lambda_handler"
  timeout       = "15"

  source_code_hash               = data.archive_file.RootActivityLambda.output_base64sha256
  runtime                        = "python3.8"
  reserved_concurrent_executions = 1

  environment {
    variables = {
      SNSARN = aws_sns_topic.root-activity-sns-topic.arn
    }
  }
}

// Event Bus Resources
resource "aws_cloudwatch_event_bus" "hub-root-activity-eventbus" {
  name = "hub-root-activity"
}

resource "aws_cloudwatch_event_permission" "hub-root-activity-eventbus-OrgAccess" {
  event_bus_name = aws_cloudwatch_event_bus.hub-root-activity-eventbus.name
  principal      = "*"
  statement_id   = "OrganizationAccess"

  condition {
    key   = "aws:PrincipalOrgID"
    type  = "StringEquals"
    value = data.aws_organizations_organization.myorg.id
  }
}

resource "aws_cloudwatch_event_rule" "hub-root-activity-rule" {
  name           = "hub-capture-root-activity"
  description    = "Capture root user AWS Console Sign In and AWS API calls."
  event_bus_name = aws_cloudwatch_event_bus.hub-root-activity-eventbus.name

  event_pattern = <<EOF
{
  "detail-type": [
    "AWS API Call via CloudTrail",
    "AWS Console Sign In via CloudTrail"
  ],
  "detail": {
      "userIdentity": {
          "type": [
              "Root"
          ]
      }
  }
}
EOF
}

resource "aws_cloudwatch_event_target" "root-activity-event-target" {
  event_bus_name = aws_cloudwatch_event_bus.hub-root-activity-eventbus.name
  rule           = aws_cloudwatch_event_rule.hub-root-activity-rule.name
  arn            = aws_lambda_function.RootActivityLambda.arn
}

// SNS resources
resource "aws_sns_topic" "root-activity-sns-topic" {
  name              = var.SNSTopicName
  display_name      = "AWS IAM Root User Activity Monitor"
  kms_master_key_id = "alias/aws/sns"
}

resource "aws_sns_topic_subscription" "root-activity-sns-topic-sub" {
  endpoint  = var.SNSSubscriptions
  protocol  = "email-json"
  topic_arn = aws_sns_topic.root-activity-sns-topic.arn
}
