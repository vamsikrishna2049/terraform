resource "aws_instance" "pub-ser" {
  count                  = var.pub_subnet_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = element(aws_subnet.pub_sn.*.id, count.index)
  vpc_security_group_ids = ["${aws_security_group.TF_SG.id}"]
  tags = {
    Name = "TF-${count.index + 1}-Machine"
  }
}
