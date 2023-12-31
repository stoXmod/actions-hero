terraform {
  backend "remote" {
    organization = "metaroon"

    workspaces {
      name = "staging"
    }
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.5"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.18.0"
    }
  }

  required_version = ">= 0.15.0"
}