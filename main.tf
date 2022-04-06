resource "azurerm_resource_group" "ad-lab-rg" {
  name     = "${var.app-prefix}-${var.env}-rg"
  location = var.location
}

module "networking" {
  source     = "./networking"
  rg_name    = azurerm_resource_group.ad-lab-rg.name
  adrr_space = var.adrr_space
  home_ip    = var.home_ip
  app-prefix = var.app-prefix
  env        = var.env
  location   = var.location
}

module "jump_host" {
  source         = "./jump-host"
  nic_name       = "${var.app-prefix}-${var.env}-jump-host-nic"
  vm_name        = "${var.app-prefix}-${var.env}-jump"
  rg_name        = azurerm_resource_group.ad-lab-rg.name
  location       = var.location
  subnet_id      = module.networking.subnet1_id
  admin_password = var.admin_password
}
