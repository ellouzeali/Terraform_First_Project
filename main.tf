module "vpc" {
  source            = "./modules/vpc"
  region            = var.availability_zone_names[0]
  my_aws_access_key = var.aws_access_key
  my_aws_secret_key = var.aws_secret_key
}

resource "aws_instance" "terraform_vm" {
  ami           = module.vpc.ami_id
  subnet_id     = module.vpc.subnet_id
  instance_type = "t2.micro"
  tags = {
    Name = "my-first-tf-node"
  }
}

resource "null_resource" "dummy_ressource" {

  # This is an example of Create time provisioner
  provisioner "local-exec" {
    command = "echo '0' > status.txt"
  }

  # This is an example of Destroy time provisioner
  provisioner "local-exec" {
    when    = destroy
    command = "echo '1' > status.txt"
  }

}