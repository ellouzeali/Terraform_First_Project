variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
  sensitive = true
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = "us-east-1"
}