CIDR Subnet Function
  calculates a subnet address within given IP network address prefix

syntax:
  cidrsubnet(prefix, newbits, netnum) cidrsubnet(base_cidr, new_prefix_length, index)

Ex:
  cidrsubnet("172.16.0.0/12", 4, 2)
  172.18.0.0/16
 
  cidrsubnet("10.1.2.0/24", 4, 15)
  10.1.2.240/28

  cidrsubnet("fd00:fd12:3456:7890::/56", 16, 162)
  fd00:fd12:3456:7800:a200::/72

  

Reference:
https://developer.hashicorp.com/terraform/language/functions/cidrsubnet