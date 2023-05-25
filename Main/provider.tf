#Terraform Provider Block

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.7.0"
    }
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "Rishi-Learning"
    storage_account_name = "terraformstatefiless"
    container_name       = "terraform-sf"
    key                  = "terraform.tfstate"
  }
}


# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
