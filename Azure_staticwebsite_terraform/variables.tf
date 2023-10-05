variable "resource_group_name" {
  description = "Add the name of the resource group"
  type        = string

}

variable "location" {
  description = "Add the name of the location"
  type        = string

}

variable "storage_account_name" {
  type        = string
  description = "Add storage account name"

}

variable "account_tier" {
  type        = string
  description = "Add access tier for storage account like Standard"

}

variable "account_kind" {
  type        = string
  description = "Add account kind like StorageV2 "

}

variable "account_replication_type" {
  type        = string
  description = "Add account_replication_type like LRS"

}

variable "static_website_index_document" {
  description = "static website index document"
  type        = string
}
variable "static_website_error_404_document" {
  description = "static website error 404 document"
  type        = string
}
