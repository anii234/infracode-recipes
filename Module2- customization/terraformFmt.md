## Terraform fmt
Terraform fmt is like a code comb-over for your Terraform files. It tidies them up and makes them easier to read for you and anyone else working on the code.

### Before
``` sh
provider "aws" {
  region = var.region
          secret_key = var.secret_key
      access_key =                 var.access_key
}

# Reading the content from the local file system.

data "local_file" "para" {
               filename ="${path.module}/sample.txt"
}
```

`terraform fmt`
### After

``` sh
provider "aws" {
  region     = var.region
  secret_key = var.secret_key
  access_key = var.access_key
}

# Reading the content from the local file system.

data "local_file" "para" {
  filename = "${path.module}/sample.txt"
}
```
