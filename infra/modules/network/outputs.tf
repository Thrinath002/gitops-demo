output "network_id" {
  value = google_compute_network.vpc.id
}

output "network_name" {
  value = google_compute_network.vpc.name
}

output "gke_subnet_name" {
  value = google_compute_subnetwork.gke.name
}

output "ci_subnet_name" {
  value = google_compute_subnetwork.ci.name
}