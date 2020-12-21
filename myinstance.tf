resource "aws_instance" "r100c86" {
  ami           = var.aws_instance_my_infra_ami
  instance_type = "t3.micro"
  associate_public_ip_address = true
#  security_groups = [ var.aws_instance_security_group ]
  subnet_id     = aws_subnet.main1.id
  vpc_security_group_ids = [ aws_security_group.r03hg16_allow_all.id ]
  key_name      = "r03g16hg"
  tags = {
    Name  = var.aws_instance_name
  }
}
