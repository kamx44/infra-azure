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


module "cluster" {
    source      = "./modules/cluster"
    name        = local.rg_name
    location    = var.location
    tags        = local.main_tags
    ssh_key     = var.ssh_public_key
}

module "k8s" {
    source                  = "./modules/k8s"
    host                    = "${module.cluster.host}"
    client_certificate      = "${base64decode(module.cluster.client_certificate)}"
    client_key              = "${base64decode(module.cluster.client_key)}"
    cluster_ca_certificate  = "${base64decode(module.cluster.cluster_ca_certificate)}"
}