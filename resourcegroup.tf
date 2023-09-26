/*resource "azurerm_resource_group" "rg" {
    name = "myrg1"
    location = "South India"
  
}*/

resource "azurerm_resource_group" "rg" {
  #This naming covention can be used in real world
  #name     = "${local.resource_name_prefix}-${var.resource_group_name}" 
  # For Practice purpose as we will create the same kind of resource again and again ,we need to add
  # random varibales
  name     = "${local.resource_name_prefix}-${var.resource_group_name}-${random_string.myrandom.id}"
  location = var.resource_group_location
  tags     = local.comman_tags

}