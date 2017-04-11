resource sakuracloud_disk "web" {
  name              = "web-${count.index + 1}"
  count             = "${var.web_count}"
  size              = "${var.web_capacity}"
  source_archive_id = "${data.sakuracloud_archive.main.id}"
  ssh_key_ids       = ["${data.sakuracloud_ssh_key.main.id}"]
  disable_pw_auth   = true
}

resource sakuracloud_server "web" {
  name                  = "web-${count.index + 1}"
  count                 = "${var.web_count}"
  core                  = "${var.web_cpu}"
  memory                = "${var.web_memory}"
  disks                 = ["${element(sakuracloud_disk.web.*.id, count.index)}"]
  base_interface        = "${ ! var.use_loadbalanser ? "shared" : sakuracloud_switch.main.id}"
  additional_interfaces = ["${var.use_loadbalanser ? "" : sakuracloud_switch.main.id}"]
  tags                  = ["@virtio-net-pci"]
}
