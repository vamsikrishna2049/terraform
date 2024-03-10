# Creating DB Subnet Group for RDS
resource "aws_db_subnet_group" "subnet_groups" {
  subnet_ids = [aws_subnet.pvt_sn2.id, aws_subnet.pvt_sn3.id]
  name       = "${var.prefix}_db_subnet_group"

  tags = {
    Name = "${var.prefix}_db_subnet_group"
  }
}

It will create Single RDS - MySQL is created. 
resource "aws_db_instance" "primary" {
 allocated_storage           = 30
 vpc_security_group_ids      = [aws_security_group.DB_SG.id]
 db_subnet_group_name        = aws_db_subnet_group.subnet_groups.id
 db_name                     = "${var.prefix}main"
 engine                      = var.engineType
 engine_version              = var.engineVersion
 instance_class              = var.dbInstType
 username                    = var.username
 password                    = var.password
 auto_minor_version_upgrade  = var.minorVersionUpgrade
 allow_major_version_upgrade = var.majorVersionUpgrade
 backup_window               = var.backup_window
 backup_retention_period     = var.backup_retention_period
 #Use anyone of below
 # final_snapshot_identifier   = true # Set this to true to create a final snapshot
 skip_final_snapshot = var.skip_final_snapshot

 tags = {
   Name = "${var.prefix}main"
 }
}
