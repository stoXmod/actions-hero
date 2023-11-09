resource "google_compute_project_metadata" "ssh_keys" {
  metadata = {
    "ssh-keys" = "terraform:${var.staging_public_key}"
  }
}

resource "google_dns_managed_zone" "my_zone" {
  name     = "pr-staging-zone"
  dns_name = "wisdomdemo.com."
  description = "Managed DNS zone for my domain"
}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

resource "google_compute_instance" "staging_pr_demo" {
  name         = "staging-pr-${random_string.random.result}"
  machine_type = "f1-micro"
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = var.base_image
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    ssh-keys = "terraform:${var.staging_public_key}"
    startup-script = file("./scripts/startup-script.sh")
  }
  tags = ["staging-pr-demo"]
}

resource "google_dns_record_set" "my_instance_dns" {
  name         = "staging-pr-${random_string.random.result}.wisdomdemo.com."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.my_zone.name
  rrdatas = [google_compute_instance.staging_pr_demo.network_interface[0].access_config[0].nat_ip]
}


