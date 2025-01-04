
resource "google_compute_instance_template" "instance_template" {
  name   = var.template_name
  tags   = var.mig_tags
  labels = var.labels

  machine_type            = var.machine_type
  can_ip_forward          = false
  metadata_startup_script = file(var.startup_script_path)

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image = var.image
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = var.network
    subnetwork = "projects/${var.gcp_project}/regions/${var.region}/subnetworks/${var.subnet}"
  }

  metadata = var.public_key == "" ? null : {
    "ssh-keys" = var.public_key
  }

  service_account {
    email  = var.vm_service_account
    scopes = ["cloud-platform"]
  }
}



resource "google_compute_region_instance_group_manager" "instance_group_manager" {
  name               = var.group_name
  base_instance_name = var.base_instance_name
  region             = var.region
  target_size        = var.instance_count


  dynamic "named_port" {
    for_each = var.named_ports
    content {
      name = named_port.key
      port = named_port.value
    }
  }

  version {
    instance_template = google_compute_instance_template.instance_template.self_link
  }

}


resource "google_compute_health_check" "http_health_check" {
  name                = "${var.group_name}-app"
  check_interval_sec  = var.appcheck_conf.check_interval_sec
  timeout_sec         = var.appcheck_conf.timeout_sec
  healthy_threshold   = var.appcheck_conf.healthy_threshold
  unhealthy_threshold = var.appcheck_conf.unhealthy_threshold

  http_health_check {
    request_path = var.appcheck_conf.request_path
    port_name    = var.appcheck_conf.port_name
  }
}



resource "google_compute_backend_service" "default" {
  name          = var.group_name
  health_checks = [google_compute_health_check.http_health_check.self_link]

  load_balancing_scheme = "EXTERNAL"
  protocol              = "HTTP"
  port_name             = "http"

  backend {
    group           = google_compute_region_instance_group_manager.instance_group_manager.instance_group
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
    capacity_scaler = 1.0
  }
}


resource "google_compute_url_map" "default" {
  name            = var.group_name
  default_service = google_compute_backend_service.default.self_link
}


resource "google_compute_target_http_proxy" "default" {
  name    = var.group_name
  url_map = google_compute_url_map.default.self_link

}


resource "google_compute_global_address" "ip_address" {
  name = var.group_name
}


resource "google_compute_global_forwarding_rule" "default" {
  name                  = var.group_name
  target                = google_compute_target_http_proxy.default.self_link
  port_range            = "80"
  load_balancing_scheme = var.loadbalancing_scheme
  ip_protocol           = "TCP"
  ip_address            = google_compute_global_address.ip_address.address
}