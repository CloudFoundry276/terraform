# vpc input variables
# vpc name
variable "vpc_name" {
  description = "vpc name"
  type = string
  default = "vpc-lab-06-02"
}

# vpc cidr block
variable "vpc_cidr_block" {
  description = "vpc cidr block"
  type = string
  default = "10.0.0.0/16"
}

# vpc availability zones
variable "vpc_availability_zones" {
  description = "vpc availability zones"
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

# vpc public subnets
variable "vpc_public_subnets" {
  description = "vpc public subnets"
  type = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

# vpc private subnets
variable "vpc_private_subnets" {
  description = "vpc private subnets"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

# vpc database subnets
variable "vpc_database_subnets" {
  description = "vpc database subnets"
  type = list(string)
  default = ["10.0.151.0/24", "10.0.152.0/24"]
}

# vpc create database subnet group (true / false)
variable "vpc_create_database_subnet_group" {
  description = "vpc create database subnet group"
  type = bool
  default = true
}

# vpc create database subnet route table (true / false)
variable "vpc_create_database_subnet_route_table" {
  description = "vpc create database subnet route table"
  type = bool
  default = true
}

# vpc enable nat gateway (true / false)
variable "vpc_enable_nat_gateway" {
  description = "enable nat gateways for private subnets outbound communication"
  type = bool
  default = true
}

# vpc single nat gateway (true / false)
variable "vpc_single_nat_gateway" {
  description = "enable only single nat gateway in one availability zone to save costs during our demos"
  type = bool
  default = true
}