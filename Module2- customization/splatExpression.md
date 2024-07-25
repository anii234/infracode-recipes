## Splat Expression : Splat Expression allows us to get a list of all the attributes.
`main.tf`

```sh
resource "aws_iam_user" "lb" {
  name = var.username[count.index]
  path = "/system/"
  count = 4

  tags = {
    tag-key = var.username[count.index]
  }
}

output "username" {
  value = aws_iam_user.lb[*].arn
}
```

`variable.tf `
```sh
variable "username" {
  type = list
  default = ["l1","l2","l3","l4"]
}
```
Output:
```sh
Outputs:

username = [
  "arn:aws:iam::729732329660:user/system/l1",
  "arn:aws:iam::729732329660:user/system/l2",
  "arn:aws:iam::729732329660:user/system/l3",
  "arn:aws:iam::729732329660:user/system/l4",
]
```


