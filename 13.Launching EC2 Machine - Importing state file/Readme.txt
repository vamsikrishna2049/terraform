In the prev example, we learnt about how to use modules and advantages of modules.

In the current session, we're learning about backup.

Example:
  We all know importance of statefile. If we lost statefile with no backup, How can we retrieve ?



Create a new terraform file at root module (Not inside the module) with .tf extension. 
Write the code whatever the resources you want to retrieve from aws cloud.

terraform init  -> It will initialize the terraform.
terraform show  -> It will show the info about statefile configured aws

Example, If you want to retrieve aws vpc then write the code like below

resource "aws_vpc" "name" {
  cidr_block           = "CIDR_BLOCK_OF_EXISTING_VPC" # Shown as per aws cloud
  instance_tenancy     = "INSTANCE_TENANCY"           # Shown as per aws cloud
  enable_dns_hostnames = true                         # Shown as per aws cloud
  tags = {
    Name = "YOUR_VPC_NAME"                            # Shown as per aws cloud
  }
}

terraform import aws_vpc.name vpc-060062df20ff6fa51   
Here "vpc-060062df20ff6fa51" is vpc-id allocated in aws cloud.
