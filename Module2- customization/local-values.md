### Code where we are using the same tag `machineName` in more than one blocks.

```sh
resource "aws_instance" "ec2Machine" {
      ami = "ami-0b72821e2f351e396"
      instance_type = "t2.micro"
      tags = {
        "machineName" = "test1"
      }
}

resource "aws_security_group" "sgtest1" {
  name = "allow_tls"
  description = "Allow tls inbound and outbound traffic"
  tags = {
    "machineName" = "test1"
    "Name" = "allow_tls"
  }
}
```

### Locals can store the result of calculations, which variables cannot. This lets you define complex values based on other resources or variables within your code.
in below example `creationDate` will be created dynamically and `machineName` value stored centrally, same can be access in other blocks.

``` sh
locals {
  creationDate = "date-${formatdate("DDMMYY", timestamp())}"
  machineName = "test1"
}

resource "aws_instance" "ec2Machine" {
      ami = "ami-0b72821e2f351e396"
      instance_type = "t2.micro"
      tags = {
        "machineName" = local.machineName
        "creationDate" = local.creationDate

      }
}

resource "aws_security_group" "sgtest1" {
  name = "allow_tls"
  description = "Allow tls inbound and outbound traffic"
  tags = {
    "machineName" = local.machineName
    "Name" = "allow_tls"
  }
}

```
