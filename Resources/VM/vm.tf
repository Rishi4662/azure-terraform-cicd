
# To Create Public-IP
resource "azurerm_public_ip" "public_ip" {
  name                = "${var.name}-Public-IP"
  location            = var.resource-location
  resource_group_name = var.rg-name
  allocation_method   = "Dynamic"
}

# To Create NIC Card
resource "azurerm_network_interface" "nic" {
  name                = "${var.name}VM-NIC"
  location            = var.resource-location
  resource_group_name = var.rg-name

  ip_configuration {
    name                          = "${var.name}-ip-config"
    subnet_id                     = var.subnet-id
    public_ip_address_id          = azurerm_public_ip.public_ip.id
    private_ip_address_allocation = "Dynamic"
  }
}

# To Create Virtual Machine
resource "azurerm_linux_virtual_machine" "my_vm" {
  name                  = "${var.name}-vm"
  location              = var.resource-location
  resource_group_name   = var.rg-name
  size                  = var.size
  network_interface_ids = [azurerm_network_interface.nic.id]
  computer_name         = "ubuntu"
  admin_username        = var.username
  admin_password        = var.vm-password
  disable_password_authentication = false
  custom_data           = filebase64("${path.module}/custom-script.tpl")

  os_disk {
    name                 = "${var.name}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
        Email    = var.Email
        Owner    = var.Owner
        Purpose  = var.Purpose
        Client   = var.Client
  }
}

output "vm_ip_address" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "password" {
    value = azurerm_linux_virtual_machine.my_vm.admin_password
}
