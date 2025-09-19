output "portfolio_data_disk_id" {
  description = "ID of the portfolio data disk"
  value       = google_compute_disk.portfolio_data_disk.id
}

output "elk_data_disk_id" {
  description = "ID of the ELK data disk"
  value       = google_compute_disk.elk_data_disk.id
}

output "portfolio_data_disk_snapshot_id" {
  description = "ID of the portfolio data disk snapshot"
  value       = google_compute_snapshot.portfolio_data_disk_snapshot.id
}
