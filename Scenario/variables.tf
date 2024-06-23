#VPC Name
variable "vpc_name" {
  description = "Mention the VPC Name"
  type        = string
}

#VPC CIDR Block Range
variable "vpc_cidr_block" {
  description = "CIDR Range for VPC"
  type        = string
}

#Number of Public Subnets are going to create
variable "pub_subnet_count" {
  description = "Total Number of Public Subnets"
  type        = number
}

#Public Subnet CIDR Range
variable "pub_subnet_cidr_block" {
  description = "Public Subnet CIDR Range"
  type        = list(string)
}

#Availability Zone
variable "azs" {
  description = "List the Availability Zones"
  type        = list(string)
}

#Dynamic Inbound Security Group Rules
variable "security_group_rules" {
  type = map(object({
    from_port = number
    to_port   = number
    protocol  = string
    cidr      = list(string)
  }))
  default = {
    web_server_rule = {
      description = "HTTP Access"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr        = ["0.0.0.0/0"]
    }
    ssh_access_rule = {
      description = "SSH Access"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr        = ["0.0.0.0/0"]
    }
    custom_app_rule = {
      description = "HTTPS Access"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr        = ["0.0.0.0/0"]
    }
  }
}


#Instance Count
variable "instance_count"{
    description = "Number of EC2 instances to create"
    type = number
    default = 1
}

#Instance Type
variable "instance_type"{
    description = "Number of EC2 instances to create"
    type = string
    default = "t2.micro"
}

#AMI ID
variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type = string
  default = "ami-08a0d1e16fc3f61ea"
}

#Key Pair Name - Management Console
variable "key_name" {
  description = "SSH key name for EC2 instances"
  type = string
  default = "Test-KeyPair"
}
