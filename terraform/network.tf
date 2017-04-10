resource sakuracloud_switch "main" {
  name = "switch"

  /*count = "${var.use_loadbalanser || var.use_db || var.use_cache || var.use_manage || var.use_backdoor ? 1 : 0}"*/
}
