
resource "google_compute_project_metadata" "ssh_keys" {
  metadata = {
    "ssh-keys" = "stoxmod:${var.staging_public_key}"
  }
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
    ssh-keys = "stoxmod:${var.staging_public_key}"
    startup-script = file("./scripts/startup-script.sh")
  }
  tags = ["staging-pr-demo"]
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags = ["staging-pr-demo"]
}

resource "google_compute_firewall" "allow_https" {
  name    = "allow-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  target_tags = ["staging-pr-demo"]
}

data "cloudflare_zones" "my_zone" {
    filter {
        name   = var.cloudflare_zone
        status = "active"
    }
}

resource "cloudflare_record" "my_instance_dns" {
  zone_id = data.cloudflare_zones.my_zone.zones[0].id
  name    = "staging-pr-${random_string.random.result}"
  value   = google_compute_instance.staging_pr_demo.network_interface[0].access_config[0].nat_ip
  type    = "A"
  proxied = true
  ttl     = 1
  depends_on = [
    google_compute_instance.staging_pr_demo,
    random_string.random
  ]
}


