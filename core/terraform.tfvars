
# GAR configuration
gar_location      = "us-central1"
gar_repository_id = "docker-gar"
gar_format        = "DOCKER"



# Runner configuratin 

vm_name                = "actions-runner"
vm_disk_image          = "debian-12"
vm_machine_type        = "e2-medium"
vm_zone                = "us-central1-a"
vm_tags                = ["ssh-server"]
vm_startup_script_path = "./scripts/startup.sh"
vm_subnet              = "runner-subnet"
vm_labels              = { type = "actions-runner" }



# Network configuration

vpn_name        = "runner-network"
nat_name        = "runner-nat"
nat_region      = "us-central1"
nat_router_name = "runner-nat-router"
subnet_conf = {
  subnet1 = {
    name          = "runner-subnet"
    ip_cidr_range = "10.1.0.0/16"
    region        = "us-central1"
  }
}

firewall_rules_conf = {
  allow-iap = {
    rule_name = "allow-iap"
    allow_rules = [{
      protocol = "TCP"
      ports    = ["22"]
    }]

    deny_rules    = []
    source_ranges = ["35.235.240.0/20"]
    target_tags   = ["ssh-server"]
  }
}
