provider "kubernetes" {
  host                   = var.host
  client_certificate     = var.client_certificate
  client_key             = var.client_key
  cluster_ca_certificate = var.cluster_ca_certificate
}


resource "kubernetes_deployment" "myapp" {
  metadata {
    name = "myapp"
    labels = {
      app = "myapp"
    }
  }

  spec {
    replicas = 1
    progress_deadline_seconds = 600
    revision_history_limit = 10

    selector {
      match_labels = {
        app = "myapp"
      }
    }

    strategy {
      rolling_update {
        max_surge = 25
        max_unavailable = 25
      }
      type = "RollingUpdate"
    }

    template {
      metadata {
        labels = {
          app = "myapp"
        }
      }

      spec {
        container {
          image = "manojnair/myapp:v1"
          name  = "myapp"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          
          }
        }
      }
    }
}

resource "kubernetes_service" "myapp-lb" {
  metadata {
    name = "myapp-lb"
  }
  spec {
    selector = {
      app = "myapp"
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}  