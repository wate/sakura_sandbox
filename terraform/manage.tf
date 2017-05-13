/**
 * 管理サーバーの仮想コア数
 */
variable manage_cpu {
  default = 1
}

/**
 * 管理サーバーのメモリ
 */
variable manage_memory {
  default = 1
}

/**
 * 管理サーバーのストレージサイズ
 */

variable manage_capacity {
  default = 20
}

resource sakuracloud_disk "manage" {
  name              = "manage"
  count             = "${var.use_manage ? 1 : 0}"
  size              = "${var.manage_capacity}"
  source_archive_id = "${data.sakuracloud_archive.main.id}"
  ssh_key_ids       = ["${data.sakuracloud_ssh_key.main.id}"]
  disable_pw_auth   = true
}

resource sakuracloud_server "manage" {
  name   = "manage"
  count  = "${var.use_manage ? 1 : 0}"
  core   = "${var.manage_cpu}"
  memory = "${var.manage_memory}"
  disks  = ["${sakuracloud_disk.manage.id}"]
  nic    = "${sakuracloud_switch.main.id}"
  tags   = ["@virtio-net-pci"]
}
