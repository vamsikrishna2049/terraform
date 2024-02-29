condition ? true_val : false_val
instance_type               = [var.key_name == "Laptop" ? 1 : 0]

resource "aws_instance" "public-servers" {
  count = var.pub_subnet_count # Specific no of instances will deploy
  ami                         = lookup(var.amis, var.region)
  key_name                    = var.key_name

  instance_type               = var.key_name == "Laptop" ? 3 : 1 # if key_name is Laptop then it will deploy 3 instances else 1 
  instance_type               = var.instance_type

  subnet_id                   = element(aws_subnet.pub_sn.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name = "${var.vpc_name}-pub-${count.index + 1}"
  }
}


Compare both the public and private servers


Reference:
https://developer.hashicorp.com/terraform/language/expressions/conditionals