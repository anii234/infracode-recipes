```

resource "aws_instance" "mark1" {
    ami = "ami-04a81a99f5ec58529"
    for_each = {
            "key1" : "t2.micro"
            "key2" : "t3.micro"
        }

    key_name = each.key
    tags = {
        name = "staging1"
    }
    instance_type = each.value



}
```
