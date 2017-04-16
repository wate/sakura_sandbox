variable region {
  default = "tk1v"
}

variable use_db {
  default = true
}

variable use_loadbalanser {
  default = false
}

variable use_cache {
  default = false
}

variable use_manage {
  default = false
}

variable use_backdoor {
  default = false
}

variable web_count {
  default = 1
}

variable db_count {
  default = 1
}

variable cache_count {
  default = 1
}

variable loadbalanser_count {
  default = 1
}

variable loadbalanser_cpu {
  default = 1
}

variable loadbalanser_memory {
  default = 1
}

variable web_cpu {
  default = 1
}

variable web_memory {
  default = 1
}

variable web_capacity {
  default = 20
}

variable db_cpu {
  default = 3
}

variable db_memory {
  default = 12
}

variable db_capacity {
  default = 20
}

variable db_storage_capacity {
  default = 100
}

variable cache_cpu {
  default = 1
}

variable cache_memory {
  default = 4
}

variable cache_capacity {
  default = 20
}

variable router_nw_mask_len {
  default = 28
}

variable router_band_width {
  default = 100
}

provider sakuracloud {
  zone = "${var.region}"
}

data sakuracloud_archive "main" {
  os_type = "debian"
}

/*
data sakuracloud_archive "sub" {
  os_type = "centos"
}
*/

data sakuracloud_archive "backdoor" {
  os_type = "vyos"
}

data sakuracloud_ssh_key "main" {
  filter = {
    name   = "Name"
    values = ["dummy"]
  }
}
