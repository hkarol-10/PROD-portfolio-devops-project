variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "zone" {
  description = "GCP Zone"
  type        = string
}

variable "app_vm_name" {
  description = "Name of the VM instance"
  type        = string
}

variable "elk_vm_name" {
  description = "Name of the elk VM instance"
  type        = string
}

variable "disk_size" {
  description = "Size of the additional disk in GB"
  type        = number
  default     = 10
}

variable "elk_disk_size" {
  description = "Size of the additional disk in GB"
  type        = number
  default     = 64
}

variable "app_vm_size" {
  description = "Size of application vm"
  type        = string
  default     = "e2-medium" # 2 vCPU / 4 GB RAM
}

variable "allowed_http_cidr" {
  description = "Allowed CIDR for HTTP"
  type        = string
  default     = "0.0.0.0/0"
}

variable "blocked_http_cidr" {
  description = "Blocked CIDR for HTTP"
  type        = string
  default     = "0.0.0.0/0"
}

# ======================= #
# TF_VARs local variables #
# ========================#

# ssh connection
variable "allowed_ssh_cidr" {
  description = "Allowed CIDR for SSH"
  type        = string
  sensitive   = true
}

variable "allowed_ssh_port" {
  description = "Allowed port for SSH"
  type        = string
  sensitive   = true
}