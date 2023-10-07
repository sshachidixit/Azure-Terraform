#Resource-1
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location

}

# Resource-2
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location


}

# Resource - 3
resource "azurerm_subnet" "subnet" {
  name                 = "linuxvmsubnet"
  address_prefixes     = ["10.0.0.0/24"]
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name

}

#Resource - 4
resource "azurerm_public_ip" "publicip" {
  name                = "linuxvm_publicip"
  allocation_method   = "Dynamic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location


}

#Resource - 5
resource "azurerm_network_interface" "nic" {
  name                = "linuxvm_nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "ip1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
    subnet_id                     = azurerm_subnet.subnet.id

  }

}

# Resource - 6

resource "azurerm_linux_virtual_machine" "linuxvm1" {
  name                  = var.linuxvm_name
  admin_username        = var.admin_username
  location              = azurerm_resource_group.rg.location
  network_interface_ids = [azurerm_network_interface.nic.id]
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = var.size
  source_image_reference {
    publisher = "redhat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }
  /*
    admin_ssh_key {
        username = var.admin_username
        public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
    }
    */

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  identity {
    type = "SystemAssigned"
  }

}

data "azurerm_subscription" "current" {}

data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}

resource "azurerm_role_assignment" "example" {
  scope              = data.azurerm_subscription.current.id
  role_definition_id = "${data.azurerm_subscription.current.id}${data.azurerm_role_definition.contributor.id}"
  principal_id       = azurerm_linux_virtual_machine.linuxvm1.id
}