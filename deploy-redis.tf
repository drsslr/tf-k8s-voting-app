resource "kubernetes_deployment" "redis" {
  timeouts {
    create = "2m"
    update = "2m"
    delete = "2m"
  }

  metadata {
    name = "deploy-redis"
    labels = {
      name = "pod-redis"
      app  = var.app
    }
    namespace = var.app
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "pod-redis"
      }
    }
    template {
      metadata {
        labels = {
          name = "pod-redis"
        }
      }
      spec {
        container {
          image = "redis:alpine"
          name  = "redis"
          port {
            container_port = 6379
            name           = "redis"
          }
          volume_mount {
            mount_path = "/data"
            name       = "redis"
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
        }
        volume {
          name = "redis"
          empty_dir {}
        }
      }
    }
  }
}