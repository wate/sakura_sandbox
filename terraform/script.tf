resource sakuracloud_note "usacloud" {
  name        = "usacloud"
  content     = "${file("scripts/startup/usacloud.sh")}"
  description = "usacloudをインストールします。"
}

resource sakuracloud_note "LAMP" {
  name        = "LAMP"
  content     = "${file("scripts/startup/LAMP.sh")}"
  description = "Apache, PHP, MariaDBをインストールします。"
}
