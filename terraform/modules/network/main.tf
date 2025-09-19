# ===============================
# Network + Static IP
# ===============================

# Network
resource "google_compute_network" "portfolio_network" {
  name                    = "portfolio-network"
  auto_create_subnetworks = true
}

# Static IP for Portfolio VM
resource "google_compute_address" "portfolio_static_ip" {
  name   = "portfolio-static-ip"
  region = var.region
}

# Static IP for ELK VM
resource "google_compute_address" "elk_static_ip" {
  name   = "elk-static-ip"
  region = var.region
}
