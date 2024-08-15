**Terraform Custom Modules: Making Infrastructure Reusable**

In Terraform, you have the power to create custom modules, which are reusable blocks of infrastructure code. Imagine these modules as building blocks – you define them once, and then you can incorporate them into various Terraform configurations as needed. This approach promotes code organization, reduces redundancy, and simplifies infrastructure management.

**Storing Your Modules: Flexibility Across Platforms**

Terraform provides flexibility in terms of where you store your custom modules. Here are some popular options:

- **GitHub:** A popular version control system that's perfect for sharing your modules publicly or within a team.
- **Terraform Registry:** HashiCorp's official registry where you can publish modules for wider use by the community.
- **S3 Bucket:** An Amazon S3 bucket can be used to store modules privately, especially if you have security considerations.

**Creating a Basic Module on GitHub (Example Breakdown)**

Let's delve into the example you provided, which demonstrates the creation of a basic module stored on GitHub. Here's a simplified explanation:

```terraform
# Module code (Module3-workSpace directory on GitHub)
resource "aws_instance" "ec2Machine" {
  ami = "ami-01b799c439fd5516a"
  instance_type = "t2.micro"
}
```

This code defines an AWS instance resource named `ec2Machine`. It specifies the Amazon Machine Image (AMI) and instance type.

**Calling the Module from Local Code**

Now, let's see how you can call this module from another Terraform configuration file located on your local system:

```terraform
# Local Terraform code
provider "aws" {
  region = var.region
  secret_key = var.secret_key
  access_key = var.access_key
}

module "ec2" {
  source = "github.com/anii234/infracode-recipes.git//Module3-workSpace"
}
```

Here's a breakdown of this code:

1. **AWS Provider Configuration:** This section sets up the AWS provider, specifying the region, secret key, and access key (likely defined in Terraform variables).
2. **Module Call:** The `module` block defines a module named `ec2`. The crucial part is the `source` argument, which points to the GitHub repository and the directory containing the module.

**Key Points:**

- By storing your modules in a central location like GitHub, you maintain version control and enable easy collaboration.
- The `source` argument in the `module` block tells Terraform where to find the custom module.
- Custom modules promote code organization, reduce redundancy, and streamline infrastructure management.

**Additional Considerations:**

- **Module Inputs and Outputs:** Custom modules can accept input variables that allow you to customize their behavior when calling them. They can also provide output values that you can reference in your main configuration.
- **Advanced Module Features:** Explore features like module nesting for complex infrastructure definitions and passing data between modules for better organization.
