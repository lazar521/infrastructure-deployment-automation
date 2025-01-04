
resource "google_compute_instance" "temporary_vm" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnet
  }

  tags   = var.tags
  labels = var.labels

  metadata_startup_script = file(var.startup_script_path)

  metadata = var.public_key == "" ? null : {
    "ssh-keys" = var.public_key
  }

  service_account {
    email  = var.vm_service_account
    scopes = ["cloud-platform"]
  }
}
