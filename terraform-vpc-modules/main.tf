provider "aws" {
  region = "ap-south-1"  # Specify your desired AWS region
}

resource "aws_vpc" "this" {
  cidr_block              = var.cidr_block
  enable_dns_support      = true   # Enable DNS resolution
  enable_dns_hostnames    = true   # Enable DNS hostnames
  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "private" {
  count = var.private_subnet_count
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(var.cidr_block, var.bit, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "${var.name}-private-${count.index}"
  }
}

resource "aws_subnet" "public" {
  count = var.public_subnet_count
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(var.cidr_block, var.bit, count.index + var.private_subnet_count)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true  # Assign a public IP to instances launched in this subnet

  tags = {
    Name = "${var.name}-public-${count.index}"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.name}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.name}-public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  count = var.public_subnet_count
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.this.id
  name   = "${var.name}-public-sg"
  tags = {
    Name = "${var.name}-public-sg"
  }

  dynamic "ingress" {
    for_each = var.public_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.this.id
  name   = "${var.name}-private-sg"
  tags = {
    Name = "${var.name}-private-sg"
  }

  dynamic "ingress" {
    for_each = var.private_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_availability_zones" "available" {}
