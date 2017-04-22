resource sakuracloud_disk "loadbalanser" {
  name              = "loadbalanser-${count.index + 1}"
  count             = "${var.use_loadbalanser ? var.loadbalanser_count : 0}"
  source_archive_id = "${data.sakuracloud_archive.main.id}"
  ssh_key_ids       = ["${data.sakuracloud_ssh_key.main.id}"]
  disable_pw_auth   = true
}

resource sakuracloud_server "loadbalanser" {
  name                  = "loadbalanser-${count.index + 1}"
  count                 = "${var.use_loadbalanser ? var.loadbalanser_count : 0}"
  core                  = "${var.loadbalanser_cpu}"
  memory                = "${var.loadbalanser_memory}"
  disks                 = ["${element(sakuracloud_disk.loadbalanser.*.id, count.index)}"]
  base_interface        = "${sakuracloud_internet.router.switch_id}"
  base_nw_ipaddress     = "${element(sakuracloud_internet.router.nw_ipaddresses, count.index)}"
  base_nw_mask_len      = "${sakuracloud_internet.router.nw_mask_len}"
  base_nw_gateway       = "${sakuracloud_internet.router.nw_gateway}"
  additional_interfaces = ["${sakuracloud_switch.main.id}"]
  tags                  = ["@virtio-net-pci"]
}
