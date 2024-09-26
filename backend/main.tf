terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.3.0"
    }
  }

  }


provider "azurerm" {
  #subscription_id = "3291a0d9-96b5-41ee-9b93-5b28b419919f" 
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
 
}

resource "random_string" "random_string" {
  length  = 6
  special = false
  upper   = false

}

resource "azurerm_resource_group" "rg_backend" {
  name     = var.rg_backend_name
  location = var.rg_backend_location
}

resource "azurerm_storage_account" "sa_backend" {
  name                     = "sgdthrh"
  resource_group_name      = azurerm_resource_group.rg_backend.name 
  location                 = azurerm_resource_group.rg_backend.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_container" "container1" {
  name                  = var.sc_backend_name
  storage_account_name  = azurerm_storage_account.sa_backend.name 
  container_access_type = "private"
}




data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "kv_backend" {
  name                        =  "${lower(var.kv_backend_name)}${random_string.random_string.result}"
  location                    = azurerm_resource_group.rg_backend.location
  resource_group_name         = azurerm_resource_group.rg_backend.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id


     tenant_id = "b60533c6-2f92-498c-bf7a-eb814d42c71f"
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "List", "Create", "Delete", "Get", "Purge", "Recover", "Update", "GetRotationPolicy", "SetRotationPolicy"
    ]   

    secret_permissions = [
      "Get","Set","List","Delete","Recover","Purge",
    ]

    storage_permissions = [
      "Get","Set","List","Delete","Purge",
    ]
  }
}

resource "azurerm_key_vault_secret" "sa_backend_accessKey" {
  name         = var.sa_backend_accesskey_name
  value        = azurerm_storage_account.sa_backend.primary_access_key
  key_vault_id = azurerm_key_vault.kv_backend.id 
}
