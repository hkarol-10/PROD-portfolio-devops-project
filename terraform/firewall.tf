# ===============================
# Firewall
# ===============================


# ===============================
# Allow ssh port + my IP
# ===============================
resource "google_compute_firewall" "ssh_fw" {
  name    = "portfolio-fw-ssh"
  network = google_compute_network.portfolio_network.id

  allow {
    protocol = "tcp"
    ports    = [var.allowed_ssh_port]
  }

  source_ranges = [var.allowed_ssh_cidr]
  target_tags = ["portfolio-vm","elk-vm"]
  priority      = 100
}


# ===============================
# Deny all http
# ===============================
resource "google_compute_firewall" "http_fw" {
  name    = "portfolio-fw-http"
  network = google_compute_network.portfolio_network.id

  deny {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = [var.blocked_http_cidr]
  target_tags = ["portfolio-vm","elk-vm"]
  priority      = 200
}

# ===============================
# Allow http - my IP
# ===============================
resource "google_compute_firewall" "http_fw_whitelist" {
  name    = "portfolio-fw-http-allow-my-ip"
  network = google_compute_network.portfolio_network.id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = [var.allowed_ssh_cidr]
  target_tags = ["portfolio-vm","elk-vm"]
  priority      = 199
}


# ===============================
# Allow all https
# ===============================
resource "google_compute_firewall" "https_fw" {
  name    = "portfolio-fw-https"
  network = google_compute_network.portfolio_network.id

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = [var.allowed_http_cidr]
  target_tags = ["portfolio-vm","elk-vm"]
  priority      = 200
}

# ===============================
# GitHub Actions IP ranges (IPv4 only)
# ===============================

data "http" "github_actions_ips" {
  url = "https://api.github.com/meta"
}

locals {
  github_actions_cidrs_raw  = try([for cidr in jsondecode(data.http.github_actions_ips.response_body).actions : cidr], [])

  # only IPv4
  github_actions_cidrs_ipv4 = [
    for cidr in local.github_actions_cidrs_raw :
    cidr if can(regex("^\\d+\\.\\d+\\.\\d+\\.\\d+/\\d+$", cidr))
  ]

  # chunks max 5000 elements
  github_actions_chunks = chunklist(local.github_actions_cidrs_ipv4, 5000)
}

resource "google_compute_firewall" "ssh_fw_ci" {
  for_each = { for idx, cidrs in local.github_actions_chunks : idx => cidrs }

  name    = "portfolio-fw-ssh-ci-${each.key}"
  network = google_compute_network.portfolio_network.id

  allow {
    protocol = "tcp"
    ports    = [var.allowed_ssh_port]
  }

  source_ranges = each.value
  target_tags = ["portfolio-vm","elk-vm"]
  priority      = 110
}

# ===============================
# Allow beats -> logstash (5044) in private network
# ===============================
resource "google_compute_firewall" "logstash_beats_fw" {
  name    = "portfolio-fw-logstash-5044"
  network = google_compute_network.portfolio_network.id

  allow {
    protocol = "tcp"
    ports    = ["5044"]
  }
  source_ranges = ["10.186.0.0/20"]

  # only ELK is listening
  target_tags = ["elk-vm"]

  priority = 150
}

# ===============================
# Allow metricbeat -> logstash (9200) in private network
# ===============================
resource "google_compute_firewall" "logstash_metricbeat_fw" {
  name    = "portfolio-fw-logstash-9200"
  network = google_compute_network.portfolio_network.id

  allow {
    protocol = "tcp"
    ports    = ["9200"]
  }
  source_ranges = ["10.186.0.0/20"]

  # only ELK is listening
  target_tags = ["elk-vm"]

  priority = 150
}