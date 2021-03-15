variable "region" {
  default = "ap-south-1"
}
variable "aws_instance_name" {
  default = "Terraform-aws-technix"
}
variable "aws_instance_my_infra_ami" { 
  type = string
  default = "ami-0a9d27a9f4f5c0efc"
}
