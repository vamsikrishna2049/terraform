# Creating DB Subnet Group for RDS
resource "aws_db_subnet_group" "subnet_groups" {
  subnet_ids = [var.pub_sn_1, var.pub_sn_2, var.pub_sn_3]
  name       = "${var.prefix}-db_subnet_group"
  tags = {
    Name = "${var.prefix}-db-subnet-group"
  }
}

# Security group for RDS - allowing port 3306(mysql)
resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id
  name   = "${var.prefix}-sg-name" # update this name with rds sg
  # description = "Created by TerraForm"

  ingress {
    description     = "Allow port MYSQL"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.security_group_id]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-${var.prefix}-sg"
  }
}


# It will create Single RDS - MySQL is created. 
resource "aws_db_instance" "primary" {
  allocated_storage           = 30
  vpc_security_group_ids      = [aws_security_group.sg.id]
  db_subnet_group_name        = aws_db_subnet_group.subnet_groups.id
  db_name                     = "${var.prefix}main"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = "db.t3.micro"
  username                    = "root"
  password                    = "Re:Start!9"
  auto_minor_version_upgrade  = false
  allow_major_version_upgrade = false
  backup_window               = "02:00-02:30"
  backup_retention_period     = 7
  #Use anyone of below
  # final_snapshot_identifier   = true # Set this to true to create a final snapshot
  skip_final_snapshot = true # Set this to true to skip creating a final snapshot

  tags = {
    Name = "mysql"
  }
}

# # Creating Aurora RDS Cluster, username and password used only for practice, otherwise follow DevOps best practices to keep it secret
# resource "aws_rds_cluster" "mysql" {
#   cluster_identifier      = "mysql"
#   engine                  = "mysql" #[aurora, aurora-mysql, aurora-postgresql, mysql, postgres]
#   engine_version          = "MySQL 8.0.35"
#   master_username         = "root"
#   master_password         = "Re:Start!9"
#   backup_retention_period = 7
#   preferred_backup_window = "07:00-09:00"
#   skip_final_snapshot     = true
#   database_name           = "${var.prefix}-mysql-Cluster"
#   port                    = 3306
#   db_subnet_group_name    = aws_db_subnet_group.subnet_groups.id
#   vpc_security_group_ids  = [aws_security_group.sg.id]
#   storage_type = "gp3"


#   tags = {
#     Name = "${var.prefix}-RDS-Cluster"
#   }
# }

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
