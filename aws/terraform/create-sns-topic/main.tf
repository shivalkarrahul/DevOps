provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "eu-west-3"
}

resource "aws_sns_topic" "my_first_sns_topic" {
  name = var.sns_name
}

resource "aws_sns_topic_policy" "my_sns_topic_policy" {
  arn = aws_sns_topic.my_first_sns_topic.arn
  policy = data.aws_iam_policy_document.my_custom_sns_policy_document.json
}

data "aws_iam_policy_document" "my_custom_sns_policy_document" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        var.account_id,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.my_first_sns_topic.arn,
    ]

    sid = "__default_statement_ID"
  }
}