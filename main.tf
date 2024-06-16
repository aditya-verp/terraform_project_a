resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "TaskVPC"
  }
}

#-------------  SubNets Configuration START    -----------#
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.private_avalilability_zone

  tags = {
    Name = "PrivateSubnet"
    Partof = "TaskProject"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_subnet_cidr_b
  availability_zone = var.public_avalilability_zone_b

  tags = {
    Name = "PrivateSubnet"
    Partof = "TaskProject"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = var.public_avalilability_zone

  tags = {
    Name = "PublicSubnet"
    Partof = "TaskProject"
  }
}
#-------------  SubNets Configuration END    -----------#

#-------------  Internat Gateway START    -----------#
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "MainVPCIGW"
    Partof = "TaskProject"
  }

  depends_on = [
    aws_vpc.main_vpc
  ]
}
#-------------  Internat Gateway END    -----------#

#-------------  public_route_table START      -----------#
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "PublicRouteTable"
    Partof = "TaskProject"
  }
}
resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}
#-------------  public_route_table END      -----------#

#-------------  private_route_table START      -----------#
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "PrivateRouteTable"
    Partof = "TaskProject"
  }
}

resource "aws_route_table_association" "private_rta" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "tls_private_key" "bastion_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
#-------------  private_route_table END      -----------#

#-------------  Nat Gateway with Elastic IP START    -----------#
resource "aws_eip" "nat_eip" {
  domain   = "vpc"
  tags = {
    Name = "NatEIP"
    Partof = "TaskProject"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = "NatGateway"
    Partof = "TaskProject"
  }
  depends_on = [
    aws_internet_gateway.igw
  ]
}
#-------------  Nat Gateway with Elastic IP END    -----------#