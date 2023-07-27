#-------------------------------
#Provaider
provider "aws" {
  region = "eu-central-1"
}

#availability_zone
data "aws_availability_zones" "available" {}

resource "aws_vpc" "clh_contractors" {
  cidr_block = var.vpc_cidr
  tags       = {
    Name = "VPC-${var.clh_contractors}"
  }
}
#===========================================
resource "aws_internet_gateway" "test" {
  vpc_id = aws_vpc.clh_contractors.id
}

resource "aws_route_table" "public_subnet" {
  vpc_id = aws_vpc.clh_contractors.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test.id
  }
  tags = {
    Name = "${var.clh_contractors}-route-public-subnet"
  }
}

resource "aws_route_table_association" "public_route_1" {
  count          = length(aws_subnet.public_subnets_1[*].id)
  route_table_id = aws_route_table.public_subnet.id
  subnet_id      = aws_subnet.public_subnets_2[count.index].id
}

resource "aws_route_table_association" "public_route_2" {
  count          = length(aws_subnet.public_subnets_2[*].id)
  route_table_id = aws_route_table.public_subnet.id
  subnet_id      = aws_subnet.public_subnets_2[count.index].id
}

#===============================================================

resource "aws_instance" "VPN_host" {
  ami                    = var.vpn_host
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]
  subnet_id              = "subnet-076ad764a9cb9506a"
  key_name               = "d.rassokha"

  tags = {
    Name = "privet_subnets_1"
  }
}

resource "aws_instance" "VPN_host_2" {
  ami                    = var.vpn_host
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]
  subnet_id              = "subnet-0a1a47e8c3644eabe"
  key_name               = "d.rassokha"
  tags                   = {
    Name = "privet_subnets_2"
  }
}

resource "aws_instance" "VPN_host_3" {
  ami                    = var.vpn_host
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]
  subnet_id              = "subnet-08d7531878b87426f"
  key_name               = "d.rassokha"

  tags = {
    Name = "public_subnets_1"
  }
}

resource "aws_instance" "VPN_host_4" {
  ami                    = var.vpn_host
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]
  subnet_id              = "subnet-00fd7ae8e0795c886"
  key_name               = "d.rassokha"
  tags                   = {
    Name = "public_subnets_2"
  }
}