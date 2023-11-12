output "dns_details" {
  value = {
    domain_name = "${cloudflare_record.my_instance_dns.name}.${data.cloudflare_zones.my_zone.zones[0].name}"
    public_ip = google_compute_instance.staging_pr_demo.network_interface[0].access_config[0].nat_ip
  }
  description = "Map containing the DNS record name and zone name"
}