resource "kubernetes_deployment" "worker" {
  timeouts {
    create = "2m"
    update = "2m"
    delete = "2m"
  }

  metadata {
    name = "deploy-worker"
    labels = {
      name = "pod-worker"
      app  = var.app
    }
    namespace = var.app
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "pod-worker"
      }
    }
    template {
      metadata {
        labels = {
          name = "pod-worker"
        }
      }
      spec {
        container {
          image = "dockersamples/examplevotingapp_worker"
          name  = "worker"
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
      }
    }
  }
}