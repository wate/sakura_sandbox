/**
 * NFSの数
 */
variable nfs_count {
  default = 1
}

/**
 * NFSのサイズ
 */
variable nfs_capacity {
  default = 4096
}

/**
 * NFSのプライベートIPアドレス開始位置
 */
variable nfs_private_iprange_offset {
  default = 210
}

resource sakuracloud_nfs "storage" {
  name        = "nfs-${count.index + 1}"
  description = "storage-${count.index + 1}"
  count       = "${var.nfs_count}"
  switch_id   = "${sakuracloud_switch.main.id}"
  plan        = "${var.nfs_capacity}"
  ipaddress   = "${cidrhost(var.private_iprange, var.nfs_private_iprange_offset + count.index)}"
  nw_mask_len = "${sakuracloud_internet.router.nw_mask_len}"
}

output nfs_ipaddress {
  value = "${sakuracloud_nfs.storage.*.ipaddress}"
}
