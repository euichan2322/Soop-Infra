resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project}-vpc"
    project = var.project
    env = var.env
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 0)
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "${var.project}-public-subnet-a"
    project = var.project
    env = var.env
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 1)
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-2b"

  tags = {
    Name = "${var.project}-public-subnet-b"
    project = var.project
    env = var.env
  }
}

resource "aws_subnet" "private_subnet_a1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 100)
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "${var.project}-private-subnet-a1"
    project = var.project
    env = var.env
  }
}

resource "aws_subnet" "private_subnet_a2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 125)
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "${var.project}-private-subnet-a2"
    project = var.project
    env = var.env
  }
}

resource "aws_subnet" "private_subnet_b1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 150)
  availability_zone = "ap-northeast-2b"

  tags = {
    Name = "${var.project}-private-subnet-b1"
    project = var.project
    env = var.env
  }
}

resource "aws_subnet" "private_subnet_b2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 175)
  availability_zone = "ap-northeast-2b"

  tags = {
    Name = "${var.project}-private-subnet-b2"
    project = var.project
    env = var.env
  }
}

resource "aws_subnet" "db_subnet_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 200)
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "${var.project}-db-subnet1"
    project = var.project
    env = var.env
  }
}

resource "aws_subnet" "db_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 201)
  availability_zone = "ap-northeast-2b"

  tags = {
    Name = "${var.project}-db-subnet2"
    project = var.project
    env = var.env
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-igw"
    project = var.project
    env = var.env
  }
}

resource "aws_eip" "ngw_eip" {
  tags = {
    Name = "${var.project}-ngw-eip"
    project = var.project
    env = var.env
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw_eip.id
  subnet_id = aws_subnet.public_subnet_1.id

  tags = {
    Name = "${var.project}-ngw"
    project = var.project
    env = var.env
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project}-public-rt"
    project = var.project
    env = var.env
  }
}

resource "aws_route_table" "private-rt-a" {
  vpc_id = aws_vpc.vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name = "${var.project}-private-rt-a"
    project = var.project
    env = var.env
  }
}

resource "aws_route_table" "private-rt-b" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "${var.project}-private-rt-b"
    project = var.project
    env = var.env
  }
}

resource "aws_route_table_association" "public-rt-assoc" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "private-rt-a1-assoc" {
  subnet_id = aws_subnet.private_subnet_a1.id
  route_table_id = aws_route_table.private-rt-a.id
}

resource "aws_route_table_association" "private-rt-a2-assoc" {
  subnet_id = aws_subnet.private_subnet_a2.id
  route_table_id = aws_route_table.private-rt-a.id
}

resource "aws_route_table_association" "private-rt-b1-assoc" {
  subnet_id = aws_subnet.private_subnet_b1.id
  route_table_id = aws_route_table.private-rt-b.id
}

resource "aws_route_table_association" "private-rt-b2-assoc" {
  subnet_id = aws_subnet.private_subnet_b2.id
  route_table_id = aws_route_table.private-rt-b.id
}