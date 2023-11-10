output "instance_public_ip" {
  value = google_compute_instance.staging_pr_demo.network_interface[0].access_config[0].nat_ip
  description = "The public IP address of the instance."
}