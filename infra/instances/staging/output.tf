output "instance_dns_name" {
  value = google_dns_record_set.my_instance_dns.name
}