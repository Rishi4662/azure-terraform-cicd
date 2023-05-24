# To Create Resource Group

resource "azurerm_resource_group" "rg" {
    name        = "${var.name}-Training-RG"
    location    = var.resource-location
    tags        = {
        Email    = var.Email
        Owner    = var.Owner
        Purpose  = var.Purpose
        Client   = var.Client
    }
}

output "resource-group-name" {
    value = azurerm_resource_group.rg.name
}