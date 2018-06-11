/**
 * キャッシュサーバーの台数
 */
variable cache_count {
  default = 2
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

/**
 * キャッシュサーバーのプライベートIPアドレス開始位置
 */

variable cache_private_iprange_offset {
  default = 150
}

resource sakuracloud_disk "cache" {
  name              = "cache-${count.index + 1}"
  count             = "${var.use_cache ? var.cache_count : 0}"
  size              = "${var.cache_capacity}"
  source_archive_id = "${data.sakuracloud_archive.debian.id}"
  ssh_key_ids       = ["${data.sakuracloud_ssh_key.main.id}"]
  disable_pw_auth   = true

  lifecycle {
    ignore_changes = ["source_archive_id"]
  }

  tags = [
    "backup_hour_4",
  ]
}

resource sakuracloud_server "cache" {
  name        = "cache-${count.index + 1}"
  count       = "${var.use_cache ? var.cache_count : 0}"
  core        = "${var.cache_cpu}"
  memory      = "${var.cache_memory}"
  disks       = ["${element(sakuracloud_disk.cache.*.id, count.index)}"]
  nic         = "${sakuracloud_switch.main.id}"
  ipaddress   = "${cidrhost(var.private_iprange, var.cache_private_iprange_offset + count.index)}"
  nw_mask_len = "${element(split("/", var.private_iprange), 1)}"
  gateway     = "${cidrhost(var.private_iprange, 1)}"
}

output cache_ipaddresses {
  value = "${sakuracloud_server.cache.*.ipaddress}"
}
