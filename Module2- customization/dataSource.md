### Data sources are like special tools in Terraform that let you reach out and grab information from existing infrastructure or external systems. It's like having a remote control for your infrastructure.
Imagine you've built some infrastructure, like an EC2 machine. Now, you want to find out details about that machine, like its ID or IP address. That's where data sources come in.

### Example 1 - Reading a File
Following data source allows you to read contents of a file in your local filesystem. `${path.module}` returns the current file system path where your code is located.

```sh

data "local_file" "para" {
  filename = "${path.module}/sample.txt"
}

output "show" {
  value = data.local_file.para.content
}
```

### Key Points:

#### 1. Data sources don't create new infrastructure; they gather information about existing things.
#### 2. They're like read-only tools; they can't modify anything directly.
#### 3. You can use data sources to get information from various sources, like cloud providers, external APIs, or even other Terraform configurations.

### Benefits:

#### 1. Dynamic infrastructure: Your code can adapt based on real-world information.
#### 2. Modular code: Data sources help keep your code organized and reusable.
#### 3. Reduced errors: You rely less on hardcoded values, minimizing mistakes.
