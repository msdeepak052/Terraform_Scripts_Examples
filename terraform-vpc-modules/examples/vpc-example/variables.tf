variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "name" {
  description = "Name of the VPC"
  type        = string
}

variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
}
