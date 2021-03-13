variable "access_key" {
        description = "Access key to AWS console"
}
variable "secret_key" {
        description = "Secret key to AWS console"
}


variable "sqs_name" {
        description = "Name of the sqs queue to be created"
        default = "my-first-sqs"
}