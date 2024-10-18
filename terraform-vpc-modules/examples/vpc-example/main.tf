provider "aws" {
  region = "us-west-2"  # Specify your desired AWS region
}

module "vpc" {
  source                = "../../"  # Path to the VPC module
  cidr_block            = var.cidr_block  # Use the variable defined in variables.tf
  name                  = var.name        # Use the variable defined in variables.tf
  private_subnet_count  = var.private_subnet_count  # Use the variable defined in variables.tf
  public_subnet_count   = var.public_subnet_count   # Use the variable defined in variables.tf
}
