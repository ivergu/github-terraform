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
    key                  = "website.terraform.tfstate"        
  }
  }


provider "azurerm" {
  subscription_id = "3291a0d9-96b5-41ee-9b93-5b28b419919f"
  features {}
 
}