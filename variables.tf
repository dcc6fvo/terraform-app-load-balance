variable "region" {
  description = "The AWS region"
  type        = string
  default     = "sa-east-1"
}

variable "azs" {
  description = "The region availability zones"
  type        = list(string)
  default = [
    "sa-east-1a",
    "sa-east-1c"
  ]
}

variable "vpc_cidr_block" {
  description = "CIDR block for our VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  description = "Available cidr blocks for public subnets"
  type        = list(string)
  default = [
    "192.168.1.0/24",
    "192.168.2.0/24",
  ]
}

variable "private_subnet_cidr_blocks" {
  description = "Available cidr blocks for private subnets"
  type        = list(string)
  default = [
    "192.168.101.0/24",
    "192.168.102.0/24",
  ]
}

variable "instances_per_subnet" {
  description = "Number of EC2 instances per private subnet"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "enable_dns_hostnames" {
  description = "enable dns hostnames"
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "enable nat gateway"
  type        = bool
  default     = true
}

variable "enable_vpn_gateway" {
  description = "enable_vpn_gateway"
  type        = bool
  default     = false
}
