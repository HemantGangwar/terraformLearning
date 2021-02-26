variable "region" {
  default = "ap-south-1"
}
variable "aws_instance_name" {
  default = "Terraform-aws-technix"
}
variable "aws_instance_my_infra_ami" { type = string }
variable "aws_instance_security_group" {
  default = "r03hg16_allow_all"
}
variable "instancetype" { type = string }
variable "mytypes" { type = map }
variable "instancelist" { type = list }
