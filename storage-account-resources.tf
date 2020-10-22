
resource "random_integer" "sa_num" {
  min = 10000
  max = 99999
}



resource "azurerm_storage_account" "sa" {
  #name                     = "${lower(var.name)}${random_integer.sa_num.result}"
  name                     = lower(var.name)
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
}

resource "azurerm_storage_container" "ct" {
  name                 = var.container_name
  storage_account_name = azurerm_storage_account.sa.name

}





