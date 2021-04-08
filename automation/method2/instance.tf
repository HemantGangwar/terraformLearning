resource "aws_instance" "r100c96" {
  ami               = "ami-0a9d27a9f4f5c0efc"
  instance_type     = "t2.micro"
  availability_zone = "ap-south-1b"
  key_name          = "aws-exam-testing"
  user_data         = file("installcommand.sh")
  tags = {
    Name = "Terraform-diff-linux"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.r100c96.public_dns} > inventory"
  }

  provisioner "local-exec" {
    command = "sleep 150"
  }

  provisioner "local-exec" {
    command = "ansible all -m shell -a 'yum -y install httpd; systemctl restart httpd'"
  }

}

output "ip" {
  value = aws_instance.r100c96.public_ip
}

output "publicName" {
  value = aws_instance.r100c96.public_dns
}
