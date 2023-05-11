output "message" {
  description = "Test message to show after running terraform apply"
  value       = "Creating EC2 instance with terraform!!"
}


output "PrivateIP" {
  description = "Private IP of EC2 instance"
  value       = aws_instance.terraform_vm.private_ip
  sensitive   = true
}

output "Web-Server-URL" {
  description = "Web-Server-URL"
  value       = join("", ["http://", aws_instance.terraform_vm.public_ip])
}

output "Time-Date" {
  description = "Date/Time of Execution"
  value       = timestamp()
}