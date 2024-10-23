terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.3.0"
    }
  }

   backend "azurerm" {
    resource_group_name  = "rg-backend-1"  
    storage_account_name = "storageacusk370"                    
    container_name       = "tfstate"                     
    key                  = "infra.terraform.tfstate"        
  }
  }


provider "azurerm" {
  subscription_id = "3291a0d9-96b5-41ee-9b93-5b28b419919f"
  features {}
 
}



locals {
  workspace_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  rg_name = terraform.workspace == "default" ? "${var.rg_name}" : "${var.rg_name}-${local.workspace_suffix}"
  sa_name = terraform.workspace == "default" ? "${var.sa_name}" : "${var.sa_name}-${local.workspace_suffix}"
  web_suffix = "<h1>${terraform.workspace}</h1>"

}

resource "random_string" "random_string" {
  length  = 6
  special = false
  upper   = false

}  
 
resource "azurerm_resource_group" "rg_web" {
  name     = local.rg_name
  location = var.rg_location
} 
 
resource "azurerm_storage_account" "sa_web" {
  name                     = "${lower(var.sa_name)}${random_string.random_string.result}"
  resource_group_name      = azurerm_resource_group.rg_web.name 
  location                 = azurerm_resource_group.rg_web.location
  account_tier             = "Standard"
  account_replication_type = "GRS"  

    static_website {
      index_document = var.index_document
    }
}

resource "azurerm_storage_blob" "index_html" {
  name = "index.html"
  storage_account_name = azurerm_storage_account.sa_web.name
  storage_container_name = "$web"
  type = "Block"
  content_type = "text/html"
  source_content = "${var.source_content}${local.web_suffix}"
  content_md5 = md5("${var.source_content}${local.web_suffix}")
  
}
   
output "innhold" {
  value = "${var.source_content}${local.web_suffix}"
}

output "primary_web_endpoint" {
  value = azurerm_storage_account.sa_web.primary_web_endpoint
}


















/*
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
   backend "azurerm" {
    resource_group_name  = "rg-backend-1"  
    storage_account_name = "storageacusk370"                    
    container_name       = "tfstate"                     
    key                  = "infra.terraform.tfstate"        
  }
}

provider "azurerm" {
  subscription_id = "683886f5-1985-4666-a868-6e00a44de5bd"

  features {
    /*key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

provider "random" {

}

resource "random_string" "random_string" {
  length  = 6
  special = false
  upper   = false

}


resource "azurerm_resource_group" "element" {
  name     = "${lower(var.base_name)}${random_string.random_string.result}-rg"
  location = var.location
}



resource "azurerm_storage_account" "sa_backend" {
  name                     = "${lower(var.sa_backend_name)}${random_string.random_string.result}"
  resource_group_name      = azurerm_resource_group.client.name 
  location                 = azurerm_resource_group.client.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_container" "container1" {
  name                  = var.sc_backend_name
  storage_account_name  = azurerm_storage_account.sa_backend.name 
  container_access_type = "private"
}


module "Network" {
  source    = "./Network"
  base_name = "Network"
  rgname    = azurerm_resource_group.element.name
  location  = azurerm_resource_group.element.location
  sec_group = var.sec_group

}

module "BlobStorage" {
  source         = "./BlobStorage"
  base_name      = "Storage"
  rgname         = azurerm_resource_group.element.name
  location       = azurerm_resource_group.element.location
  id             = module.KeyVault.id
  accessKey_name = var.accessKey_name
  account_tier   = var.account_tier
  AR_type        = var.AR_type
}

module "ServicePlan" {
  source         = "./ServicePlan" 
  base_name      = "ServicePlan" 
  rgname         = azurerm_resource_group.element.name
  location       = azurerm_resource_group.element.location
  id             = module.KeyVault.id
  accessKey_name = var.accessKey_name
  account_tier   = var.account_tier
  AR_type        = var.AR_type
}

module "Database" {
  source         = "./Database"
  base_name      = "VM" 
  rgname         = azurerm_resource_group.element.name
  location       = azurerm_resource_group.element.location
  id             = module.VirtualMachine.VMid
  admin_username = module.KeyVault.vm_user
  admin_password = module.KeyVault.vm_pass
  vm_user        = module.KeyVault.vm_user
  vm_pass        = module.KeyVault.vm_pass
  subnet         = module.Network.subnetID
}

module "LoadBalancer" {
  source             = "./LoadBalancer"
  base_name          = "KeyVault"
  rgname             = azurerm_resource_group.element.name
  location           = azurerm_resource_group.element.location
  primary_access_key = module.StorageAccount.primarykey
  sku_name           = var.sku_name
  keyvaultname       = var.keyvaultname
  username           = var.admin_username
  pass               = var.admin_password
  vm_user            = var.vm_user
  vm_pass            = var.vm_pass


}

#Testing 
output "said1" {
  value = module.StorageAccount.storageName

  sensitive = true
}

output "said2" {
  value = module.Network.networkGroup

  sensitive = true
}

output "primarykey" {
  value     = module.StorageAccount.primarykey
  sensitive = true
}


*/