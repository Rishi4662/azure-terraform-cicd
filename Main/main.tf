#This Module Is Used To Create Resource Group In Azure

module "resource-group" {
    source              = "../Resources/Resource-Group"
    name                = var.name
    resource-location   = var.resource-location
    Purpose             = var.Purpose
    Client              = var.Client
    Email               = var.Email
    Owner               = var.Owner  
}

# This Module Is Used To Create Network-Security Group In Azure

module "network-sg" {
    source              = "../Resources/Network-SG"
    name                = var.name
    resource-location   = var.resource-location
    rg-name             = module.resource-group.resource-group-name
    Purpose             = var.Purpose
    Client              = var.Client
    Email               = var.Email
    Owner               = var.Owner
  
}

# This Module Is Used To Create VNET and NSG In Azure

module "virtual-network" {
    source              = "../Resources/VNET"
    name                = var.name
    resource-location   = var.resource-location
    rg-name             = module.resource-group.resource-group-name
    Purpose             = var.Purpose
    Client              = var.Client
    Email               = var.Email
    Owner               = var.Owner
    nsg_id              = module.network-sg.nsg_id
  
}

# This Module Is Used To Create Virtual Machine In VM

module "virtual-machine" {
    source              = "../Resources/VM"
    size                = var.size
    name                = var.name
    resource-location   = var.resource-location
    rg-name             = module.resource-group.resource-group-name
    subnet-id           = module.virtual-network.subnet-id1
    username            = var.username
    Purpose             = var.Purpose
    Client              = var.Client
    Email               = var.Email
    Owner               = var.Owner
  
}

# This Module Is Used To Create MySQL Database

module "database" {
    source                  = "../Resources/MySql-DB"
    name                    = var.name
    rg-name                 = module.resource-group.resource-group-name
    resource-location       = var.resource-location
    db-version              = var.db-version
    admin_username          = var.admin_username
    storage_mb              = var.storage_mb
    Purpose                 = var.Purpose
    Client                  = var.Client
    Email                   = var.Email
    Owner                   = var.Owner
    db_name                 = var.db_name
    vm-ip                   = module.virtual-machine.vm_ip_address

    depends_on = [ module.virtual-machine ]
}


output "VM-Password" {
    value       = module.virtual-machine.password
    sensitive   = true
}

output "VM-IP" {
    value = module.virtual-machine.vm_ip_address
}

output "DB-Password" {
    value       = module.database.db-password
    sensitive   = true
}