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
  source_archive_id = "${data.sakuracloud_archive.debian.id}"
  ssh_key_ids       = ["${data.sakuracloud_ssh_key.main.id}"]
  disable_pw_auth   = true

  lifecycle {
    ignore_changes = ["source_archive_id"]
  }

  note_ids = [
    "${sakuracloud_note.usacloud.id}",
  ]

  tags = [
    "backup_hour_sat_23",
  ]
}

resource sakuracloud_server "manage" {
  name            = "manage"
  count           = "${var.use_manage ? 1 : 0}"
  core            = "${var.manage_cpu}"
  memory          = "${var.manage_memory}"
  disks           = ["${sakuracloud_disk.manage.id}"]
  additional_nics = ["${sakuracloud_switch.main.id}"]
}

output manage_ipaddress {
  value = "${sakuracloud_server.manage.*.ipaddress}"
}
