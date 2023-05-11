module "my_vpc" {
  source            = "./modules/vpc"
  region            = var.availability_zone_names[0]
  my_aws_access_key = var.aws_access_key
  my_aws_secret_key = var.aws_secret_key
}
resource "aws_security_group" "my-sg" {
  vpc_id = module.my_vpc.vpc_id
  name   = join("_", ["tf", "sg", module.my_vpc.vpc_id])
  dynamic "ingress" {
    for_each = var.rules
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["proto"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Terraform-Dynamic-SG"
  }
}

resource "aws_instance" "terraform_vm" {
  ami           = module.my_vpc.ami_id
  subnet_id     = module.my_vpc.subnet_id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.my-sg.id]
  associate_public_ip_address = true
  user_data = fileexists("script.sh") ? file("script.sh") : null
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