output "app_vm_public_ip" {
  description = "Public IP of the VM"
  value       = google_compute_instance.portfolio_vm.network_interface[0].access_config[0].nat_ip
  sensitive   = true
}

output "app_data_disk_id" {
  description = "ID of the attached data disk"
  value       = google_compute_disk.portfolio_data_disk.id
}

output "app_data_disk_snapshot" {
  description = "Snapshot ID of the data disk"
  value       = google_compute_snapshot.portfolio_data_disk_snapshot.id
}