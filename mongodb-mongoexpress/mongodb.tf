
resource "kubernetes_deployment" "mongodb" {
  metadata {
    name = "terraform-mongodb"
    labels = {
      app = "MymongodbApp"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "MymongodbApp"
      }
    }

    template {
      metadata {
        labels = {
          app = "MymongodbApp"
        }
      }

      spec {
        container {
          image = "mongo"
          name  = "mongodb"
          port {
            container_port = 27017
          }

          env {
            name = "MONGO_INITDB_ROOT_USERNAME"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mongodb_secret.metadata[0].name
                key = "mongo-root-username"
              }
            }
          }
          env {
            name = "MONGO_INITDB_ROOT_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mongodb_secret.metadata[0].name
                key = "mongo-root-password"
              }
            }
          }          

          }
        }
      }
    }
  }



resource "kubernetes_service" "mongodb-service" {
  metadata {
    name = "mongodb-service"
  }
  spec {
    selector = {
      app = kubernetes_deployment.mongodb.spec.0.template.0.metadata[0].labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 27017
      target_port = 27017
    }
  }
}
