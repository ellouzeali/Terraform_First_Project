variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type      = string
  sensitive = true
}

variable "availability_zone_names" {
  description = "My Test list of strings Variable"
  type        = list(string)
  default     = ["us-east-1", "us-west-1a"]
}

variable "rules" {
  type = list(object({
    port        = number
    proto       = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      port        = 80
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 22
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 3689
      proto       = "tcp"
      cidr_blocks = ["6.7.8.9/32"]
    }
  ]
}

variable "docker_ports" {
  description = "Test variable with type list of objects"
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [{
    internal = 8000
    external = 8300
    protocol = "tcp"
  }]
}

variable "greeting" {
  description = "My Test Basic type Variable"
  type        = string
  # Base types: string, number, bool
  # Complex types: list, set, map, object, tuple
  default   = "Hello"
  sensitive = true # Default value false, you can set sensitive to true if you don't want TF to show it in the execution.
  validation {
    condition     = length(var.greeting) > 4
    error_message = "The string must be more than 4 characters"
  }

}