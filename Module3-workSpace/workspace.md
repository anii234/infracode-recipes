## Terraform Workspaces: Managing Multiple Environments

**Terraform workspaces** provide a way to manage multiple independent sets of infrastructure using the same configuration. Think of them as separate containers for your Terraform state, allowing you to isolate different environments like development, staging, and production. 

By creating different workspaces, you can:
* **Manage distinct infrastructure:** Each workspace represents a unique set of resources.
* **Prevent conflicts:** Changes in one workspace don't affect others.
* **Test and deploy independently:** Iterate on configurations without impacting production.

Essentially, workspaces help you organize and manage your infrastructure efficiently while maintaining clear separation between different environments. 


- to create a new workspace
`terraform workspace list dev `

- to select the workspace to create infra
`terraform workspace select dev`

 - to check the current workspace
```sh
$ terraform workspace list
default
* dev
 prod
```



In below example Ec2 instance type will be selected based on the pointed workspace
```

locals {
  instance_type = {
    default = "t2.nano"
    dev = "t2.micro"
    prod = "m5.micro"
  }
}

resource "aws_instance" "ec2MAchine" {
    ami = var.ami
    instance_type = local.instance_type[terraform.workspace]
  
}

variable "ami" { }
variable "instanceType" { }
```
