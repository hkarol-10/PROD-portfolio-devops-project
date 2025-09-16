# Additional data disc
resource "google_compute_disk" "portfolio_data_disk" {
  name  = "portfolio-data-disk"
  type  = "pd-standard"
  zone  = var.zone
  size  = var.disk_size
}

resource "google_compute_disk" "elk_data_disk" {
  name  = "elk-data-disk"
  type  = "pd-standard"
  zone  = var.zone
  size  = var.elk_disk_size
}