output "vpc_id" {
  value = module.vpc.vpc_id  # Output the VPC ID from the module
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids  # Output the private subnet IDs
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids  # Output the public subnet IDs
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id  # Output the internet gateway ID
}

output "public_security_group_id" {
  value = module.vpc.public_security_group_id  # Output the public security group ID
}

output "private_security_group_id" {
  value = module.vpc.private_security_group_id  # Output the private security group ID
}
