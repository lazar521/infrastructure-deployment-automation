module "network" {
  gcp_project = var.gcp_project
  source      = "../modules/network"
  name        = var.vpn_name
  nat_region  = var.nat_region

  firewall_rules_conf = var.firewall_rules_conf
  nat_router_name     = var.nat_router_name
  nat_name            = var.nat_name
  subnet_conf         = var.subnet_conf
  peer_network        = var.runner_vpc_network
}



module "managed_group" {
  depends_on                = [module.network]
  gcp_project               = var.gcp_project
  source                    = "../modules/managed_group"
  network                   = module.network.self_link
  group_name                = var.mig_name
  region                    = var.mig_region
  instance_count            = var.mig_instance_count
  machine_type              = var.mig_machine_type
  image                     = var.mig_disk_image
  mig_tags                  = var.mig_tags
  startup_script_path       = abspath(var.mig_startup_script_path)
  template_name             = var.mig_template_name
  base_instance_name        = var.mig_base_instance_name
  initial_autohealing_delay = var.mig_initial_autohealing_delay
  named_ports               = var.mig_named_ports
  appcheck_conf             = var.mig_appcheck_conf
  loadbalancing_scheme      = var.mig_loadbalancing_scheme
  subnet                    = var.mig_subnet
  public_key                = var.vm_public_key
  labels                    = var.mig_vms_labels
  vm_service_account = var.vm_service_account
}


module "database" {
  depends_on    = [module.network]
  gcp_project   = var.gcp_project
  source        = "../modules/sql_instance"
  network       = module.network.self_link
  db_pass       = var.db_pass
  region        = var.mig_region
  name          = var.db_name
  address       = var.db_address
  prefix_length = var.db_addr_prefix_length
  database_name = var.database_name
  database_version = var.database_version
  database_tier = var.database_tier
}