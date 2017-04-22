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
  default = false
}

/**
 * キャッシュサーバーを利用するか否か
 */
variable use_cache {
  default = false
}

/**
 * 管理サーバーを利用するか否か
 */
variable use_manage {
  default = false
}

/**
 * VPNを利用するか否か
 */
variable use_backdoor {
  default = false
}

/*
 * ----------------------------
 * 各サーバーリソースの台数
 * ----------------------------
 */
/**
 * Webサーバーの台数
 */
variable web_count {
  default = 1
}

/**
 * データベースサーバーの台数
 */
variable db_count {
  default = 1
}

/**
 * キャッシュサーバーの台数
 */
variable cache_count {
  default = 1
}

/**
 * ロードバランサーの台数
 */
variable loadbalanser_count {
  default = 1
}

/*
 * ----------------------------
 * 各サーバーリソースのスペック
 * ----------------------------
 */

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

/**
 * Webサーバーの仮想コア数
 */
variable web_cpu {
  default = 1
}

/**
 * Webサーバーのメモリ
 */
variable web_memory {
  default = 1
}

/**
 * Webサーバーのストレージサイズ
 */
variable web_capacity {
  default = 20
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

/**
 * ルーターのネットマスク長
 */
variable router_nw_mask_len {
  default = 28
}

/**
 * ルーターの帯域幅
 */
variable router_band_width {
  default = 100
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
