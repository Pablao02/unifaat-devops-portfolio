terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "TechNova"
      Environment = "development"
      ManagedBy   = "Terraform"
      Owner       = var.owner
    }
  }
}

# VPC
resource "aws_vpc" "technova" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "technova-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "technova" {
  vpc_id = aws_vpc.technova.id

  tags = {
    Name = "technova-igw"
  }
}

# Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Subnet pública - AZ 1
resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.technova.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "technova-public-subnet-az1"
    Tier = "Public"
  }
}

# Subnet privada - AZ 1
resource "aws_subnet" "private_az1" {
  vpc_id                  = aws_vpc.technova.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "technova-private-subnet-az1"
    Tier = "Private"
  }
}

# Subnet pública - AZ 2
resource "aws_subnet" "public_az2" {
  vpc_id                  = aws_vpc.technova.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "technova-public-subnet-az2"
    Tier = "Public"
  }
}

# Subnet privada - AZ 2
resource "aws_subnet" "private_az2" {
  vpc_id                  = aws_vpc.technova.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "technova-private-subnet-az2"
    Tier = "Private"
  }
}

# Route Table pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.technova.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.technova.id
  }

  tags = {
    Name = "technova-public-route-table"
  }
}

# Associação da subnet pública AZ1
resource "aws_route_table_association" "public_az1" {
  subnet_id      = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public.id
}

# Associação da subnet pública AZ2
resource "aws_route_table_association" "public_az2" {
  subnet_id      = aws_subnet.public_az2.id
  route_table_id = aws_route_table.public.id
}

# Route Table privada
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.technova.id

  tags = {
    Name = "technova-private-route-table"
  }
}

# Associação da subnet privada AZ1
resource "aws_route_table_association" "private_az1" {
  subnet_id      = aws_subnet.private_az1.id
  route_table_id = aws_route_table.private.id
}

# Associação da subnet privada AZ2
resource "aws_route_table_association" "private_az2" {
  subnet_id      = aws_subnet.private_az2.id
  route_table_id = aws_route_table.private.id
}