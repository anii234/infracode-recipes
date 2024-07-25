### The zipmap function constructs a map from a list of keys and a corresponding list of values.

`main.tf `
```sh

resource "aws_iam_user" "lb" {
  name = var.username[count.index]
  path = "/system/"
  count = 4

  tags = {
    tag-key = var.username[count.index]
  }
}

output "arn" {
  value = aws_iam_user.lb[*].arn
}

output "username" {
  value = aws_iam_user.lb[*].name
}

# using of the zip mapo function 

output "mapping" {
  value = zipmap(aws_iam_user.lb[*].arn,aws_iam_user.lb[*].name)
}
```
**Output**
```sh
Outputs:

arn = [
  "arn:aws:iam::729732329660:user/system/l1",
  "arn:aws:iam::729732329660:user/system/l2",
  "arn:aws:iam::729732329660:user/system/l3",
  "arn:aws:iam::729732329660:user/system/l4",
]
mapping = {
  "arn:aws:iam::729732329660:user/system/l1" = "l1"
  "arn:aws:iam::729732329660:user/system/l2" = "l2"
  "arn:aws:iam::729732329660:user/system/l3" = "l3"
  "arn:aws:iam::729732329660:user/system/l4" = "l4"
}
username = [
  "l1",
  "l2",
  "l3",
  "l4",
]
```
