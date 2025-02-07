resource "kubernetes_service" "redis" {
  metadata {
    name = "svc-redis"
    labels = {
      app = var.app
    }
    namespace = var.app
  }
  spec {
    selector = {
      name = kubernetes_deployment.redis.metadata[0].labels.name
    }
    port {
      port        = 6379
      target_port = 6379
    }
    type = "ClusterIP"
  }
}