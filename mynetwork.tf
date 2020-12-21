terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}


provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_vpc" "primary" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "stockholm-vpc-1"
  }
}

resource "aws_subnet" "main1" {
  vpc_id = aws_vpc.primary.id
  cidr_block = "192.168.10.0/24"
  tags = {
    Name = "stockholm-vpc-1-subnet-1"
  }
}

resource "aws_internet_gateway" "maingw1" {
  vpc_id = aws_vpc.primary.id
  tags = {
    Name = "igw-vpc-1"
  }
}

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.primary.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.maingw1.id
  }
  tags = {
    Name = "route-stockholm-vpc-1"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main1.id
  route_table_id = aws_route_table.r.id
}
