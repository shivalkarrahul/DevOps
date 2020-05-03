variable "access_key" {
     description = "Access key to AWS console"
}
variable "secret_key" {
     description = "Secret key to AWS console"
}
variable "region" {
     description = "Region of AWS VPC"
}
variable "identifier" {
  default     = "mydb-rds"
  description = "Identifier for your DB"
}

variable "storage" {
  default     = "10"
  description = "Storage size in GB"
}

variable "engine" {
  default     = "mysql"
  description = "Engine type, here it is mysql"
}

variable "engine_version" {
  description = "Engine version"

  default = {
    mysql    = "5.7.21"
  }
}

variable "instance_class" {
  default     = "db.t2.micro"
  description = "Instance class"
}

variable "db_name" {
  default     = "myfirstdb"
  description = "db name"
}

variable "username" {
  default     = "rahul"
  description = "User name"
}

variable "password" {
  description = "password, provide through your ENV variables"
  default = "rahul1234"
}
variable "subnet_1_cidr" {
  default     = "172.31.48.0/20"
  description = "Your AZ"
}

variable "subnet_2_cidr" {
  default     = "172.31.64.0/20"
  description = "Your AZ"
}

variable "az_1" {
  default     = "eu-west-3c"
  description = "Your Az1, use AWS CLI to find your account specific"
}

variable "az_2" {
  default     = "eu-west-3a"
  description = "Your Az2, use AWS CLI to find your account specific"
}

variable "vpc_id" {
  description = "Your VPC ID"
  default = "vpc-be1010d7"
}
variable "cidr_blocks" {
  default     = "0.0.0.0/0"
  description = "CIDR for sg"
}

variable "sg_name" {
  default     = "my-rds-sg"
  description = "Tag Name for sg"
}

