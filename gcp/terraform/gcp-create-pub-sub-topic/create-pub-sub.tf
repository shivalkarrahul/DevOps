provider "google" {
project		= "${var.project_name}"
}

resource "google_pubsub_topic" "pub" {
  name = "${var.pub_name}"
}

resource "google_pubsub_subscription" "sub" {
  name  = "${var.sub_name}"
  topic = "${google_pubsub_topic.pub.name}"

  labels = {
    env = "${var.environment}"
  }

  message_retention_duration = "1200s"
  retain_acked_messages = true

  ack_deadline_seconds = 20

  expiration_policy {
    ttl = "300000.5s"
  }

}
