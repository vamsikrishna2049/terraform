output "rds_instance_id" {
  value = aws_db_instance.primary.endpoint
}
