module "network" {
  source     = "../modules/network"
  name       = var.vpn_name
  nat_region = var.nat_region

  gcp_project         = var.gcp_project
  firewall_rules_conf = var.firewall_rules_conf
  nat_router_name     = var.nat_router_name
  nat_name            = var.nat_name
  subnet_conf         = var.subnet_conf
}


module "runner" {
  depends_on          = [module.network]
  source              = "../modules/compute"
  startup_script_path = abspath(var.vm_startup_script_path)
  image               = var.vm_disk_image
  machine_type        = var.vm_machine_type
  name                = var.vm_name
  zone                = var.vm_zone
  tags                = var.vm_tags
  network             = module.network.self_link
  subnet              = var.vm_subnet
  labels              = var.vm_labels
  vm_service_account = var.vm_service_account
}


resource "google_artifact_registry_repository" "default" {
  location      = var.gar_location
  repository_id = var.gar_repository_id
  format        = var.gar_format
}