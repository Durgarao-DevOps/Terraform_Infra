output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = values(module.aws_vpc.public_subnets)
}

output "private_app_subnet_ids" {
  description = "Private app subnet IDs"
  value       = values(module.aws_vpc.private_app_subnets)
}

output "private_database_subnet_ids" {
  description = "Private database subnet IDs"
  value       = values(module.aws_vpc.private_database_subnets)
}