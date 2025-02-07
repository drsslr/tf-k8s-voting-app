resource "kubernetes_deployment" "result" {
  timeouts {
    create = "2m"
    update = "2m"
    delete = "2m"
  }

  metadata {
    name = "deploy-result"
    labels = {
      name = "pod-result"
      app  = var.app
    }
    namespace = var.app
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "pod-result"
      }
    }
    template {
      metadata {
        labels = {
          name = "pod-result"
        }
      }
      spec {
        container {
          image = "dockersamples/examplevotingapp_result"
          name  = "result"
          port {
            container_port = 80
            name           = "redis"
          }
          resources {
            limits = {
              cpu    = var.limit_cpu
              memory = var.limit_mem
            }
            requests = {
              cpu    = var.request_cpu
              memory = var.request_mem
            }
          }
          liveness_probe {
            http_get {
              path = "/"
              port = 80
              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }
            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}