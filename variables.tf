variable "env" {
  type    = string
  default = "dev"
}

variable "location" {
  type    = string
  default = "francecentral"
}

variable "app-prefix" {
  type    = string
  default = "ad-lab"
}

variable "adrr_space" {
  type    = string
  default = "10.0.23.0/24"
}

variable "home_ip" {}
variable "admin_password" {}