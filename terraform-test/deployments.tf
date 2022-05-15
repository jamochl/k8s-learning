resource "kubernetes_deployment_v1" "nginx" {
  metadata {
    name      = "nginx-lovelace"
    namespace = kubernetes_namespace.app.metadata.0.name
    labels = {
      app = "nginx-lovelace"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx-lovelace"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx-lovelace"
        }
        namespace = kubernetes_namespace.app.metadata.0.name
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "nginx-lovelace"

          port {
            name           = "http"
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
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

resource "kubernetes_pod_v1" "nginx" {
  metadata {
    name      = "nginx-lovelace-2"
    namespace = kubernetes_namespace.app.metadata.0.name
    labels = {
      app = "nginx-lovelace-2"
    }
  }

  spec {
    container {
      image = "nginx:latest"
      name  = "nginx"

      port {
        name           = "http"
        container_port = 80
      }

      resources {
        limits = {
          cpu    = "0.5"
          memory = "512Mi"
        }
        requests = {
          cpu    = "250m"
          memory = "50Mi"
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
