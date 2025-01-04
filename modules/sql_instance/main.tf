
resource "google_compute_global_address" "private_ip_address" {
  name          = "${var.name}-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = var.prefix_length
  network       = var.network
  address       = var.address
}


resource "google_service_networking_connection" "private_vpc_connection" {
  depends_on              = [google_compute_global_address.private_ip_address]
  deletion_policy         = "ABANDON"
  network                 = var.network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_sql_database_instance" "database" {
  depends_on       = [google_service_networking_connection.private_vpc_connection]
  name             = var.name
  region           = var.region
  database_version = var.database_version
  root_password    = var.db_pass

  settings {
    tier = var.database_tier

    ip_configuration {
      private_network = var.network
      ipv4_enabled = false
    }

    password_validation_policy {
      min_length                  = 6
      reuse_interval              = 2
      disallow_username_substring = true
      enable_password_policy      = true
    }
  }
  deletion_protection = false
}

resource "google_sql_database" "database" {
  depends_on = [google_sql_database_instance.database]
  name       = var.database_name
  instance   = google_sql_database_instance.database.name
}

resource "google_sql_user" "users" {
  depends_on = [google_sql_database_instance.database]
  name       = var.database_name
  instance   = google_sql_database_instance.database.name
  password   = var.db_pass
}