#1. Creating custom VPC #
resource "aws_vpc" "primary" {
  cidr_block = "192.168.16.0/24"
  tags = {
    Name = "custom-vpc-technix"
  }
}

#2. Creating 3 subnets in custom VPC #
resource "aws_subnet" "main1" {
  vpc_id = aws_vpc.primary.id
  availability_zone = "ap-south-1a"
  cidr_block = "192.168.16.0/26"
  tags = {
    Name = "prod-subnet(subnet1)"
  }
}

resource "aws_subnet" "main2" {
  vpc_id = aws_vpc.primary.id
  availability_zone = "ap-south-1b"
  cidr_block = "192.168.16.64/26"
  tags = {
    Name = "dev-subnet(subnet2)"
  }
}

resource "aws_subnet" "main3" {
  vpc_id = aws_vpc.primary.id
  availability_zone = "ap-south-1c"
  cidr_block = "192.168.16.128/26"
  tags = {
    Name = "dB-subnet(subnet3)"
  }
}


#3. Creating Internaet GW for Internet connectivity #
resource "aws_internet_gateway" "maingw1" {
  vpc_id = aws_vpc.primary.id
  tags = {
    Name = "learningtechnix-VPC-IgW"
  }
}

#4. Creating Elastic IP to be attached with NAT gateway
resource "aws_eip" "e-ip-natgw" {
  vpc              = true
}


#5. Creating NATGW
resource "aws_nat_gateway" "learningtechnix-nat-gw" {
  allocation_id = aws_eip.e-ip-natgw.id
  subnet_id     = aws_subnet.main1.id

  tags = {
    Name = "ltn-natGw"
  }
}


#6. Creating Routing tables for each subnet # 
resource "aws_route_table" "r" {
  vpc_id = aws_vpc.primary.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.maingw1.id
  }
  tags = {
    Name = "prod-subnet-RT"
  }
}

resource "aws_route_table" "s" {
  vpc_id = aws_vpc.primary.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.learningtechnix-nat-gw.id
  }
  tags = {
    Name = "dev-subnet-RT"
  }
}

resource "aws_route_table" "t" {
  vpc_id = aws_vpc.primary.id
  tags = {
    Name = "dB-subnet-RT"
  }
}


#7. Binding each routing table to appropriate subnet #
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main1.id
  route_table_id = aws_route_table.r.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.main2.id
  route_table_id = aws_route_table.s.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.main3.id
  route_table_id = aws_route_table.t.id
}


#8. Adding SG to be applied  

resource "aws_security_group" "r03hg16_allow_all" {
  name        = "r03hg16_allow_all"
  description = "Allow ALL inbound/outbound traffic"
  ingress {
    description = "SSH for VM"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Ping for VM"
    from_port   = -1
    to_port     = -1
    protocol    = "1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id      = aws_vpc.primary.id
  tags = {
    Name = "custom-SG-allow_all"
  }
}

resource "aws_security_group_rule" "example" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.r03hg16_allow_all.id
}

#9. Creating custom EC2

resource "aws_instance" "r100c86" {
  ami           = var.aws_instance_my_infra_ami
  instance_type = "t2.micro"
  key_name      = "aws-exam-testing"
  availability_zone = "ap-south-1a"
  subnet_id     = aws_subnet.main1.id
  vpc_security_group_ids = [aws_security_group.r03hg16_allow_all.id]
  associate_public_ip_address = "true"
  tags = {
    Name  = var.aws_instance_name
  }
}

resource "aws_instance" "r100c87" {
  ami           = var.aws_instance_my_infra_ami
  instance_type = "t2.micro"
  key_name      = "aws-exam-testing"
  availability_zone = "ap-south-1b"
  subnet_id     = aws_subnet.main2.id
  vpc_security_group_ids = [aws_security_group.r03hg16_allow_all.id]
  associate_public_ip_address = "false"
  tags = {
    Name  = var.aws_instance_name
  }
}

