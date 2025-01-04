
resource "google_compute_network" "vpc_network" {
  name                    = var.name
  auto_create_subnetworks = false
}



resource "google_compute_subnetwork" "subnet" {
  depends_on = [google_compute_network.vpc_network]
  network    = google_compute_network.vpc_network.self_link

  for_each = var.subnet_conf

  name          = each.value.name
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region
}


resource "google_compute_firewall" "firewall_rule" {
  for_each = var.firewall_rules_conf

  network = google_compute_network.vpc_network.self_link
  name    = each.value.rule_name

  dynamic "allow" {
    for_each = each.value.allow_rules
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  dynamic "deny" {
    for_each = each.value.deny_rules
    content {
      protocol = deny.value.protocol
      ports    = deny.value.ports
    }
  }

  source_ranges = each.value.source_ranges
  target_tags   = each.value.target_tags
}



resource "google_compute_firewall" "allow_https_egress" {
  name    = var.name
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  direction          = "EGRESS"
  destination_ranges = ["0.0.0.0/0"]
}


resource "google_compute_router" "router" {
  name    = var.nat_router_name
  region  = var.nat_region
  network = google_compute_network.vpc_network.id

  bgp {
    asn = 64514
  }
}


resource "google_compute_router_nat" "nat" {
  name                               = var.nat_name
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}




resource "google_compute_network_peering" "peering1" {
  count = var.peer_network == null ? 0 : 1 # create these if peer_network is provided 

  depends_on   = [google_compute_network.vpc_network]
  name         = "peering-${var.peer_network}-${google_compute_network.vpc_network.name}"
  network      = "projects/${var.gcp_project}/global/networks/${var.peer_network}"
  peer_network = google_compute_network.vpc_network.self_link
}

resource "google_compute_network_peering" "peering2" {
  count = var.peer_network == null ? 0 : 1 # create these if peer_network is provided

  depends_on   = [google_compute_network.vpc_network]
  name         = "peering-${google_compute_network.vpc_network.name}-${var.peer_network}"
  network      = google_compute_network.vpc_network.self_link
  peer_network = "projects/${var.gcp_project}/global/networks/${var.peer_network}"
}
