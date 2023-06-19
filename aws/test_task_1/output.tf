#output public ip instance
output "server_public_ip" {
  value       = aws_eip.my_static_ip.public_ip
  description = "This is public IP"
}

#output ubuntu id install
output "latest_ubuntu_id" {
  value = data.aws_ami.latest_ubuntu.id
}

#output ubuntu image name
output "latest_ubuntu_name" {
  value = data.aws_ami.latest_ubuntu.name
}

#output privet ip instance
output "server_private_ip" {
  value       = aws_instance.ubuntu.private_ip
  description = "This is private IP"
}
