resource sakuracloud_internet "router" {
  name        = "router"
  band_width  = "${var.router_band_width}"
  nw_mask_len = "${var.router_nw_mask_len}"
}

resource sakuracloud_switch "main" {
  name = "switch"
}
