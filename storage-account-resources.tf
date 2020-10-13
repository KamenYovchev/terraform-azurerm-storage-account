
provider "azurerm" {

  version = "=2.28.0"
  features {}

}

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
  name                 = "terraform-states"
  storage_account_name = azurerm_storage_account.sa.name

}

data "azurerm_storage_account_sas" "state" {
  connection_string = azurerm_storage_account.sa.primary_connection_string
  https_only        = true

  resource_types {
    service   = true
    container = true
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = timestamp()
  expiry = timeadd(timestamp(), "17520h")

  permissions {
    read    = true
    write   = true
    delete  = true
    list    = true
    add     = true
    create  = true
    update  = false
    process = false
  }
}

#############################################################################
# PROVISIONERS
#############################################################################

resource "null_resource" "post-config" {

  depends_on = [azurerm_storage_container.ct]

  provisioner "local-exec" {
    command = <<EOT
echo 'storage_account_name = "${azurerm_storage_account.sa.name}"' >> backend-config.txt
echo 'container_name = "terraform-state"' >> backend-config.txt
echo 'key = "devops.tfstate"' >> backend-config.txt
echo 'sas_token = "${data.azurerm_storage_account_sas.state.sas}"' >> backend-config.txt
EOT
  }
}

