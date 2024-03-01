data "aws_subnet" "public-subnet1" {
  filter {
    name   = "subnet-id"
    values = [var.pub_sn_1]
  }
}

data "aws_subnet" "public-subnet2" {
  filter {
    name   = "subnet-id"
    values = [var.pub_sn_2]
  }
}
