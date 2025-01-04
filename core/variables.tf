variable "gcp_project" {
  type = string
}



variable "vm_startup_script_path" {
  description = "The path to the startup script for the VM."
  type        = string
}

variable "vm_disk_image" {
  description = "The image to use for the VM disk."
  type        = string
}

variable "vm_machine_type" {
  description = "The machine type to use for the VM."
  type        = string
}

variable "vm_name" {
  description = "The name of the VM."
  type        = string
}

variable "vm_zone" {
  description = "The zone in which the VM will be deployed."
  type        = string
}

variable "vm_tags" {
  description = "A list of tags to assign to the VM."
  type        = list(string)
}



# network configuration

variable "vpn_name" {
  description = "The name of the VPN."
  type        = string
}


variable "subnet_conf" {
  type = map(object({
    name          = string
    ip_cidr_range = string
    region        = string
  }))
}


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
  description = "A map of firewall rules configuration. Each rule contains a name, allowed and denied protocols/ports, source IP ranges, and target tags."
}


variable "nat_region" {
  description = "The region where the NAT gateway is deployed."
  type        = string
}


variable "nat_router_name" {
  description = "The name of the NAT router."
  type        = string
}

variable "nat_name" {
  description = "The name of the NAT gateway."
  type        = string
}


variable "vm_subnet" {
  type = string
}


variable "gar_location" {
  type = string
}

variable "gar_repository_id" {
  type = string
}

variable "gar_format" {
  type = string
}


variable "vm_labels" {
  type    = map(string)
  default = {}
}

variable "vm_service_account" {
  type = string
  sensitive = true
}