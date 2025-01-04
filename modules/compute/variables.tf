variable "name" {
  type        = string
  description = "Instance name"
}

variable "image" {
  type        = string
  description = "Image for the provisoned VM"
}


variable "network" {
  type        = string
  description = "Name of the VPC"
}

variable "subnet" {
  type        = string
  description = "Subnet for the VM"
}

variable "startup_script_path" {
  type = string
}

variable "zone" {
  type        = string
  description = "Zone of the network resources"
}


variable "machine_type" {
  type        = string
  description = "Machine type of the instance"
}


variable "tags" {
  type        = list(string)
  description = "List of tags applied"
}


variable "public_key" {
  type      = string
  sensitive = true
  default   = null
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "vm_service_account"{
  type = string
  sensitive = true
}