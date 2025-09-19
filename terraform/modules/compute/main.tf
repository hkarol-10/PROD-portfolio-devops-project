# ===============================
# Compute Instances
# ===============================

resource "google_compute_instance" "portfolio_vm" {
  name         = var.portfolio_vm_name
  machine_type = var.vm_size
  zone         = var.zone
  
  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  attached_disk {
    source = var.portfolio_data_disk_id
    mode   = "READ_WRITE"
  }

  network_interface {
    network = var.network_id
    access_config {
      nat_ip = var.portfolio_static_ip
    }
  }

  tags = ["portfolio-vm"]

  lifecycle {
    ignore_changes = [
      metadata["ssh-keys"]
    ]
  }
}

resource "google_compute_instance" "elk_vm" {
  name         = var.elk_vm_name
  machine_type = var.vm_size
  zone         = var.zone
  
  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  attached_disk {
    source = var.elk_data_disk_id
    mode   = "READ_WRITE"
  }

  network_interface {
    network = var.network_id
    access_config {
      nat_ip = var.elk_static_ip
    }
  }

  tags = ["elk-vm"]

  lifecycle {
    ignore_changes = [
      metadata["ssh-keys"]
    ]
  }
}
