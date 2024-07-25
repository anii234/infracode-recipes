
### taint.tf
```sh
resource "aws_instance" "myec2" {
    ami = "ami-00c39f71452c08778"
    instance_type = "t2.micro"
}

```

### Recreating the resource:
```sh
terraform apply -replace="aws_instance.myec2"
```
