#################
# Terraform bucket
#################

terraform {
  backend "gcs" {
    bucket = "portfolio-terraform-bucket"
  }
}

#################
# Modules
#################

# Network module
module "network" {
  source = "./modules/network"
  region = var.region
}

# Storage module
module "storage" {
  source               = "./modules/storage"
  zone                 = var.zone
  region               = var.region
  portfolio_disk_size  = var.disk_size
  elk_disk_size        = var.elk_disk_size
}

# Firewall module
module "firewall" {
  source             = "./modules/firewall"
  network_id         = module.network.network_id
  allowed_ssh_port   = var.allowed_ssh_port
  allowed_ssh_cidr   = var.allowed_ssh_cidr
  blocked_http_cidr  = var.blocked_http_cidr
  allowed_http_cidr  = var.allowed_http_cidr
}

# Compute module
module "compute" {
  source                   = "./modules/compute"
  portfolio_vm_name        = var.app_vm_name
  elk_vm_name              = var.elk_vm_name
  vm_size                  = var.app_vm_size
  zone                     = var.zone
  network_id               = module.network.network_id
  portfolio_static_ip      = module.network.portfolio_static_ip
  elk_static_ip            = module.network.elk_static_ip
  portfolio_data_disk_id   = module.storage.portfolio_data_disk_id
  elk_data_disk_id         = module.storage.elk_data_disk_id
}

# Cloudflare module
module "cloudflare_rules" {
  source  = "./modules/cloudflare"
  zone_id = var.cloudflare_zone_id 
}