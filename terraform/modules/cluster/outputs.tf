output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks-cluster-kj.kube_config.0.client_certificate
  sensitive = true
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.aks-cluster-kj.kube_config.0.client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.aks-cluster-kj.kube_config.0.cluster_ca_certificate
  sensitive = true
}

output "host" {
  value     = azurerm_kubernetes_cluster.aks-cluster-kj.kube_config.0.host
  sensitive = true
}


output "cluster_id" {
  value     = azurerm_kubernetes_cluster.aks-cluster-kj.id
}