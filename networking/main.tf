resource "azurerm_virtual_network" "vnet" {
  name                = "${var.app-prefix}-${var.env}-vnet"
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = ["${var.adrr_space}"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.23.0/26"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.23.64/26"]
}

resource "azurerm_subnet" "subnet3" {
  name                 = "subnet3"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.23.128/26"]
}

resource "azurerm_subnet" "subnet4" {
  name                 = "subnet4"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.23.192/26"]
}

resource "azurerm_network_security_group" "nsg-1" {
  name                = "${var.app-prefix}-${var.env}-jump-host-nsg"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "home_rdp"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    destination_port_range     = "3389"
    source_address_prefix      = var.home_ip
    source_port_range          = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "assoc-1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg-1.id
}
