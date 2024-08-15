resource "aws_instance" "ec2MAchine" {
    ami = var.ami
    instance_type = var.instanceType
  
}

variable "ami" { }
variable "instanceType" { }
