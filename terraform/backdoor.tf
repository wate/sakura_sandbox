resource sakuracloud_disk "backdoor" {
  name              = "backdoor"
  count             = "${var.use_backdoor ? 1 : 0}"
  source_archive_id = "${data.sakuracloud_archive.backdoor.id}"
  ssh_key_ids       = ["${data.sakuracloud_ssh_key.main.id}"]
  disable_pw_auth   = true
}

resource sakuracloud_server "backdoor" {
  name            = "backdoor"
  count           = "${var.use_backdoor ? 1 : 0}"
  disks           = ["${sakuracloud_disk.backdoor.id}"]
  additional_nics = ["${sakuracloud_switch.main.id}"]
  tags            = ["@virtio-net-pci"]
}
