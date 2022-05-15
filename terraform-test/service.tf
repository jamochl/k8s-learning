resource "kubernetes_service_v1" "http" {
  metadata {
    name      = "nginx-service"
    namespace = kubernetes_namespace.app.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.nginx.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port = 80
      // name = kubernetes_deployment_v1.nginx.spec.0.port.0.name
      target_port = kubernetes_deployment_v1.nginx.spec.0.template.0.spec.0.container.0.port.0.container_port
    }

    // type = "ClusterIP"
    type = "NodePort"
  }
}

resource "kubernetes_service_v1" "http2" {
  metadata {
    name      = "nginx-service-2"
    namespace = kubernetes_namespace.app.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_pod_v1.nginx.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port = 80
      // name = kubernetes_deployment_v1.nginx.spec.0.port.0.name
      target_port = kubernetes_pod_v1.nginx.spec.0.container.0.port.0.container_port
    }

    // type = "ClusterIP"
    type = "NodePort"
  }
}
