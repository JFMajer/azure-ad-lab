resource "azurerm_network_interface" "jump_host_nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.rg_name
  ip_configuration {
    name                          = "jump-host-ip-config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jump_host_public_ip.id
  }
}

resource "azurerm_windows_virtual_machine" "jump_host" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.location
  size                = "Standard_D2s_v5"
  priority            = "Spot"
  eviction_policy     = "Deallocate"
  admin_username      = "adminuser"
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.jump_host_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_public_ip" "jump_host_public_ip" {
  name                = "jump_host_public_ip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Dynamic"
}