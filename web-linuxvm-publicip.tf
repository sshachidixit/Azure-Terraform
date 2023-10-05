# Creating public ip for the linux VM in web subnet
resource "azurerm_public_ip" "web_linuxvm_publicip" {
  name                = "${local.resource_name_prefix}-web-linuxvm-publicip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "standard"
  domain_name_label   = "app1-vm-${random_string.myrandom.id}"


}
  