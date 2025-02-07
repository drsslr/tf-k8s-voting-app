resource "kubernetes_service" "result" {
  metadata {
    name = "svc-result"
    labels = {
      app = var.app
    }
    namespace = var.app
  }
  spec {
    selector = {
      name = kubernetes_deployment.result.metadata[0].labels.name
    }
    port {
      port        = 8081
      target_port = 80
      node_port   = 31001
    }
    type = "NodePort"
  }
}