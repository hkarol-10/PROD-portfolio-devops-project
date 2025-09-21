terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

resource "cloudflare_ruleset" "bot_block_ruleset" {
  zone_id     = var.zone_id
  name        = "Block bots url terraform"
  description = "Custom ruleset to block bots and scanners - terraform managed"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules {
    action      = "block"
    expression  = <<EOT
http.request.uri.path contains "git" or
http.request.uri.path contains "wp-admin" or
http.request.full_uri contains "robots.txt" or
http.request.full_uri contains "sitemap.xml" or
http.request.full_uri contains "XDEBUG_SESSION_START" or
http.request.uri contains "php" or
http.request.uri contains "x00" or
http.request.uri contains "CONNECT" or
http.request.uri contains "SSH" or
http.request.method eq "PROPFIND" or
http.request.method eq "OPTIONS" or
http.request.method eq "TRACE" or
http.request.method eq "POST" or
http.request.method eq "PUT" or
http.request.method eq "DELETE" or
http.request.method eq "PATCH" or
ip.src.continent eq "T1" or not
ssl
EOT
    description = "Block common bot patterns"
    enabled     = true
  }
}