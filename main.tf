provider "aws" {
  region = "us-east-1"
  profile = "myprofile"
}

resource "aws_instance" "terraform_vm" {
  ami = "ami-02396cdd13e9a1257"
  subnet_id = "subnet-0619e6ccee9197e25"
  instance_type = "t2.micro"
  tags = {
    Name = "my-first-tf-node"
  }
}
output "message" {
  value = "Creating EC2 instance with terraform!!"
}