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

/**
 * プライベートIPアドレスの範囲
 */
variable private_iprange {
  default = "192.168.1.0/24"
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

# データソース(Data Resource)とは、読み取り専用のリソースです。
# すでにさくらのクラウド上に存在するリソースの値を参照するために用います。
# http://sacloud.github.io/terraform-provider-sakuracloud/configuration/resources/data_resource/
data sakuracloud_ssh_key "main" {
  filter = {
    name   = "Name"
    values = [
      "dummy"
    ]
  }
}
# 「dummy」という名前で公開鍵を登録/更新する場合は、
# ↑のデータソース部分をコメントアウトなどで無効化し、
# 以下のコードを有効にしてね
/*
resource sakuracloud_ssh_key "main" {
  name = "dummy"
  public_key = "${file("/path/to/id_rsa.pub")}"
}
*/
