resource "kubernetes_service" "postgres" {
  metadata {
    name = "svc-postgres"
    labels = {
      app = var.app
    }
    namespace = var.app
  }
  spec {
    selector = {
      name = kubernetes_deployment.postgres.metadata[0].labels.name
    }
    port {
      port        = 5432
      target_port = 5432
    }
    type = "ClusterIP"
  }
}