variable "portfolio_vm_name" {
  description = "Name of the portfolio VM instance"
  type        = string
}

variable "elk_vm_name" {
  description = "Name of the ELK VM instance"
  type        = string
}

variable "vm_size" {
  description = "Size of the VM instances"
  type        = string
  default     = "e2-medium"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
}

variable "network_id" {
  description = "ID of the network"
  type        = string
}

variable "portfolio_static_ip" {
  description = "Static IP address for portfolio VM"
  type        = string
}

variable "elk_static_ip" {
  description = "Static IP address for ELK VM"
  type        = string
}

variable "portfolio_data_disk_id" {
  description = "ID of the portfolio data disk"
  type        = string
}

variable "elk_data_disk_id" {
  description = "ID of the ELK data disk"
  type        = string
}
