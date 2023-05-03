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
  default = [ "us-west-1a" ]
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