terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("${path.module}/service-account-file.json")
  project = "lorenzo-terraform-test"
  region  = "us-central1"
}

resource "google_storage_bucket" "demo-bucket" {
  name          = "lorenzo-terraform-test-demo-bucket"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }
}