# ===============================
# Firewall Rules
# ===============================

# -------------------------------
# Allow SSH port + my IP
# -------------------------------
resource "google_compute_firewall" "ssh_fw" {
  name        = "portfolio-fw-ssh"
  network     = var.network_id
  priority    = 100
  target_tags = ["portfolio-vm", "elk-vm"]

  allow {
    protocol = "tcp"
    ports    = [var.allowed_ssh_port]
  }

  source_ranges = [var.allowed_ssh_cidr]
}

# -------------------------------
# Deny all HTTP
# -------------------------------
resource "google_compute_firewall" "http_fw" {
  name        = "portfolio-fw-http"
  network     = var.network_id
  priority    = 200
  target_tags = ["portfolio-vm", "elk-vm"]

  deny {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = [var.blocked_http_cidr]
}

# -------------------------------
# Allow HTTP - my IP
# -------------------------------
resource "google_compute_firewall" "http_fw_whitelist" {
  name        = "portfolio-fw-http-allow-my-ip"
  network     = var.network_id
  priority    = 199
  target_tags = ["portfolio-vm", "elk-vm"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = [var.allowed_ssh_cidr]
}

# -------------------------------
# Allow HTTPS ONLY from Cloudflare
# -------------------------------
data "http" "cloudflare_ipv4" {
  url = "https://www.cloudflare.com/ips-v4"
}

data "http" "cloudflare_ipv6" {
  url = "https://www.cloudflare.com/ips-v6"
}

locals {
  cloudflare_ipv4_list = split("\n", trimspace(data.http.cloudflare_ipv4.response_body))
  cloudflare_ipv6_list = split("\n", trimspace(data.http.cloudflare_ipv6.response_body))
}

resource "google_compute_firewall" "https_fw_cloudflare_ipv4" {
  name        = "portfolio-fw-https-cloudflare-ipv4"
  network     = var.network_id
  priority    = 200
  target_tags = ["portfolio-vm", "elk-vm"]

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = local.cloudflare_ipv4_list
}

resource "google_compute_firewall" "https_fw_cloudflare_ipv6" {
  name        = "portfolio-fw-https-cloudflare-ipv6"
  network     = var.network_id
  priority    = 200
  target_tags = ["portfolio-vm", "elk-vm"]

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = local.cloudflare_ipv6_list
}

# -------------------------------
# GitHub Actions IP ranges (IPv4 only) - allow SSH
# -------------------------------
data "http" "github_actions_ips" {
  url = "https://api.github.com/meta"
}

locals {
  github_actions_cidrs_raw  = try([for cidr in jsondecode(data.http.github_actions_ips.response_body).actions : cidr], [])
  github_actions_cidrs_ipv4 = [for cidr in local.github_actions_cidrs_raw : cidr if can(regex("^\\d+\\.\\d+\\.\\d+\\.\\d+/\\d+$", cidr))]
  github_actions_chunks     = chunklist(local.github_actions_cidrs_ipv4, 5000)
}

resource "google_compute_firewall" "ssh_fw_ci" {
  for_each   = { for idx, cidrs in local.github_actions_chunks : idx => cidrs }
  name       = "portfolio-fw-ssh-ci-${each.key}"
  network    = var.network_id
  priority   = 110
  target_tags = ["portfolio-vm", "elk-vm"]

  allow {
    protocol = "tcp"
    ports    = [var.allowed_ssh_port]
  }

  source_ranges = each.value
}

# -------------------------------
# Allow beats -> logstash (5044) in private network
# -------------------------------
resource "google_compute_firewall" "logstash_beats_fw" {
  name        = "portfolio-fw-logstash-5044"
  network     = var.network_id
  priority    = 150
  target_tags = ["elk-vm"]

  allow {
    protocol = "tcp"
    ports    = ["5044"]
  }

  source_ranges = ["10.186.0.0/20"]
}

# -------------------------------
# Allow metricbeat -> logstash (9200) in private network
# -------------------------------
resource "google_compute_firewall" "logstash_metricbeat_fw" {
  name        = "portfolio-fw-logstash-9200"
  network     = var.network_id
  priority    = 150
  target_tags = ["elk-vm"]

  allow {
    protocol = "tcp"
    ports    = ["9200"]
  }

  source_ranges = ["10.186.0.0/20"]
}
