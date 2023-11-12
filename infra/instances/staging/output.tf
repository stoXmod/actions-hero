output "public_domain_name" {
  value = "${cloudflare_record.my_instance_dns.name}.${data.cloudflare_zones.my_zone.zones[0].name}"
  description = "The FQDN of the DNS record"
}