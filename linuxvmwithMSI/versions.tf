terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-storage-rg"
    storage_account_name = "tfazurestateshachi"
    container_name       = "tfstatefiles1"
    key                  = "terraform.tfstate1"

  }
}
provider "azurerm" {
  features {

  }
  use_msi         = true
  tenant_id       = "d51a45df-a9fe-47a4-9539-1b6eccf3427f"
  subscription_id = "aad557ae-0ca1-415d-8274-d6cd1301fe90"


}