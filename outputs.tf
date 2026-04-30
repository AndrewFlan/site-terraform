output "elastic_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_eip.web.public_ip
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.web.id
}

output "ssh_command" {
  description = "Command to SSH into server"
  value       = "ssh -i ~/.ssh/my-website ubuntu@${aws_eip.web.public_ip}"
}
