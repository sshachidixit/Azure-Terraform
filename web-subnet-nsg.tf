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
  depends_on                = [azurerm_network_security_rule.web_nsg_rule_inbound]
  subnet_id                 = azurerm_subnet.websubnet.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id

}
# Create a local for adding 3 inbounds ports with For_each [80 , 22 , 443]
locals {
  web_inbound_ports_map = {
    "100" : "80"
    "110" : "443"
    "120" : "22"

  }
}

resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
  for_each                    = local.web_inbound_ports_map
  name                        = "Rule-port-${each.value}"
  priority                    = each.key
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name

}