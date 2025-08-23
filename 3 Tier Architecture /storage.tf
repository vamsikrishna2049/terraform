# Storage Account With Blob Storage Version Enabled

resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Enable Blob versioning 
  blob_properties {
    versioning_enabled = true # 👈 this enables versioning

    delete_retention_policy {
      days = 7 # keep deleted blobs for 7 days (soft delete)
    }

    container_delete_retention_policy {
      days = 7 # protect deleted containers for 7 days
    }
  }

  tags = {
    environment = var.tags
  }
}

resource "azurerm_storage_container" "tf_backend" {
  name                  = "tfstate" # just a clean name
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = "private"
}


