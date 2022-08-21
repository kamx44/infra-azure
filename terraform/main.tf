terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.18.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstatesRG"
    storage_account_name = "tfstateskamiljakubik1479"
    container_name       = "tfstateinfra"
    key                  = "terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

locals {
    rg_name = "${var.rg_prefix_name}-${var.environment}"
    main_tags = {"environment" = "${var.environment}"}
}


module "azurerm_resource_group" {
    source      = "./modules/resource_group"
    name        = local.rg_name
    location    = var.location
    tags        = local.main_tags
}