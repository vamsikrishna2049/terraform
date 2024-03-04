variable "module_name" {
  description = "What type of module"
  type        = string
  default     = "unknown"
}

######################## vpc ########################
variable "vpc_cidr_block" {
  description = "VPC CIDR Range"
  type        = string
}

variable "instance_tenancy" {
  description = "instance_tenancy Type"
  type        = string
  default     = "default"
}


######################## Public Subnets ########################
variable "pub_azs" {
  description = "Availability Zones"
  type        = list(string)
}

# variable "pub_subnet_cidr_block" {
#   description = "Public Subnet CIDR Block Range"
#   type        = list(string)
# }

variable "pub_subnet_count" {
  description = "Total Number of public subnets required"
  type        = number
}

######################## Private Subnets ########################
variable "pvt_azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "pvt_subnet_cidr_block" {
  description = "Public Subnet CIDR Block Range"
  type        = list(string)
}

variable "pvt_subnet_count" {
  description = "Total Number of public subnets required"
  type        = number
}