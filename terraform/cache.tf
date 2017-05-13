/**
 * キャッシュサーバーの台数
 */
variable cache_count {
  default = 1
}

/**
 * キャッシュサーバーの仮想コア数
 */
variable cache_cpu {
  default = 1
}

/**
 * キャッシュサーバーのメモリ
 */
variable cache_memory {
  default = 4
}

/**
 * キャッシュサーバーのストレージサイズ
 */

variable cache_capacity {
  default = 20
}

resource sakuracloud_disk "cache" {
  name              = "cache-${count.index + 1}"
  count             = "${var.use_cache ? var.cache_count : 0}"
  size              = "${var.cache_capacity}"
  source_archive_id = "${data.sakuracloud_archive.main.id}"
  ssh_key_ids       = ["${data.sakuracloud_ssh_key.main.id}"]
  disable_pw_auth   = true
}

resource sakuracloud_server "cache" {
  name   = "cache-${count.index + 1}"
  count  = "${var.use_cache ? var.cache_count : 0}"
  core   = "${var.cache_cpu}"
  memory = "${var.cache_memory}"
  disks  = ["${element(sakuracloud_disk.cache.*.id, count.index)}"]
  nic    = "${sakuracloud_switch.main.id}"
  tags   = ["@virtio-net-pci"]
}
