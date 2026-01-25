output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets" {
  value = { for k, v in aws_subnet.public : k => v.id }
}

output "private_app_subnets" {
  value = { for k, v in aws_subnet.private : k => v.id }
}

output "private_database_subnets" {
  value = { for k, v in aws_subnet.private_database : k => v.id }
}