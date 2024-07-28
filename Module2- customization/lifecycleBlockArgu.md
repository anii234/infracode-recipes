**By setting the `create_before_destroy` argument to `true` within the `lifecycle` block, you're instructing Terraform to create the new Ubuntu instance before destroying the old Amazon Linux instance.**

This ensures zero downtime as the new instance is up and running before the old one is terminated.

### Example:

```sh
resource "aws_instance" "mark1" {
    ami = "ami-04a81a99f5ec58529"
    tags = {
        name = "staging1"
    }
    instance_type = "t2.micro"

    lifecycle {
        create_before_destroy = true      
    }
}

```

`terraform.exe plan -var-file="./../../secrets.tfvars" `

```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following        
symbols:
+/- create replacement and then destroy

Terraform will perform the following actions:

  # aws_instance.mark1 must be replaced
+/- resource "aws_instance" "mark1" {
      ~ ami                                  = "ami-0427090fd1714168b" -> "ami-04a81a99f5ec58529" # forces replacement
      ~ arn                                  = "arn:aws:ec2:us-east-1:767951427229:instance/i-07b178e9af2957fa3" -> (known after apply)  
      ~ associate_public_ip_address          = true -> (known after apply)
      ~ availability_zone                    = "us-east-1d" -> (known after apply)
```

## Lifecycle Arguments in Terraform

| Argument | Description | Usage in Production |
|---|---|---|
| `create_before_destroy` | Boolean indicating whether to create a replacement resource before destroying the existing one. | Useful for resources with long creation times or where downtime is critical (e.g., EC2 instances, databases). However, consider the increased cost and potential for resource conflicts. |
| `prevent_destroy` | Boolean indicating whether to prevent the resource from being destroyed. | Used to protect critical resources from accidental deletion. Exercise caution as it can hinder infrastructure changes. |
| `ignore_changes` | List of attribute names to ignore when planning updates. | Used to prevent Terraform from managing specific attributes that are managed externally or are prone to spurious diffs. Useful for tags, metadata, or attributes managed by other systems. |
| `replace_triggered_by` | List of resource or attribute references. | Indicates that a resource should be replaced when a specific resource or attribute changes. Used for complex dependencies or when in-place updates are not possible. Requires careful consideration of potential impacts. |

