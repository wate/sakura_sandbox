/**
 * アプリケーションサーバーの台数
 */
variable app_count {
  default = 4
}

/**
 * アプリケーションサーバーの仮想コア数
 */
variable app_cpu {
  default = 1
}

/**
 * アプリケーションサーバーのメモリ
 */
variable app_memory {
  default = 1
}

/**
 * アプリケーションサーバーのストレージサイズ
 */
variable app_capacity {
  default = 20
}

/**
 * アプリケーションサーバーのプライベートIPアドレス開始位置
 */
variable app_private_iprange_offset {
  default = 50
}

resource sakuracloud_disk "app" {
  name              = "app-${count.index + 1}"
  count             = "${var.app_count}"
  size              = "${var.app_capacity}"
  source_archive_id = "${data.sakuracloud_archive.debian.id}"
  ssh_key_ids       = ["${data.sakuracloud_ssh_key.main.id}"]
  disable_pw_auth   = true

  lifecycle {
    ignore_changes = ["source_archive_id"]
  }

  tags = [
    "backup_hour_2",
  ]
}

resource sakuracloud_server "app" {
  name            = "app-${count.index + 1}"
  count           = "${var.app_count}"
  core            = "${var.app_cpu}"
  memory          = "${var.app_memory}"
  disks           = ["${element(sakuracloud_disk.app.*.id, count.index)}"]
  nic             = "${var.use_loadbalanser ? sakuracloud_switch.main.id : sakuracloud_internet.router.switch_id}"
  additional_nics = ["${var.use_loadbalanser ? "" : sakuracloud_switch.main.id}"]
  ipaddress       = "${var.use_loadbalanser ? cidrhost(var.private_iprange, var.app_private_iprange_offset + count.index) : element(sakuracloud_internet.router.ipaddresses, count.index)}"
  nw_mask_len     = "${var.use_loadbalanser ? element(split("/", var.private_iprange), 1) : sakuracloud_internet.router.nw_mask_len}"
  gateway         = "${var.use_loadbalanser ? cidrhost(var.private_iprange, 1) : sakuracloud_internet.router.gateway}"
}

output app_ipaddresses {
  value = "${sakuracloud_server.app.*.ipaddress}"
}
