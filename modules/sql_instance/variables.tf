variable "db_pass" {
  type      = string
  sensitive = true
}

variable "network" {
  type = string
}

variable "region" {
  type = string
}

variable "name" {
  type = string
}

variable "address" {
  type = string
}

variable "prefix_length" {
  type = number
}

variable "gcp_project" {
  type = string
}


variable "database_name" {
  type = string
}


variable "database_version" {
  type = string
}


variable "database_tier" {
  type = string
}