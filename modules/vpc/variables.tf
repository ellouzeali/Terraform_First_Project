variable "my_aws_access_key" {
  type = string
}

variable "my_aws_secret_key" {
  type = string
  sensitive = true
}

variable "region" {
  type    = string
  default = "us-east-1"
}