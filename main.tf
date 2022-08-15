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

variable "prefix" {
  default = "infra"
}

resource "azurerm_resource_group" "jenkins_rg" {
  name     = "${var.prefix}-resources"
  location = "East US"
}