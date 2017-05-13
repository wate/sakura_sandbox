resource sakuracloud_internet "router" {
  name        = "router"
  band_width  = 100
  nw_mask_len = 28
}

resource sakuracloud_switch "main" {
  name = "switch"
}
