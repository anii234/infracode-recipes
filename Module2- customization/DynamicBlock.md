### In many of the use-cases, there are repeatable nested blocks that needs to be defined. This can lead to a long code and it can be difficult to manage in a longer time.
In the below example, 4 ingress rules are defined, they may can increase by 100's as per the project need, which may requires more no. of nested blocks.

#### Before 
```sh
resource "aws_security_group" "allow_tls" {
  name        = "terraform-firewall"
  description = "Managed from Terraform"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 8080
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 9090
    protocol    = "tcp"
    to_port     = 9090
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 9050
    protocol    = "tcp"
    to_port     = 9050
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 9040
    protocol    = "tcp"
    to_port     = 9040
  }
}
```

After Dynamic block.
Declared ports into the `variable.tf `
```sh
variable "sg-ports" {
  type = list
  default = [8080,9090,9050,9040]
}
```
Get the ports value under the dynamic block
`main.tf `
```sh
resource "aws_security_group" "allow_tls2" {
  name        = "terraform-firewall-dynamicBlock"
  description = "Managed from Terraform"
  dynamic "ingress" {
    for_each = var.sg-ports
    content {
        from_port = ingress.value
        to_port =   ingress.value
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]

    }
  }
}
```


