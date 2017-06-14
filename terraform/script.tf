resource sakuracloud_note "usacloud" {
  name    = "usacloud"
  content = "${file("scripts/startup/usacloud.sh")}"
}
