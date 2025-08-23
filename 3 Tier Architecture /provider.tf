terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}