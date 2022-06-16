# Monitor IAM root user activity

Every Amazon Web Services (AWS) account has a root user. As a [security best practice](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html) for AWS Identity and Access Management (IAM), we recommend that you use the root user to create an IAM admin user, and then don’t use your root user credentials for any other management tasks. Because the root user account has full access to all of your AWS resources and billing information, we recommend that you don’t use this account and monitor it for any activity, which might indicate that the account credentials have been compromised.

Using this pattern, you set up an [event-driven architecture](https://aws.amazon.com/event-driven-architecture/) that monitors the IAM root user. This pattern sets up a hub-and-spoke solution that monitors multiple AWS accounts, the _spoke_ accounts, and centralizes management and reporting in a single account, the _hub_ account.

When the IAM root user credentials are used, Amazon CloudWatch and AWS CloudTrail record the activity in the log and trail, respectively. In the spoke account, an Amazon EventBridge rule sends the event to the central [event bus](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-event-bus.html) in the hub account. In the hub account, an EventBridge rule sends the event to an AWS Lambda function. The function uses an Amazon Simple Notification Service (Amazon SNS) topic that notifies you of the root user activity.

In this pattern, you use an AWS CloudFormation template to deploy the monitoring and event-handling services in the spoke accounts. You use a HashiCorp Terraform template to deploy the event-management and notification services in the hub account.

The code in this repository helps you set up the following target architecture.

![RootActivityMonitor](RootActivityMonitor.png)

For prerequisites and instructions for using this AWS Prescriptive Guidance pattern, see [Monitor IAM root user activity](https://docs.aws.amazon.com/prescriptive-guidance/latest/patterns/monitor-iam-root-user-activity.html).