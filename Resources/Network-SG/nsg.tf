# To Ftch IP Address of Current Machine

data "http" "my_ip_address" {
  url = "https://api.ipify.org?format=text"
}

# To Crate Network Security Group

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.name}-NSG"
  location            = var.resource-location
  resource_group_name = var.rg-name

  tags = {
        Email    = var.Email
        Owner    = var.Owner
        Purpose  = var.Purpose
        Client   = var.Client
  }
}

resource "azurerm_network_security_rule" "http_inbound" {
  name                        = "http-inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg-name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "ssh_inbound" {
  name                        = "ssh-inbound"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = data.http.my_ip_address.response_body
  destination_address_prefix  = "*"
  resource_group_name         = var.rg-name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}





