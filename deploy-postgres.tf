resource "kubernetes_deployment" "postgres" {
  timeouts {
    create = "2m"
    update = "2m"
    delete = "2m"
  }

  metadata {
    name = "deploy-postgres"
    labels = {
      name = "pod-postgres"
      app  = var.app
    }
    namespace = var.app
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "pod-postgres"
      }
    }
    template {
      metadata {
        labels = {
          name = "pod-postgres"
        }
      }
      spec {
        container {
          image = "postgres:17-alpine"
          name  = "postgres"
          port {
            container_port = 5432
            name           = "postgres"
          }
          volume_mount {
            mount_path = "/db-data"
            name       = "postgres"
          }
          env {
            name  = "POSTGRES_USER"
            value = "psql_usr"
          }
          env {
            name  = "POSTGRES_PASSWORD"
            value = "psql_pwd"
          }
          env {
            name  = "POSTGRES_HOST_AUTH_METHOD"
            value = "trust"
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
          name = "postgres"
          empty_dir {}
        }
      }
    }
  }
}