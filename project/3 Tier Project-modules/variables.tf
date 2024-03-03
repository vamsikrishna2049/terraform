variable "prefix" {}
variable "instance_tenancy" {}
variable "vpc_cidr_block" {}
variable "instance_type" {}
variable "environment" {}
variable "ami_id" {}
variable "templateVersion" {}
variable "az_a" {}
variable "az_b" {}
variable "web_sn_cidr" {}
variable "app_sn_cidr" {}
variable "backup_retention_period" {
  description = "Number of days to retain automatic backups"
  type        = number
  default     = 7
}
variable "backup_window" {
  description = "Backup window for the RDS instance"
  type        = string
  default     = "02:00-02:30"
}

variable "rds1_sn_cidr" {}
variable "rds2_sn_cidr" {}