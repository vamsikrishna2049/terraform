# Define the EC2 instance in public subnet's
resource "aws_instance" "public_subnet" {
  count                       = var.environment == "production" ? 4 : 2
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "vockey" # It was already available. If not create a new keypair and mention here.
  subnet_id                   = element([var.public_subnet1.id, var.public_subnet2], count.index % 2)
  vpc_security_group_ids      = [var.sg_name]
  associate_public_ip_address = true
  user_data                   = file("${path.module}/script.sh")

  tags = {
    Name = "${var.prefix}-pub-sn-${count.index + 1}" # Unique names for each instance
  }
}
