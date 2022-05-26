## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_bus.hub-root-activity-eventbus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_bus) | resource |
| [aws_cloudwatch_event_permission.hub-root-activity-eventbus-OrgAccess](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_permission) | resource |
| [aws_cloudwatch_event_rule.hub-root-activity-rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.root-activity-event-target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_role.LambdaRootAPIMonitorRole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.LambdaRootAPIMonitorPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_lambda_function.RootActivityLambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.allow_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_sns_topic.root-activity-sns-topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.root-activity-sns-topic-sub](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [archive_file.RootActivityLambda](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_OrganizationId"></a> [OrganizationId](#input\_OrganizationId) | Add the Organization ID of your AWS environment. | `string` | `"o-id"` | yes |
| <a name="input_SNSSubscriptions"></a> [SNSSubscriptions](#input\_SNSSubscriptions) | Add your email here to be able to receive notifications | `string` | `"email@example.com"` | yes |
| <a name="input_SNSTopicName"></a> [SNSTopicName](#input\_SNSTopicName) | Add SNS topic name. | `string` | `"monitor-root-API-calls"` | yes |
| <a name="input_region"></a> [region](#input\_region) | Add the region code where resources will be deployed. | `string` | `"eu-west-1"` | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Add tags to set on module resources. | `map(string)` | `{}` | yes |

## Outputs

No outputs.
