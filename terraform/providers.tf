terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.37.0"
    }
  }
  required_version = ">= 1.9.0"
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
  // *service accout key path configured locally as %GOOGLE_APPLICATION_CREDENTIALS%
}