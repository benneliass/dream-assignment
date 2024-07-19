output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.flask_app.id
}

output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.flask_app.public_ip
}

output "private_key_pem" {
  description = "The private key for the EC2 instance"
  value       = tls_private_key.private_key.private_key_pem
  sensitive   = true
}

output "instance_name" {
  description = "The name of the EC2 instance"
  value       = aws_instance.flask_app.tags["Name"]
}
