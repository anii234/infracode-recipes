### Base Demo Configuration:
```sh
provider "aws" {
  region     = "ap-southeast-1"
  access_key = "YOUR-KEY"
  secret_key = "YOUR-KEY"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "allow_ssh_conn" {
  name        = "allow_ssh_conn"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH into VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP into VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Outbound Allowed"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "myec2" {
   ami = "ami-0b1e534a4ff9019e0"
   instance_type = "t2.micro"
   key_name = "ec2-key"
   vpc_security_group_ids  = [aws_security_group.allow_ssh_conn.id]
}
```
## Understanding `terraform plan -refresh=false` and `terraform plan -refresh=false -target=aws_security_group.allow_ssh_conn`

### Terraform Plan Basics
Before diving into the specific commands, let's understand the core concept. When you run `terraform plan`, Terraform compares your desired state (defined in your configuration files) with the actual state of your infrastructure (stored in the state file). It then creates a plan outlining the changes needed to match the desired state.

### `terraform plan -refresh=false`

* **Normal behavior:** Terraform usually checks the actual state of your infrastructure before creating the plan. This is called refreshing the state.
* **With `-refresh=false`:** This flag tells Terraform to skip this check. It uses the information already stored in the state file without updating it.

**Why use it?**
* **Speed:** Refreshing the state can be time-consuming, especially for large infrastructures.
* **Consistency:** If you're confident that the state file is accurate, you can skip the refresh to ensure the plan is based on the same information used in previous runs.

### `terraform plan -refresh=false -target=aws_security_group.allow_ssh_conn`

This command combines the `-refresh=false` flag with a `-target` option.

* **Target:** The `-target` flag specifies a specific resource or set of resources to focus on. In this case, it's targeting only the security group rule allowing SSH connections.
* **Combined effect:** Terraform will create a plan without refreshing the state, but it will only consider changes to the specified security group rule.

**Why use it?**
* **Efficiency:** If you only want to modify a specific part of your infrastructure, targeting that resource can speed up the planning process.
* **Precision:** By focusing on a single resource, you can be more confident in the changes that will be made.

### Handling Large Infrastructure

Both commands can be useful for managing large infrastructures:

* **`-refresh=false`:** Can significantly speed up the planning process, especially when dealing with many resources.
* **`-target`:** Allows you to focus on specific parts of your infrastructure, making it easier to manage complex setups.

**Important:** While these options can improve efficiency, it's essential to use them carefully. If the state file is outdated or inaccurate, it can lead to unexpected results. Always consider the potential risks before using these flags.
