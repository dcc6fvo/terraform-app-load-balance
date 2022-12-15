provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"

  name = "main-vpc"
  cidr = var.vpc_cidr_block

  enable_dns_hostnames = var.enable_dns_hostnames

  azs             = var.azs
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets  = var.public_subnet_cidr_blocks

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
}

resource "aws_key_pair" "Key-Pair" {
  key_name   = "aws-terraform-multi-env-dev"
  public_key = file("./aws-terraform-multi-env-dev.pub")
}

module "ec2_instances" {
  source = "./modules/aws-instance"

  instance_count     = var.instances_per_subnet * length(module.vpc.private_subnets)
  instance_type      = var.instance_type
  subnet_ids         = module.vpc.private_subnets[*]
  security_group_ids = [module.app_security_group.this_security_group_id,
  aws_security_group.acesso_ssh_icmp_privado.id]
}

/*
resource "aws_internet_gateway" "Internet_Gateway" {
  depends_on = [
    module.vpc,
    module.ec2_instances
  ]

  vpc_id = module.vpc.id

  tags = {
    Name = "IG-Public-&-Private-VPC"
  }
}

resource "aws_route_table" "Public-Subnet-RT" {
  depends_on = [
    module.vpc,
    aws_internet_gateway.Internet_Gateway
  ]

  vpc_id = module.vpc.id

  # NAT Rule
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Internet_Gateway.id
  }

  tags = {
    Name = "Route Table for Internet Gateway"
  }
}

resource "aws_route_table_association" "RT-IG-Association" {

  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
    aws_subnet.subnet2,
    aws_route_table.Public-Subnet-RT
  ]

  #Public Subnet ID
  subnet_id      = aws_subnet.subnet1.id

  #Route Table ID
  route_table_id = aws_route_table.Public-Subnet-RT.id
}*/