
output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "primary_connection_string" {
    value = azurerm_storage_account.sa.primary_connection_string
}

output "storage_account_endpoint" {
  value =  azurerm_storage_account.sa.primary_blob_endpoint
}

output "storage_account_access_key" {
  value = azurerm_storage_account.sa.primary_access_key
}

output "storage_account_id" {
  value = azurerm_storage_account.sa.id
}