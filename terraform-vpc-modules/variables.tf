variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "name" {
  description = "The name of the VPC."
  type        = string
}

variable "private_subnet_count" {
  description = "Number of private subnets."
  type        = number
}

variable "public_subnet_count" {
  description = "Number of public subnets."
  type        = number
}

variable "public_ingress_rules" {
  description = "List of ingress rules for the public security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "private_ingress_rules" {
  description = "List of ingress rules for the private security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
    }
  ]
}

