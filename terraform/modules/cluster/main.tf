resource "azurerm_resource_group" "aks-rg" {
    name     = var.name
    location = var.location
    tags     = var.tags
}

resource "azurerm_kubernetes_cluster" "aks-cluster-kj" {
  name                = "aks-cluster-kj"
  location            = azurerm_resource_group.aks-rg.location
  resource_group_name = azurerm_resource_group.aks-rg.name
  dns_prefix          = "aks-cluster-kj"
  kubernetes_version  = var.kube_version
  tags                = var.tags

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
    os_disk_size_gb = 100
  }

  identity {
    type = "SystemAssigned"
  }

  linux_profile {
    admin_username = "kamil"
    ssh_key {
      key_data = var.ssh_key
    }
  }

  network_profile {
    network_plugin = "kubenet"
    load_balancer_sku = "standard"
  }

  
}

