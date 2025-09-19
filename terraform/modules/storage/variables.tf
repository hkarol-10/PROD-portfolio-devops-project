variable "zone" {
  description = "GCP Zone"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "portfolio_disk_size" {
  description = "Size of the portfolio disk in GB"
  type        = number
  default     = 10
}

variable "elk_disk_size" {
  description = "Size of the ELK disk in GB"
  type        = number
  default     = 64
}
