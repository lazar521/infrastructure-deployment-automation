output "load_balancer_ip" {
  description = "The external IP address of the load balancer"
  value       = google_compute_global_forwarding_rule.default.ip_address
}
