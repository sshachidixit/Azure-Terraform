# Create subnet for web tier
resource "azurerm_subnet" "websubnet" {
  name                 = "${azurerm_virtual_network.myvnet.name}-${var.web_subnet_name}"
  address_prefixes     = var.web_subnet_address
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name

}

# Create a Network security group (NSG)
resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                = "${azurerm_subnet.websubnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name


}

# Associate NSG and web subnet

resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.websubnet.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id

}