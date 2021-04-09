resource "aws_instance" "r100c96" {
  ami               = "ami-0a9d27a9f4f5c0efc"
  instance_type     = "t2.micro"
  availability_zone = "ap-south-1b"
  key_name          = "aws-exam-testing"
  tags = {
    Name = "Terraform-diff-linux"
  }

  provisioner "remote-exec" {
    inline = [ "sudo hostnamectl set-hostname cloudEc2.technix.com" ]
    connection {
      host        = aws_instance.r100c96.public_dns
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./aws-exam-testing.pem")
    }
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.r100c96.public_dns} > inventory"
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
