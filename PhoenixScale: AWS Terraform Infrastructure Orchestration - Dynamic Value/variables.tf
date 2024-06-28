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
