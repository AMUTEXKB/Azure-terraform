terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.95.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}
resource "azurerm_resource_group" "amutex" {
  name     = "amutex-resources"
  location = "West US"
}

resource "azurerm_storage_account" "amutex" {
  name                     = "amutexkb1234567"
  resource_group_name      = azurerm_resource_group.amutex.name
  location                 = azurerm_resource_group.amutex.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
# Create a virtual network within the resource group
resource "azurerm_virtual_network" "amutex" {
  name                = "amutex-network"
  resource_group_name = azurerm_resource_group.amutex.name
  location            = azurerm_resource_group.amutex.location
  address_space       = ["10.0.0.0/16"]
}