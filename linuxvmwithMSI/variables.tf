variable "rg_name" {
  type    = string
  default = "default-rg"

}

variable "location" {
  type    = string
  default = "South India"

}

variable "vnet_name" {
  type    = string
  default = "default_vnet"

}


variable "linuxvm_name" {
  type    = string
  default = "firstlinuxvm"
}

variable "admin_username" {
  type    = string
  default = "azureuser"

}

variable "size" {
  type    = string
  default = "Standard_DS1_V2"

}
