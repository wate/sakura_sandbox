/**
 * データベースサーバーの台数
 */
variable db_count {
  default = 1
}

/**
 * データベースサーバーの仮想コア数
 */
variable db_cpu {
  default = 3
}

/**
 * データベースサーバーのメモリ
 */
variable db_memory {
  default = 12
}

/**
 * データベースサーバーのストレージサイズ(ROOTボリューム)
 */
variable db_capacity {
  default = 20
}

/**
 * データベースサーバーのサイズ(DATAボリューム)
 */
variable db_storage_capacity {
  default = 100
}

resource sakuracloud_disk "database" {
  name              = "database-${count.index + 1}"
  count             = "${var.use_db ? var.db_count : 0}"
  size              = "${var.db_capacity}"
  source_archive_id = "${data.sakuracloud_archive.main.id}"
  ssh_key_ids       = ["${data.sakuracloud_ssh_key.main.id}"]
  disable_pw_auth   = true
}

resource sakuracloud_disk "database_storage" {
  name  = "database_strage-${count.index + 1}"
  count = "${var.use_db ? var.db_count : 0}"
  size  = "${var.db_storage_capacity}"
}

resource sakuracloud_server "database" {
  name   = "database-${count.index + 1}"
  count  = "${var.use_db ? var.db_count : 0}"
  core   = "${var.db_cpu}"
  memory = "${var.db_memory}"

  disks = [
    "${element(sakuracloud_disk.database.*.id, count.index)}",
    "${element(sakuracloud_disk.database_storage.*.id, count.index)}",
  ]

  nic  = "${sakuracloud_switch.main.id}"
  tags = ["@virtio-net-pci"]
}
