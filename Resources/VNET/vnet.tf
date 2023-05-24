# To Create Azure-Virtual-Network and Subnets

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name}-VNET"
  location            = var.resource-location
  resource_group_name = var.rg-name
  address_space       = ["10.0.0.0/16"]
  tags = {
        Email    = var.Email
        Owner    = var.Owner
        Purpose  = var.Purpose
        Client   = var.Client
  }
}

resource "azurerm_subnet" "subnet1" {
    name                  = "${var.name}-subnet1"
    address_prefixes      = ["10.0.1.0/24"]
    resource_group_name   = var.rg-name
    virtual_network_name  = azurerm_virtual_network.vnet.name
  }

resource "azurerm_subnet" "subnet2" {
    name                  = "${var.name}-subnet2"
    address_prefixes      = ["10.0.2.0/24"]
    resource_group_name   = var.rg-name
    virtual_network_name  = azurerm_virtual_network.vnet.name
  }
resource "azurerm_subnet_network_security_group_association" "web-host" {
    subnet_id                 = azurerm_subnet.subnet1.id
    network_security_group_id = var.nsg_id
}

output "subnet-id1" {
    value = azurerm_subnet.subnet1.id
}

output "subnet-id2" {
    value = azurerm_subnet.subnet2.id
}