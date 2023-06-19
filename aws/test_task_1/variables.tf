#Instance type
variable "instance_type" {
  description = "Server"
  type        = string
  default     = "t2.micro"
}

# Latest ubuntu install
data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

#Ports http/https
variable "http_ports" {
  description = "Listen port"
  type        = list
  default     = ["80", "8080", "443"]
}
#Port ssh
variable "ssh_ports" {
  description = "Listen port"
  type        = list
  default     = ["22"]
}

#Privet ip address
variable "private_ip_address" {
  description = "Private IPv4 address of EC2 instance"
  type        = string
  default     = "aws_instance.ubuntu.private_ip"
}