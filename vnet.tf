/*resource "azurerm_virtual_network" "myvnet" {
    address_space = [ "10.0.0.0/16" ]
    name = "myvnet-1"
    location = "South India"
  
}*/

#variablize the vnet creation
resource "azurerm_virtual_network" "myvnet" {
  name                = "${local.resource_name_prefix}-${var.vnet_name}"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.comman_tags

}