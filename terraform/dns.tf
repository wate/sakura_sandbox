/**
 * ドメイン
 */
# resource sakuracloud_dns_record "www" {
#   dns_id = "${data.sakuracloud_dns.my_domain.id}"
#   name   = "www"
#   type   = "A"
#   value  = "${sakuracloud_server.xxxxxxx.ipaddress}"
# }
