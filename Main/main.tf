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


output "VM-Password" {
    value       = module.virtual-machine.password
    sensitive   = true
}

output "VM-IP" {
    value = module.virtual-machine.vm_ip_address
}