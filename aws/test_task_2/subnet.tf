#====================public_subnets=========================
resource "aws_subnet" "public_subnets_1" {
  count                   = length(var.public_subnet_1)
  vpc_id                  = aws_vpc.clh_contractors.id
  cidr_block              = element(var.public_subnet_1, count.index )
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags                    = {
    Name = "${var.clh_contractors}-public_subnet-${count.index +1}-${data.aws_availability_zones.available.names[0]}"
  }
}

resource "aws_subnet" "public_subnets_2" {
  count                   = length(var.public_subnet_2)
  vpc_id                  = aws_vpc.clh_contractors.id
  cidr_block              = element(var.public_subnet_2, count.index )
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags                    = {
    Name = "${var.clh_contractors}-public_subnet-${count.index +2}-${data.aws_availability_zones.available.names[1]}"
  }
}

#==================privet_subnets==========================

resource "aws_subnet" "private_subnets_1" {
  count             = length(var.private_subnet_1)
  vpc_id            = aws_vpc.clh_contractors.id
  cidr_block        = element(var.private_subnet_1, count.index )
  availability_zone = data.aws_availability_zones.available.names[0]
  tags              = {
    Name = "${var.clh_contractors}-private_subnet-${count.index +1}-${data.aws_availability_zones.available.names[0]}"
  }
}

resource "aws_subnet" "private_subnets_2" {
  count             = length(var.private_subnet_2)
  vpc_id            = aws_vpc.clh_contractors.id
  cidr_block        = element(var.private_subnet_2, count.index )
  availability_zone = data.aws_availability_zones.available.names[1]
  tags              = {
    Name = "${var.clh_contractors}-private_subnet-${count.index +2}-${data.aws_availability_zones.available.names[1]}"
  }
}