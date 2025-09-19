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
    expression  = "(http.request.uri.path contains \"git\") or (http.request.uri.path contains \"wp-admin\") or (http.request.uri.path contains \"php\") or (http.request.uri contains \"x00\") or (http.request.uri contains \"CONNECT\") or (http.request.uri contains \"SSH\")"
    description = "Block common bot patterns"
    enabled     = true
  }
}