resource "aws_instance" "ec2MAchine" {
    ami = "ami-01b799c439fd5516a"
    tags = {
      Name = var.serverType[count.index]
    }
    count = 3
    instance_type = "t2.micro"
  
}
