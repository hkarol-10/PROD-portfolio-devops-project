variable "network_id" {
  description = "ID of the network to apply firewall rules to"
  type        = string
}

variable "allowed_ssh_port" {
  description = "Allowed port for SSH"
  type        = string
  sensitive   = true
}

variable "allowed_ssh_cidr" {
  description = "Allowed CIDR for SSH"
  type        = string
  sensitive   = true
}

variable "blocked_http_cidr" {
  description = "Blocked CIDR for HTTP"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allowed_http_cidr" {
  description = "Allowed CIDR for HTTP"
  type        = string
  default     = "0.0.0.0/0"
}
