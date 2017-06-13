/**
 * ロードバランサーの台数
 */
variable loadbalanser_count {
  default = 2
}

/**
* ロードバランサーの仮想コア数
*/
variable loadbalanser_cpu {
  default = 1
}

/**
* ロードバランサーのメモリ
*/
variable loadbalanser_memory {
  default = 1
}

resource sakuracloud_disk "loadbalanser" {
  name              = "loadbalanser-${count.index + 1}"
  count             = "${var.use_loadbalanser ? var.loadbalanser_count : 0}"
  source_archive_id = "${data.sakuracloud_archive.main.id}"
  ssh_key_ids       = ["${data.sakuracloud_ssh_key.main.id}"]
  disable_pw_auth   = true

  tags = [
    "backup_hour_1",
  ]
}

resource sakuracloud_server "loadbalanser" {
  name            = "loadbalanser-${count.index + 1}"
  count           = "${var.use_loadbalanser ? var.loadbalanser_count : 0}"
  core            = "${var.loadbalanser_cpu}"
  memory          = "${var.loadbalanser_memory}"
  disks           = ["${element(sakuracloud_disk.loadbalanser.*.id, count.index)}"]
  nic             = "${sakuracloud_internet.router.switch_id}"
  ipaddress       = "${element(sakuracloud_internet.router.nw_ipaddresses, count.index)}"
  nw_mask_len     = "${sakuracloud_internet.router.nw_mask_len}"
  gateway         = "${sakuracloud_internet.router.nw_gateway}"
  additional_nics = ["${sakuracloud_switch.main.id}"]
  tags            = ["@virtio-net-pci"]
}

output loadbalanser_ipaddresses {
  value = "${sakuracloud_server.loadbalanser.*.ipaddress}"
}
