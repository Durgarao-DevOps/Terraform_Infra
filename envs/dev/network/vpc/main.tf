module "aws_vpc" {
  source   = "../../../../modules/network/vpc"
  name     = var.name
  vpc_cidr = var.vpc_cidr
  public_subnets = var.public_subnets
  private_app_subnets     = var.private_app_subnets
  private_database_subnets = var.private_database_subnets
  tags = var.tags
   additional_private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}