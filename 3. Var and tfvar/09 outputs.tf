output "aws_vpc" {
  value = "${aws_vpc.main.id}"
}

output "aws_subnet" {
  value = "${aws_subnet.PUB-SN.id}"
}

output "aws_internet_gateway" {
  value = "${aws_internet_gateway.igw.id}"
}

output "aws_route_table" {
  value = "${aws_route_table.RT-Main.id}"
}

output "sgroup" {
  value = "${aws_security_group.SG.id}"
}

