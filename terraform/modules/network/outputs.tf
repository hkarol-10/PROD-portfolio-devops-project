output "network_id" {
  description = "ID of the created network"
  value       = google_compute_network.portfolio_network.id
}

output "network_name" {
  description = "Name of the created network"
  value       = google_compute_network.portfolio_network.name
}

output "portfolio_static_ip" {
  description = "Static IP address for portfolio VM"
  value       = google_compute_address.portfolio_static_ip.address
}

output "elk_static_ip" {
  description = "Static IP address for ELK VM"
  value       = google_compute_address.elk_static_ip.address
}
