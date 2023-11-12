variable "instance_name" {
  description = "Name of the VM instance"
  type        = string
}

variable "zone" {
  description = "The GCP zone for the resources"
  type        = string
  default     = "us-central1-a"
}

variable "staging_public_key" {
  description = "Staging environment public key value"
  type        = string
}

variable "base_image" {
  description = "Base image for the instance"
  type        = string
}

variable "gcp_svc_key" {
  description = "GCP service account key"
  type        = string
}

variable "gcp_project" {
  description = "GCP project name"
  type        = string
}

variable "gcp_zone" {
  description = "GCP project zone"
  type        = string
}

variable "dns_name" {
  description = "DNS name for the instance"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare account API token"
  type        = string
}

variable "cloudflare_account_id" {
    description = "Cloudflare account ID"
    type        = string
}

variable "cloudflare_zone" {
    description = "Cloudflare zone"
    type        = string
}