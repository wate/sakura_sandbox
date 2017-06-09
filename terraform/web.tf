/**
 * Webサーバーの台数
 */
variable web_count {
  default = 4
}

/**
 * Webサーバーの仮想コア数
 */
variable web_cpu {
  default = 1
}

/**
 * Webサーバーのメモリ
 */
variable web_memory {
  default = 1
}

/**
 * Webサーバーのストレージサイズ
 */
variable web_capacity {
  default = 20
}

resource sakuracloud_disk "web" {
  name              = "web-${count.index + 1}"
  count             = "${var.web_count}"
  size              = "${var.web_capacity}"
  source_archive_id = "${data.sakuracloud_archive.main.id}"
  ssh_key_ids       = ["${data.sakuracloud_ssh_key.main.id}"]
  disable_pw_auth   = true
}

resource sakuracloud_server "web" {
  name            = "web-${count.index + 1}"
  count           = "${var.web_count}"
  core            = "${var.web_cpu}"
  memory          = "${var.web_memory}"
  disks           = ["${element(sakuracloud_disk.web.*.id, count.index)}"]
  nic             = "${var.use_loadbalanser ? sakuracloud_switch.main.id : sakuracloud_internet.router.switch_id}"
  additional_nics = ["${var.use_loadbalanser ? "" : sakuracloud_switch.main.id}"]
  tags            = ["@virtio-net-pci"]
  ipaddress       = "${var.use_loadbalanser ? "" : element(sakuracloud_internet.router.ipaddresses, count.index)}"
  nw_mask_len     = "${var.use_loadbalanser ? "" : sakuracloud_internet.router.nw_mask_len}"
  gateway         = "${var.use_loadbalanser ? "" : sakuracloud_internet.router.gateway}"
}
