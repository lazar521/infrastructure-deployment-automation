
runner_vpc_network  = "runner-network"
runner_subnet_range = "10.1.0.0/16"
prefix              = "dev"



## Virtual machine configuration
vm_name                = "lv-instance"
vm_startup_script_path = "./scripts/startup.sh"
vm_disk_image          = "debian-12"
vm_machine_type        = "e2-medium"
vm_zone                = "us-central1-a"
vm_tags                = ["ssh-server", "http-server"]



## MIG configuration
mig_name                      = "lv-group-1"
mig_template_name             = "lv-mig-template"
mig_base_instance_name        = "lv-mig-base-instance"
mig_vms_labels                = { type = "webserver" }
nat_router_name               = "lv-nat-router"
nat_name                      = "lv-nat-name"
mig_instance_count            = 1
mig_region                    = "us-central1"
mig_machine_type              = "e2-medium"
mig_disk_image                = "debian-12"
mig_startup_script_path       = "./scripts/startup.sh"
mig_tags                      = ["ssh-server", "http-server"]
mig_initial_autohealing_delay = 300
mig_named_ports               = { "http" = 80 }
mig_loadbalancing_scheme      = "EXTERNAL"
mig_subnet                    = "subnet-1"
mig_appcheck_conf = {
  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3
  request_path        = "/"
  port_name           = "http"
}



## Database configuration
db_addr_prefix_length = 16
db_name               = "main-database"
db_address            = "10.3.0.0"
db_region             = "us-central1"
database_name         = "petclinic"
database_version = "MYSQL_8_0"
database_tier = "db-f1-micro"


## Netowrk configuration
my_ip      = ""
vpn_name   = "lv-network-1"
nat_region = "us-central1"
subnet_conf = {
  subnet1 = {
    name          = "subnet-1"
    ip_cidr_range = "10.0.0.0/16"
    region        = "us-central1"
  }
}


firewall_rules_conf = {
  "lv-network-1-allow-http" = {
    rule_name = "lv-network-1-allow-http"
    allow_rules = [{
      protocol = "tcp"
      ports    = ["80"]
    }]
    deny_rules    = []
    source_ranges = ["10.1.0.0/16"]
    target_tags   = ["http-server"]
  },

  "lv-network-1-allow-ssh" = {
    rule_name = "lv-network-1-allow-ssh"
    allow_rules = [{
      protocol = "tcp"
      ports    = ["22"]
    }]
    deny_rules    = []
    source_ranges = ["10.1.0.0/16"]
    target_tags   = ["ssh-server"]
  },

  "lv-network-1-allow-health-checks" = {
    rule_name = "lv-network-1-allow-health-checks"
    allow_rules = [{
      protocol = "tcp"
      ports    = ["80"]
    }]
    deny_rules    = []
    source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
    target_tags   = ["http-server"]
  },

  "lv-network-1-allow-gcp-services" = {
    rule_name = "lv-network-1-allow-gcp-services"
    allow_rules = [{
      protocol = "tcp"
      ports    = ["22"]
    }]
    deny_rules    = []
    source_ranges = ["35.235.240.0/20"]
    target_tags   = ["ssh-server"]
  },

  "lv-network-1-allow-internal" = {
    rule_name = "lv-network-1-allow-internal"
    allow_rules = [
      {
        protocol = "tcp"
        ports    = ["0-65535"]
      },
      {
        protocol = "udp"
        ports    = ["0-65535"]
      }
    ]
    deny_rules    = []
    source_ranges = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
    target_tags   = ["http-server"]
  }

}
