/*
 * ----------------------------
 * リージョン
 * ----------------------------
 */
variable region {
  default = "tk1v"
}

/*
 * ----------------------------
 * 各サーバーリソースの利用の可否
 * ----------------------------
 */

/**
 * データベースサーバーを利用するか否か
 */
variable use_db {
  default = true
}

/**
 * ロードバランサーを利用するか否か
 */
variable use_loadbalanser {
  default = true
}

/**
 * キャッシュサーバーを利用するか否か
 */
variable use_cache {
  default = true
}

/**
 * 管理サーバーを利用するか否か
 */
variable use_manage {
  default = true
}

/**
 * VPNを利用するか否か
 */
variable use_backdoor {
  default = true
}

provider sakuracloud {
  zone = "${var.region}"
}

data sakuracloud_archive "main" {
  os_type = "debian"
}

data sakuracloud_archive "sub" {
  os_type = "centos"
}

data sakuracloud_archive "backdoor" {
  os_type = "vyos"
}

data sakuracloud_ssh_key "main" {
  filter = {
    name   = "Name"
    values = ["dummy"]
  }
}
