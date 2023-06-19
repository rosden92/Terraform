#-------------------------------
#Provaider
provider "aws" {
}

# Create Elastic IP addresses for my ubuntu server
resource "aws_eip" "my_static_ip" {
  instance = aws_instance.ubuntu.id
  tags     = {
    Name = "ubuntu"
  }
}

# Install server ubuntu EC2
resource "aws_instance" "ubuntu" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]
  user_data              = file("./files/update.sh")
  tags                   = {
    Name = "ubuntu"
  }
  # Destroy server after change
  lifecycle {
    create_before_destroy = true
  }
}

# Install security group
# Create http/https security group
resource "aws_security_group" "allow_http" {
  name        = "http"
  description = "Allow http inbound traffic"

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

  tags = {
    Name = "ssh"
  }

}
