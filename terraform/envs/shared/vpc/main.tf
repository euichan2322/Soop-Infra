resource "aws_vpc" "vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "soop-vpc"
    project = "soop"
    env = "shared"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.1.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "soop-public-subnet-a"
    project = "soop"
    env = "shared"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "soop-public-subnet-b"
    project = "soop"
    env = "shared"
  }
}

resource "aws_subnet" "private_subnet_a1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.1.100.0/24"

  tags = {
    Name = "soop-private-subnet-a1"
    project = "soop"
    env = "shared"
  }
}

resource "aws_subnet" "private_subnet_a2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.1.125.0/24"

  tags = {
    Name = "soop-private-subnet-a2"
    project = "soop"
    env = "shared"
  }
}

resource "aws_subnet" "private_subnet_b1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.1.150.0/24"

  tags = {
    Name = "soop-private-subnet-b1"
    project = "soop"
    env = "shared"
  }
}

resource "aws_subnet" "private_subnet_b2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.1.175.0/24"

  tags = {
    Name = "soop-private-subnet-b2"
    project = "soop"
    env = "shared"
  }
}

resource "aws_subnet" "db_subnet_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.1.200.0/24"

  tags = {
    Name = "soop-db-subnet1"
    project = "soop"
    env = "shared"
  }
}

resource "aws_subnet" "db_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.1.201.0/24"

  tags = {
    Name = "soop-db-subnet2"
    project = "soop"
    env = "shared"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "soop-igw"
    project = "soop"
    env = "shared"
  }
}

resource "aws_eip" "ngw_eip" {
  tags = {
    Name = "soop-ngw-eip"
    project = "soop"
    env = "shared"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw_eip.id
  subnet_id = aws_subnet.public_subnet_1.id

  tags = {
    Name = "soop-ngw"
    project = "soop"
    env = "shared"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "soop-public-rt"
    project = "soop"
    env = "shared"
  }
}

resource "aws_route_table" "private-rt-a" {
  vpc_id = aws_vpc.vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name = "soop-private-rt-a"
    project = "soop"
    env = "shared"
  }
}

resource "aws_route_table" "private-rt-b" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "soop-private-rt-b"
    project = "soop"
    env = "shared"
  }
}

resource "aws_route_table_association" "public-rt-assoc" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "private-rt1-assoc" {
  subnet_id = aws_subnet.private_subnet_a1.id
  route_table_id = aws_route_table.private-rt-a.id
}

resource "aws_route_table_association" "private-rt2-assoc" {
  subnet_id = aws_subnet.private_subnet_a2.id
  route_table_id = aws_route_table.private-rt-b.id
}