## Challenge 1 - Hardcoded Values
* The values are hardcoded as part of the module.
- If developer is calling the module, he will have to stick with same values, Developer will not be able to override the hardcoded values of the module.
- Avoid hard-coding region in the Module code as much as possible if it is declared. A required_provider block with version constraints for module to work is important.

```sh
# Module code (Module3-workSpace directory on GitHub)
resource "aws_instance" "ec2Machine" {
  ami = "ami-01b799c439fd5516a"
  instance_type = "t2.micro"
}
```
Replaced the hardcoded values with the variables, also have added required provider block with version constraints.
`modules-ec2.tf `
```sh
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.62"
    }
  }
}
resource "aws_instance" "ec2MAchine" {
    ami = var.ami
    instance_type = var.instanceType
  
}

variable "ami" { }
variable "instanceType" { 
```

Calling custom module with the required values.
`main.tf `
```
module "ec2" {
    source = "github.com/anii234/infracode-recipes.git//Module3-workSpace"
    instanceType = "t2.micro"
    ami = "ami-01b799c439fd5516a" 
}
```


