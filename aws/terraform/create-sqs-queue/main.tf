provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "eu-west-3"
}

resource "aws_sqs_queue" "my_first_sqs" {
  name = var.sqs_name
}

resource "aws_sqs_queue_policy" "my_sqs_policy" {
  queue_url = aws_sqs_queue.my_first_sqs.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.my_first_sqs.arn}"
    }
  ]
}
POLICY
}