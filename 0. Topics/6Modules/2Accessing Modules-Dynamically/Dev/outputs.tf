output "aws_s3_bucket" {
  value = aws_s3_bucket.s3bucket.id
}

output "dev_infra1_vpc_id" {
  value = module.dev_infra1.VPCID
}

output "dev_infra2_vpc_id" {
  value = module.dev_infra2.VPCID
}

output "dev_infra1_igw_id" {
  value = module.dev_infra1.internet_gateway_id
}

output "dev_infra2_igw_id" {
  value = module.dev_infra2.internet_gateway_id
}