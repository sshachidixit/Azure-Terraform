# Adding local values in Azure 

locals {
  owners      = var.Business_division
  Environment = var.Environment
  #Append the two values
  resource_name_prefix = "${var.Business_division}-${var.Environment}"
  comman_tags = {
    owners      = local.owners
    Environment = local.Environment
  }
}