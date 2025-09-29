# Additional data disks
resource "google_compute_disk" "portfolio_data_disk" {
  name  = "portfolio-data-disk"
  type  = "pd-standard"
  zone  = var.zone
  size  = var.portfolio_disk_size
}

resource "google_compute_disk" "elk_data_disk" {
  name  = "elk-data-disk"
  type  = "pd-standard"
  zone  = var.zone
  size  = var.elk_disk_size
}

# Data disc snapshot
resource "google_compute_snapshot" "portfolio_data_disk_snapshot" {
  name        = "portfolio-data-disk-snapshot-v2"
  source_disk = google_compute_disk.portfolio_data_disk.id
  zone        = var.zone

  lifecycle {
    prevent_destroy = false
  }
}

# 7 days retention policy, everyday at 4:00
resource "google_compute_resource_policy" "daily_snapshot_policy" {
  name   = "daily-snapshot-policy"
  region = var.region

  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "04:00"
      }
    }

    retention_policy {
      max_retention_days     = 7
      on_source_disk_delete  = "APPLY_RETENTION_POLICY"
    }

    snapshot_properties {
      storage_locations = ["europe-central2"]
    }
  }
}

resource "google_compute_disk_resource_policy_attachment" "portfolio_data_disk_snapshot_policy" {
  name = google_compute_resource_policy.daily_snapshot_policy.name
  disk = google_compute_disk.portfolio_data_disk.name
  zone = var.zone
}
