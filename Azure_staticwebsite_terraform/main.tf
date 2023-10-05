resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}

resource "random_string" "myrandom" {
  length  = 6
  upper   = false
  special = false
  #number = false

}



resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.storage_account_name}${random_string.myrandom.id}"
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = var.account_tier
  account_kind             = var.account_kind
  account_replication_type = var.account_replication_type
  resource_group_name      = azurerm_resource_group.resource_group.name

  static_website {
    error_404_document = var.static_website_error_404_document
    index_document     = var.static_website_index_document
  }



}



