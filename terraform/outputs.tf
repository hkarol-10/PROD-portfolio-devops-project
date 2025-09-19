output "app_vm_public_ip" {
  description = "Public IP of the VM"
  value       = module.compute.portfolio_vm_public_ip
  sensitive   = true
}

output "app_data_disk_id" {
  description = "ID of the attached data disk"
  value       = module.storage.portfolio_data_disk_id
}

output "app_data_disk_snapshot" {
  description = "Snapshot ID of the data disk"
  value       = module.storage.portfolio_data_disk_snapshot_id
}