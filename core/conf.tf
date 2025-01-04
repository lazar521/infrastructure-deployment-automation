provider "google" {
  project = var.gcp_project
}

terraform {
  backend "gcs" {
    prefix = "base/terraform/state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}