variable "prefix" {}
variable "instance_tenancy" {}
variable "vpc_cidr_block" {}
variable "az_a" {}
variable "az_b" {}
variable "pub_sn" {}
variable "pvt_sn1" {}
variable "pvt_sn2" {}
variable "pvt_sn3" {}

variable "instance_type" {}
variable "ami_id" {}
variable "templateVersion" {}

variable "environment" {}

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
