resource "aws_security_group" "allow_http" {
  name        = "http"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.clh_contractors.id

  dynamic "ingress" {
    for_each = var.http_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "ingress" {
    for_each = var.http_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "http"
  }

}
# Create ssh security group
resource "aws_security_group" "allow_ssh" {
  name        = "ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.clh_contractors.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "ICMP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh"
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