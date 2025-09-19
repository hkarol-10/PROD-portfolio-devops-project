output "portfolio_vm_public_ip" {
  description = "Public IP of the portfolio VM"
  value       = google_compute_instance.portfolio_vm.network_interface[0].access_config[0].nat_ip
  sensitive   = true
}

output "elk_vm_public_ip" {
  description = "Public IP of the ELK VM"
  value       = google_compute_instance.elk_vm.network_interface[0].access_config[0].nat_ip
  sensitive   = true
}

output "portfolio_vm_id" {
  description = "ID of the portfolio VM"
  value       = google_compute_instance.portfolio_vm.id
}

output "elk_vm_id" {
  description = "ID of the ELK VM"
  value       = google_compute_instance.elk_vm.id
}
