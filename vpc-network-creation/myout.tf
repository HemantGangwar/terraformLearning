output "ip" {
  value = aws_instance.r100c86.public_ip
}

output "KeyName" {
  value = aws_instance.r100c86.key_name
}

output "Subnets-Attached" {
  value = aws_instance.r100c86.subnet_id
}

output "PrivateEc2IP" {
  value = aws_instance.r100c87.private_ip
}
