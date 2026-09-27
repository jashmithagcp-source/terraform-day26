variable "project_id" {
  type    = string
  default = "project-b258e454-5928-4270-915"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "subnet_cidr" {
  type    = string
  default = "10.10.0.0/24"
}
variable "machine_type" {
  type    = string
  default = "e2-small"
}
