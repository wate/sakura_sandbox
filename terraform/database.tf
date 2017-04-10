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
  name   = "batabase-${count.index + 1}"
  count  = "${var.use_db ? var.db_count : 0}"
  core   = "${var.db_cpu}"
  memory = "${var.db_memory}"

  disks = [
    "${element(sakuracloud_disk.database.*.id, count.index)}",
    "${element(sakuracloud_disk.database_storage.*.id, count.index)}",
  ]

  base_interface = "${sakuracloud_switch.main.id}"
  tags           = ["@virtio-net-pci"]
}
