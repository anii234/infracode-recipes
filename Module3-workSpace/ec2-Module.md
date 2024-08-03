### Create Ec2 instance using module.

https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest

```sh
module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"
  for_each = var.machine
  name = each.value
}
```
### command to execute 
```
terraform init 
terraform.exe plan -var-file="../../secrets.tfvars"
terraform.exe apply -var-file="../../secrets.tfvars"

```

