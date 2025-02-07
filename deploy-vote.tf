resource "kubernetes_deployment" "vote" {
  timeouts {
    create = "2m"
    update = "2m"
    delete = "2m"
  }
  metadata {
    name = "deploy-vote"
    labels = {
      name = "pod-vote"
      app  = var.app
    }
    namespace = var.app
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "pod-vote"
      }
    }
    template {
      metadata {
        labels = {
          name = "pod-vote"
        }
      }
      spec {
        container {
          image = "dockersamples/examplevotingapp_vote"
          name  = "vote"
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