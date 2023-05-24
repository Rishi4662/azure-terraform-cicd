# To Create Random Password

resource "random_password" "password" {
  length           = 16
  lower            = true
  upper            = true
  numeric          = true
  special          = false
}

# To genrate random integer

resource "random_id" "number" {
  keepers = {
    first = "${timestamp()}"
  }
  byte_length = 2 
}

resource "azurerm_storage_account" "storage_account" {
  name                     = format("%s%s",lower("${var.name}storage"),random_id.number.hex)
  resource_group_name      = var.rg-name
  location                 = var.resource-location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# To Create MySQL Database

resource "azurerm_mysql_server" "my-db" {
    name                         = lower("${var.name}-MySQL-DB")
    resource_group_name          = var.rg-name
    location                     = var.resource-location
    version                      = var.db-version
    administrator_login          = var.admin_username
    administrator_login_password = random_password.password.result

    sku_name                          = "GP_Gen5_2"
    storage_mb                        = var.storage_mb
    ssl_enforcement_enabled           = false
    ssl_minimal_tls_version_enforced  = "TLSEnforcementDisabled"
    geo_redundant_backup_enabled      = true
    public_network_access_enabled     = true

    tags = {
        Email    = var.Email
        Owner    = var.Owner
        Purpose  = var.Purpose
        Client   = var.Client
  }
  
}

# To Create Database Inside MySQL Database Server

resource "azurerm_mysql_database" "db" {
  name                = var.db_name
  resource_group_name = var.rg-name
  server_name         = azurerm_mysql_server.my-db.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_firewall_rule" "VM-Whitelist" {
  name                = lower("${var.name}-VM-IP")
  resource_group_name = var.rg-name
  server_name         = azurerm_mysql_server.my-db.name
  start_ip_address    = var.vm-ip
  end_ip_address      = var.vm-ip
}

output "db-password" {
  value = azurerm_mysql_server.my-db.administrator_login_password
}