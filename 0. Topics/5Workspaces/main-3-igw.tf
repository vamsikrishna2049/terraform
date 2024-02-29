#Create IGW and Connect to VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# # aws_internet_gateway.igw will be created
# + resource "aws_internet_gateway" "igw" {
#     + arn      = (known after apply)
#     + id       = (known after apply)
#     + owner_id = (known after apply)
#     + tags     = {
#         + "Name" = "dev-igw"
#       }
#     + tags_all = {
#         + "Name" = "dev-igw"
#       }
#     + vpc_id   = (known after apply)
#   }
