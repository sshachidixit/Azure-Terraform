#Resource 1:
# create subnet for app tier
resource "azurerm_subnet" "appsubnet" {
  name                 = "${azurerm_virtual_network.myvnet.name}-${var.app_subnet_name}"
  address_prefixes     = var.app_subnet_address
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name

}
#Resource 2:
# Create NSG for app tier

resource "azurerm_network_security_group" "app_subnet_nsg" {
  name                = "${azurerm_subnet.appsubnet.name}-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

}
#Resource 3: 
#Create app subnet and NSG association

resource "azurerm_subnet_network_security_group_association" "app_subnet_nsg_associate" {
  # Put depends on meta argument after creating nsg rules 
  subnet_id                 = azurerm_subnet.appsubnet.id
  network_security_group_id = azurerm_network_security_group.app_subnet_nsg.id

}
# Resource 4 : create NSG Rules
# locals for port nsg rules []
locals {
  app_inbound_ports_map = {
    "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
    "110" : "443",
    "120" : "8080",
    "130" : "22"
  }
}

resource "azurerm_network_security_rule" "app_nsg_rule_inbound" {
  for_each                    = local.app_inbound_ports_map
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.app_subnet_nsg.name
}
