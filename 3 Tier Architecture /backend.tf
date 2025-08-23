# Storage Account for backend
resource "azurerm_storage_account" "tf_backend" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "tf_backend" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tf_backend.id # <-- changed here
  container_access_type = "private"
}