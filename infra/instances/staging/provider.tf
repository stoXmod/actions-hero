# GCP PROVIDER
provider "google" {
    credentials =  file(var.gcp_svc_key)
    project = var.gcp_project
    region=  var.gcp_zone
}

# RANDOM PROVIDER
provider "random" {}