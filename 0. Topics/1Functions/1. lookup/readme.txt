What is lookup?
look up retrieves the value of a single element from a map, given its key.

Add the following configuration to your variables.tf file to declare a new input variable.
variable "aws_amis" {
  type = map
  default = {
    "us-east-1" = "ami-0739f8cdb239fe9ae"
    "us-west-2" = "ami-008b09448b998a562"
    "us-east-2" = "ami-0ebc8f6f580a04647"
  }
}

This input variable includes a default value of a map of region-specific AMI IDs for three regions.

Now, open the main.tf file and remove the data source for your AMI ID.
- data "aws_ami" "ubuntu" {
- most_recent = true

- filter {
-  name = "name"
-  values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
- }

- filter {
-   name = "virtualization-type"
-   values = ["hvm"]
-  }
- owners = ["099720109477"] # Canonical
- }

In your aws_instance resource, update the ami attribute to use the lookup function.
##...
resource "aws_instance" "web" {
- ami                         = data.aws_ami.ubuntu.id
+ ami                         = lookup(var.aws_amis, var.aws_region)
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet_public.id
  vpc_security_group_ids      = [aws_security_group.sg_8080.id]
  associate_public_ip_address = true
  user_data                   = templatefile("user_data.tftpl", { department = var.user_department, name = var.user_name })
}
The ami is a required attribute for the aws_instance resource, so the lookup function must return a valid value for Terraform to apply your configuration. The lookup function arguments are a map, the key to access in the map, and an optional default value in case the key does not exist.

Next, add the following configuration for an ami_value output to your outputs.tf file. 
This output lets you verify the AMI returned by the lookup function.
output "ami_value" {
  value = lookup(var.aws_amis, var.aws_region)
}

------------------------------------------------
accessing using amis - using map and lookup
We can also write the azs using map and lookup
------------------------------------------------