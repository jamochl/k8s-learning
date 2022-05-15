resource "kubernetes_namespace" "app" {
  metadata {
    name = "lovelace"
  }
}
