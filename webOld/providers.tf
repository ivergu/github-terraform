terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "ergrstdg"  
    storage_account_name = "drgdrgdg34645634"                    
    container_name       = "tfstate"                     
    key                  = "web-demo.terraform.tfstate"        
  }
  }


provider "azurerm" {
  subscription_id = "3291a0d9-96b5-41ee-9b93-5b28b419919f"
  features {}
 
}