# provider "aws" {
#   region = "us-east-1"
#   profile = "myprofile"
# }

module "vpc" {
  source = "./modules/vpc"
  region = var.availability_zone_names[0]
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
    when = destroy
    command = "echo '1' > status.txt"
  }

}


################### Some Variables ###########################################

variable "greeting" {
  description = "My Test Basic type Variable"
  type = string
  # Base types: string, number, bool
  # Complex types: list, set, map, object, tuple
  default = "Hello"
  sensitive = true # Default value false, you can set sensitive to true if you don't want TF to show it in the execution.
  validation {
    condition = length(var.greeting) > 4
    error_message = "The string must be more than 4 characters"
  }
  
}

variable "availability_zone_names" {
  description = "My Test list of strings Variable"
  type = list(string)
  default = [ "us-east-1", "us-west-1a" ]
}

variable "docker_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [ {
    internal = 8000
    external = 8300
    protocol = "tcp"
  } ]
  
}

################### Some Ouputs  ###########################################

output "message" {
  description = "Test message to show after running terraform apply"
  value = "Creating EC2 instance with terraform!!"
}

output "instance_ip" {
  description = "VM's Public IP"
  value = aws_instance.terraform_vm.public_ip
  sensitive = true
}

output "PrivateIP" {
  description = "Private IP of EC2 instance"
  value       = aws_instance.terraform_vm.private_ip
}