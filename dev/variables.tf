
variable "gcp_project" {
  description = "Project ID"
  type        = string
}

variable "vm_name" {
  type        = string
  description = "The name of the virtual machine."
}

variable "vm_disk_image" {
  type        = string
  description = "The disk image to use for the virtual machine."
}

variable "vm_machine_type" {
  type        = string
  description = "The machine type for the virtual machine."
}

variable "vm_zone" {
  type        = string
  description = "The zone where the virtual machine will be deployed."
}

variable "vm_tags" {
  type        = list(string)
  description = "A list of tags to assign to the virtual machine."
}

variable "vm_startup_script_path" {
  type        = string
  description = "The path to the startup script for the virtual machine."
}

# Managed Instance Group (MIG) configuration
variable "mig_name" {
  type        = string
  description = "The name of the managed instance group."
}

variable "mig_region" {
  type        = string
  description = "The region where the managed instance group will be deployed."
}

variable "mig_instance_count" {
  type        = number
  description = "The number of instances in the managed instance group."
}

variable "mig_machine_type" {
  type        = string
  description = "The machine type for the managed instance group."
}

variable "mig_disk_image" {
  type        = string
  description = "The disk image to use for the instances in the managed instance group."
}

variable "mig_startup_script_path" {
  type        = string
  description = "The path to the startup script for the managed instance group."
}

# VPN configuration
variable "vpn_name" {
  type        = string
  description = "The name of the VPN configuration."
}

variable "subnet_conf" {
  default = null
  type = map(object({
    name          = string
    ip_cidr_range = string
    region        = string
  }))
}

variable "my_ip" {
  type        = string
  description = "The IP address to whitelist in firewall rules."
}

variable "nat_region" {
  type        = string
  description = "The region for NAT configuration."
}

# Firewall rules configuration
variable "firewall_rules_conf" {
  type = map(object({
    rule_name = string
    allow_rules = list(object({
      protocol = string
      ports    = list(string)
    }))
    deny_rules = list(object({
      protocol = string
      ports    = list(string)
    }))
    source_ranges = list(string)
    target_tags   = list(string)
  }))
  description = "Configuration for firewall rules."
}


variable "mig_tags" {
  type        = list(string)
  description = "A list of tags to assign to the instances in the managed instance group."
}

variable "mig_template_name" {
  type        = string
  description = "The name of the instance template used by the managed instance group."
}

variable "mig_base_instance_name" {
  type        = string
  description = "The base instance name used by the managed instance group."
}

variable "mig_initial_autohealing_delay" {
  type        = number
  description = "The initial delay in seconds before autohealing is triggered for instances in the managed instance group."
}

variable "mig_named_ports" {
  type        = map(number)
  description = "A map of named ports for the managed instance group."
}

variable "mig_appcheck_conf" {
  type = object({
    check_interval_sec  = number
    timeout_sec         = number
    healthy_threshold   = number
    unhealthy_threshold = number
    request_path        = string
    port_name           = string
  })
  description = "The health check configuration used by the managed instance group for application load balancing and monitoring."
  default     = null
}

variable "mig_subnet" {
  type = string
}


variable "nat_router_name" {
  type        = string
  description = "The name of the NAT router."
}

variable "nat_name" {
  type        = string
  description = "The name of the NAT configuration."
}

variable "mig_loadbalancing_scheme" {
  type        = string
  description = "Loadbalancing scheme used by the MIG loadbalancer"
  default     = null
}


variable "prefix" {
  type        = string
  description = "Prefix for provisioned resources"
}



variable "runner_vpc_network" {
  type = string
}

variable "runner_subnet_range" {
  type = string
}


variable "vm_public_key" {
  type      = string
  sensitive = true
}

variable "db_pass" {
  type      = string
  sensitive = true
}

variable "db_name" {
  type = string
}

variable "db_address" {
  type = string
}

variable "db_region" {
  type = string
}

variable "db_addr_prefix_length" {
  type = string
}

variable "database_name" {
  type = string
}


variable "mig_vms_labels" {
  type    = map(string)
  default = {}
}


variable "vm_service_account" {
  type = string
  sensitive = true
}


variable "database_version" {
  type = string
}


variable "database_tier" {
  type = string
}