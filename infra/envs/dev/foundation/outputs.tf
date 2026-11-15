output "network_name" {
  value = module.network.network_name
}

output "gke_subnet_name" {
  value = module.network.gke_subnet_name
}
output "network_id" {
  value = module.network.network_id
}

output "repository_url" {
  value = module.registry.repository_url
}

output "gke_node_sa_email" {
  value = module.iam.gke_node_sa_email
}