variable "name" {
  type        = string
  description = "The name of the resource, typically used as a base for other resource names."
}


variable "nat_region" {
  type        = string
  description = "The region where the NAT gateway is located, typically the same region as your other resources."
}

variable "nat_router_name" {
  type        = string
  description = "The name of the router to which the NAT gateway is attached."
}

variable "nat_name" {
  type        = string
  description = "The name of the NAT configuration associated with the router."
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


variable "subnet_conf" {
  type = map(object({
    name          = string
    ip_cidr_range = string
    region        = string
  }))
}


variable "peer_network" {
  type    = string
  default = null
}


variable "gcp_project" {
  type      = string
  sensitive = true
}