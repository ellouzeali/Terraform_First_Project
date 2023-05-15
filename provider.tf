provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = terraform.workspace == "default" ? "us-east-1" : "us-west-2"
}

# provider "aws" {
#   region = "us-east-1"
#   profile = "myprofile"
# }