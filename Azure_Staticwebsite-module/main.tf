module "azure_static_website" {
  source = "./module"
  #Resource group related
  location            = "eastus"
  resource_group_name = "myrg1"
  #Storage account related
  storage_account_name              = "staticwebsite"
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  account_kind                      = "StorageV2"
  static_website_index_document     = "index.html"
  static_website_error_404_document = "error.html"

}