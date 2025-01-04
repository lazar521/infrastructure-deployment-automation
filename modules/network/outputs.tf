
output "vpc_network_name" {
  description = "The name of the VPC network"
  value       = google_compute_network.vpc_network.name
}

output "id" {
  value = google_compute_network.vpc_network.id
}


output "self_link" {
  value = google_compute_network.vpc_network.self_link
}

