# vpc output values
# vpc id
output "vpc_id" {
  description = "the id of the vpc"
  value = module.vpc.vpc_id
}

# vpc cidr blocks
output "vpc_cidr_block" {
  description = "the cidr block of the vpc"
  value = module.vpc.vpc_cidr_block
}

# vpc private subnets
output "private_subnets" {
  description = "list of ids of private subnets"
  value = module.vpc.private_subnets
}

# vpc public subnets
output "public_subnets" {
  description = "list of ids of public subnets"
  value = module.vpc.public_subnets
}

# vpc nat gateway public ip
output "nat_public_ips" {
  description = "list of public elastic ips created for aws nat gateway"
  value = module.vpc.nat_public_ips
}

# vpc azs
output "azs" {
  description = "a list of availability zones specified as argument to this module"
  value = module.vpc.azs
}