# Creating DB Subnet Group for RDS
resource "aws_db_subnet_group" "subnet_groups" {
  subnet_ids = [var.pvt_sn_cidr1, var.pvt_sn_cidr2]
  name       = "${var.prefix}-db_subnet_group"
  tags = {
    Name = "${var.prefix}-db-subnet-group"
  }
}

# # It will create Single RDS - MySQL is created. 
# resource "aws_db_instance" "primary" {
#   allocated_storage           = 30
#   vpc_security_group_ids      = [aws_security_group.rds_security_group_id]
#   db_subnet_group_name        = aws_db_subnet_group.subnet_groups.id
#   db_name                     = "${var.prefix}main"
#   engine                      = "mysql"
#   engine_version              = "5.7"
#   instance_class              = "db.t3.micro"
#   username                    = "root"
#   password                    = "Re:Start!9"
#   auto_minor_version_upgrade  = false
#   allow_major_version_upgrade = false
#   backup_window               = "02:00-02:30"
#   backup_retention_period     = 7
#   #Use anyone of below
#   # final_snapshot_identifier   = true # Set this to true to create a final snapshot
#   skip_final_snapshot = true # Set this to true to skip creating a final snapshot

#   tags = {
#     Name = "mysql"
#   }
# }

# Creating Aurora RDS Cluster, username and password used only for practice, otherwise follow DevOps best practices to keep it secret
resource "aws_rds_cluster" "mysql" {
  cluster_identifier      = "mysql"
  engine                  = "mysql" #[aurora, aurora-mysql, aurora-postgresql, mysql, postgres]
  engine_version          = "MySQL 8.0.35"
  master_username         = "root"
  master_password         = "Re:Start!9"
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  database_name           = "${var.prefix}-mysql-Cluster"
  port                    = 3306
  db_subnet_group_name    = aws_db_subnet_group.subnet_groups.id
  vpc_security_group_ids  = [aws_security_group.rds_security_group_id]
  storage_type = "gp3"


  tags = {
    Name = "${var.prefix}-RDS-Cluster"
  }
}

# # Creating RDS Cluster instance
# resource "aws_rds_cluster_instance" "primary_instance" {
#   cluster_identifier = aws_rds_cluster.mysql.id
#   identifier         = "primary-instance"
#   instance_class     = "db.r5.large"
#   engine             = aws_rds_cluster.mysql.engine
#   engine_version     = aws_rds_cluster.mysql.engine_version
# }

# # Creating RDS Read Replica Instance
# resource "aws_rds_cluster_instance" "read_replica_instance" {
#   count              = 1
#   cluster_identifier = aws_rds_cluster.mysql.id
#   identifier         = "read-replica-instance-${count.index}"
#   instance_class     = "db.r5.large"
#   engine             = aws_rds_cluster.mysql.engine
# }
