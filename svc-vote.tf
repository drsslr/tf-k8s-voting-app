resource "kubernetes_service" "vote" {
  metadata {
    name = "svc-vote"
    labels = {
      app = var.app
    }
    namespace = var.app
  }
  spec {
    selector = {
      name = kubernetes_deployment.vote.metadata[0].labels.name
    }
    port {
      port        = 8080
      target_port = 80
      node_port   = 31000
    }
    type = "NodePort"
  }
}