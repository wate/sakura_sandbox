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
  base_interface        = "${var.use_loadbalanser ? sakuracloud_switch.main.id : sakuracloud_internet.router.switch_id}"
  additional_interfaces = ["${var.use_loadbalanser ? "" : sakuracloud_switch.main.id}"]
  tags                  = ["@virtio-net-pci"]

  base_nw_ipaddress = "${var.use_loadbalanser ? "" : element(sakuracloud_internet.router.nw_ipaddresses, count.index)}"
  base_nw_mask_len  = "${var.use_loadbalanser ? "" : sakuracloud_internet.router.nw_mask_len}"
  base_nw_gateway   = "${var.use_loadbalanser ? "" : sakuracloud_internet.router.nw_gateway}"
}
