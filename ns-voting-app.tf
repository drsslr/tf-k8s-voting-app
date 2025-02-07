resource "kubernetes_namespace" "this" {
  metadata {
    name = "voting-app"
  }
}
