terraform {
  required_providers {
    /*azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.12"
    }*/
  }
  /*backend "azurerm" {
    resource_group_name = "terraform-storage-rg"
    storage_account_name = "tfazurestateshachi"
    container_name = "tfstatefiles"
    key = "terraform.tfstate"
    
  }*/
}

provider "azurerm" {
  # Configuration options
  features {}
}

provider "random" {
  # Configuration options
}