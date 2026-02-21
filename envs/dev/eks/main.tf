module "cluster_role" {
  source       = "../../../modules/eks/iam/cluster-role"
  cluster_name = var.cluster_name
  tags         = var.tags
}

module "node_role" {
  source       = "../../../modules/eks/iam/node-role"
  cluster_name = var.cluster_name
  tags         = var.tags
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket         = "my-terraform-states-418"
    key            = "dev/network/vpc/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
  }
}

module "eks_cluster" {
  source = "../../../modules/eks/cluster"

  cluster_name      = var.cluster_name
  cluster_role_arn  = module.cluster_role.role_arn
  subnet_ids        = data.terraform_remote_state.vpc.outputs.private_app_subnet_ids
  kubernetes_version = "1.29"

  tags = var.tags
}


module "node_groups" {
  source = "../../../modules/eks/node-groups"

  for_each = var.node_groups

  cluster_name  = module.eks_cluster.cluster_name
  node_role_arn = module.node_role.role_arn
  subnet_ids    = data.terraform_remote_state.vpc.outputs.private_app_subnet_ids

  node_group_name = each.key
  instance_types  = each.value.instance_types

  min_size     = each.value.min_size
  max_size     = each.value.max_size
  desired_size = each.value.desired_size

  capacity_type = lookup(each.value, "capacity_type", "ON_DEMAND")
  labels        = lookup(each.value, "labels", {})
  taints        = lookup(each.value, "taints", [])

  tags = var.tags
}
