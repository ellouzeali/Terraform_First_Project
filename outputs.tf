output "message" {
  description = "Test message to show after running terraform apply"
  value       = "Creating EC2 instance with terraform!!"
}

output "instance_ip" {
  description = "VM's Public IP"
  value       = aws_instance.terraform_vm.public_ip
  sensitive   = true
}

output "PrivateIP" {
  description = "Private IP of EC2 instance"
  value       = aws_instance.terraform_vm.private_ip
}