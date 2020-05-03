provider "aws" {
      region     = "${var.region}"
      access_key = "${var.access_key}"
      secret_key = "${var.secret_key}"
}

resource "aws_s3_bucket" "this" {
  bucket                               = "${var.bucket_name}"
  force_destroy                        = "${var.force_destroy}"
  region                               = "${var.region}"
  tags                                 = "${merge(var.tags, map("Name", format("%s", var.bucket_name)))}"
}

