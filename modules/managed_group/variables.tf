variable "template_name" {
  type        = string
  description = "The name of the instance template used for launching instances."
}

variable "machine_type" {
  type        = string
  description = "The machine type to use for the instances"
}

variable "image" {
  type        = string
  description = "The disk image used to create the instances"
}

variable "network" {
  type        = string
  description = "The name or self-link of the VPC network to associate with the instances."
}

variable "base_instance_name" {
  type        = string
  description = "The base name for the instances in the managed instance group (MIG)."
}

variable "group_name" {
  type        = string
  description = "The name of the managed instance group (MIG)."
}

variable "region" {
  type        = string
  description = "The region where the resources will be deployed"
}

variable "instance_count" {
  type        = number
  description = "The desired number of instances in the managed instance group (MIG)."
}

variable "mig_tags" {
  description = "Network tags to assign to the instances in the managed instance group (MIG) for firewall rules and other purposes."
  type        = list(string) # Assuming it's a list of tags
}

variable "startup_script_path" {
  type        = string
  description = "The local path to the startup script to be executed when the instance boots."
}

variable "named_ports" {
  type        = map(number)
  description = "A map of named ports where keys represent protocol names  and values represent port numbers"
}

variable "initial_autohealing_delay" {
  type        = number
  description = "The initial delay (in seconds) before autohealing is applied to new instances in the managed instance group."
}



variable "appcheck_conf" {
  type = object({
    check_interval_sec  = number
    timeout_sec         = number
    healthy_threshold   = number
    unhealthy_threshold = number
    request_path        = string
    port_name           = string
  })
  description = "Configuration for the health check used by the application for load balancing or monitoring, including intervals, timeouts, thresholds, and health check paths."
}

variable "loadbalancing_scheme" {
  type        = string
  description = "Loadbalancing scheme used by the global forwarding rule"
}



variable "public_key" {
  type      = string
  sensitive = true
}


variable "subnet" {
  type = string
}


variable "gcp_project" {
  type = string
}

variable "labels" {
  type    = map(string)
  default = {}
}


variable "vm_service_account" {
  type = string
  sensitive = true
}