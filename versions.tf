terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
  required_version = ">= 0.13"
}

terraform {
  backend "gcs" {
    bucket  = "development-test-files-bq-poc"
    prefix  = "terraform/state"
  }
}
