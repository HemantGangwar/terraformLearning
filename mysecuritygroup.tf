
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
  vpc_id      = aws_vpc.primary.id
  tags = {
    Name = "stockholm-vpc-1-allow_all"
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

