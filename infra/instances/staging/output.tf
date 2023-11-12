output "public_domain_name" {
  value = "${cloudflare_record.my_instance_dns.name}.${data.cloudflare_zone.my_zone.name_servers.0}"
  description = "The FQDN of the DNS record"
}