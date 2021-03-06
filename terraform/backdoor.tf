resource sakuracloud_disk "backdoor" {
  name              = "backdoor"
  count             = "${var.use_backdoor ? 1 : 0}"
  source_archive_id = "${data.sakuracloud_archive.vyos.id}"
  ssh_key_ids       = ["${data.sakuracloud_ssh_key.main.id}"]
  disable_pw_auth   = true

  lifecycle {
    ignore_changes = ["source_archive_id"]
  }

  tags = [
    "backup_week_web_0",
  ]
}

resource sakuracloud_server "backdoor" {
  name            = "backdoor"
  count           = "${var.use_backdoor ? 1 : 0}"
  disks           = ["${sakuracloud_disk.backdoor.id}"]
  additional_nics = ["${sakuracloud_switch.main.id}"]
}

output backdoor_ipaddress {
  value = "${sakuracloud_server.backdoor.*.ipaddress}"
}
