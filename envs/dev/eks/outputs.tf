output "cluster_name" {
  value = module.eks_cluster
}

output "cluster_endpoint" {
  value = module.eks_cluster.cluster_endpoint
}
output "cluster_security_group_id" {
  value = module.eks_cluster.cluster_security_group_id
}
output "cluster_oidc_issuer" {
  value = module.eks_cluster.cluster_oidc_issuer
}
output "cluster_role_arn" {
  value = module.cluster_role.role_arn
}

output "node_group_name" {
  value = module.node_groups["system"].node_group_name

}

output "node_group_name_2" {
  value = module.node_groups["workload"].node_group_name
  
}
output "node_role_arn" {
  value = module.node_role.role_arn
}