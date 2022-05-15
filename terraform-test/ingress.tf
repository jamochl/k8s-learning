resource "kubernetes_ingress_v1" "nginx_ingress" {
  metadata {
    name      = "nginx-ingress"
    namespace = kubernetes_namespace.app.metadata.0.name
  }

  spec {
    default_backend {
      service {
        name = kubernetes_service_v1.http.metadata.0.name
        port {
          number = 80
        }
      }
    }
    // ingress_class_name = "nginx"
    rule {
      http {
        // path {
        //   path = "/app1/*"
        //   backend {
        //     service {
        //       name = kubernetes_service_v1.http.metadata.0.name
        //       port {
        //         number = 80
        //       }
        //     }
        //   }
        // }
        path {
          path = "/"
          backend {
            service {
              name = kubernetes_service_v1.http2.metadata.0.name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
