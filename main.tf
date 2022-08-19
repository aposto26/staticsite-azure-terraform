# Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }
}

#Azure provider
provider "azurerm" {
  features {}
}

#Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = "staticsiterg"
  location = "australiaeast"
}

#Create the storage account
#Note: The name for the storage accoount will need to be unique otherwise the deployment will fail. 
resource "azurerm_storage_account" "sa" {

  name                     = "staticsite52345"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  #The file that the landing page will be read from.
  static_website {
    index_document = "index.html"
  }
}

#Set a local value for both the index folder & the mime.json file. 
#These can now be called multiple times without repetition.
locals {
  web_files  = fileset("./index/", "*")
  mime_types = jsondecode(file("mime.json"))
}

#Create the $web container which will store all files for the landing page in the storage account
#Note: This container resides within the storage account on the Azure portal. 
resource "azurerm_storage_blob" "blobcontainer" {
  for_each = local.web_files

  name                      = each.key
  storage_account_name      = azurerm_storage_account.sa.name
  storage_container_name    = "$web"
  type                      = "Block"
  content_type              = lookup(local.mime_types, regex("\\.[^.]+$", each.key), null)
  source                    = "./index/${each.key}"
}




