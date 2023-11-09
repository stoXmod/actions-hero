resource "google_compute_project_metadata" "ssh_keys" {
  metadata = {
    "ssh-keys" = "terraform:${var.staging_public_key}"
  }
}

resource "google_dns_managed_zone" "my_zone" {
  name     = "my-managed-zone"
  dns_name = "wisdomdemo.com."
  description = "Managed DNS zone for my domain"
}

resource "google_compute_instance" "staging_cicd_demo" {
  name         = "staging-cicd-demo"
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
    ssh-keys = "terraform:${var.staging_public_key}",
    startup-script = file("./scripts/startup-script.sh")
  }
  tags = ["staging-cicd-demo"]
}

resource "google_dns_record_set" "my_instance_dns" {
  name         = "staging-cicd.wisdomdemo.com."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.my_zone.name
  rrdatas = [google_compute_instance.staging_cicd_demo.network_interface[0].access_config[0].nat_ip]
}


