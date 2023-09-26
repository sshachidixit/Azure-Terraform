#Business division
variable "Business_division" {
  description = "Business division of this infra"
  type        = string
  default     = "cis"

}

# Environment variable
variable "Environment" {
  description = "Environment of the infra"
  type        = string
  default     = "dev"

}

# Azure resource group name

variable "resource_group_name" {
  description = "Resource group name"
  default     = "default-rg"

}

# Azure resources location

variable "resource_group_location" {
  description = "Azure resource location"
  default     = "South India"

}