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