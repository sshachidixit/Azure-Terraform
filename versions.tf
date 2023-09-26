terraform {
  required_providers {
    /*azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.12"
    }*/
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

provider "random" {
  # Configuration options
}