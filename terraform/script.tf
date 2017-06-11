resource sakuracloud_note "usacloud" {
    name = "usacloud"
    content = "${file("scripts/usacloud.sh")}"
}
