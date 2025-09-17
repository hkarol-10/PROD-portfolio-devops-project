#################
# Terraform bucket
#################

terraform {
  backend "gcs" {
    bucket = "portfolio-terraform-bucket"
  }
}

#################
# Resources
#################

resource "google_compute_instance" "portfolio_vm" {
  name         = var.app_vm_name
  machine_type = var.app_vm_size
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
    source = google_compute_disk.portfolio_data_disk.id
    mode   = "READ_WRITE"
  }

  network_interface {
    network = google_compute_network.portfolio_network.id
    access_config {
      nat_ip = google_compute_address.portfolio_static_ip.address
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
  machine_type = var.app_vm_size
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
    source = google_compute_disk.elk_data_disk.id
    mode   = "READ_WRITE"
  }

  network_interface {
    network = google_compute_network.portfolio_network.id
    access_config {
      nat_ip = google_compute_address.elk_static_ip.address
    }
  }

  tags = ["elk-vm"]

  lifecycle {
    ignore_changes = [
      metadata["ssh-keys"]
    ]
  }
}
