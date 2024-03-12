variable "vpc_cidr_block" {
  description = "CIDR block for the VPC where the resources will be deployed"
  type        = string
}

variable "instance_tenancy" {
  description = "The tenancy of the instance (default, dedicated, or host)"
  type        = string
}

variable "prefix" {
  description = "Prefix to be used for naming resources"
  type        = string
}

variable "az_a" {
  description = "Availability Zone A for deployment"
  type        = string
}

variable "az_b" {
  description = "Availability Zone B for deployment"
  type        = string
}

variable "pub" {
  description = "Public subnet ID for deployment"
  type        = string
}

variable "pvt1" {
  description = "Private subnet 1 ID for deployment"
  type        = string
}

variable "pvt2" {
  description = "Private subnet 2 ID for deployment"
  type        = string
}

variable "pvt3" {
  description = "Private subnet 3 ID for deployment"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "engineType" {
  description = "Type of database engine (e.g., mysql, postgres)"
  type        = string
}

variable "engineVersion" {
  description = "Version of the database engine"
  type        = string
}

variable "dbInstType" {
  description = "Instance type for the RDS database"
  type        = string
}

variable "username" {
  description = "Username for database access"
  type        = string
}

variable "password" {
  description = "Password for database access"
  type        = string
}

variable "minorVersionUpgrade" {
  description = "Flag indicating whether to allow minor version upgrades for the RDS instance"
  type        = bool
}

variable "majorVersionUpgrade" {
  description = "Flag indicating whether to allow major version upgrades for the RDS instance"
  type        = bool
}

variable "backup_retention_period" {
  description = "Number of days to retain automatic backups"
  type        = number
  default     = 7 #If no value mentioned then it will assigned defaultly
}

variable "backup_window" {
  description = "Backup window for the RDS instance"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Flag indicating whether to skip creating a final snapshot when deleting the RDS instance"
  type        = bool
}
