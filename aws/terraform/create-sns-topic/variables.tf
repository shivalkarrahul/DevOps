variable "access_key" {
        description = "Access key to AWS console"
}
variable "secret_key" {
        description = "Secret key to AWS console"
}


variable "sns_name" {
        description = "Name of the SNS Topic to be created"
        default = "my_first_sns"
}

variable "account_id" {
        description = "My Accout Number"
        default = "<your-aws-account-id-here>"
}


