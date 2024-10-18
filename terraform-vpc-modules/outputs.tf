output "vpc_id" {
  value = aws_vpc.this.id  # Output the VPC ID
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id  # Output the private subnet IDs
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id  # Output the public subnet IDs
}

output "internet_gateway_id" {
  value = aws_internet_gateway.this.id  # Output the internet gateway ID
}

output "public_security_group_id" {
  value = aws_security_group.public_sg.id  # Output the public security group ID
}

output "private_security_group_id" {
  value = aws_security_group.private_sg.id  # Output the private security group ID
}
