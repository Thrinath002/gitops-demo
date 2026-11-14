variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "name" {
  type    = string
  default = "demo"
}

variable "gke_nodes_cidr" {
  type    = string
  default = "10.10.0.0/20"
}

variable "ci_cidr" {
  type    = string
  default = "10.10.16.0/24"
}

variable "pods_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "services_cidr" {
  type    = string
  default = "10.30.0.0/20"
}