output "domain_name" {
  value = "${cloudflare_record.my_instance_dns.name}.${cloudflare_zone.my_zone.zone}"
  description = "The FQDN of the DNS record"
}