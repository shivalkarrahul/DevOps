provider "aws" {
      region     = "${var.region}"
      access_key = "${var.access_key}"
      secret_key = "${var.secret_key}"
}

resource "aws_iam_user" "user" {
  name = var.name
}

resource "aws_iam_user_policy_attachment" "attach-user" {
  user       = "${aws_iam_user.user.name}"
  policy_arn = var.policy_arns
}

