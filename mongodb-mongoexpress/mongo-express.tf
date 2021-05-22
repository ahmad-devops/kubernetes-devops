
resource "kubernetes_deployment" "mongo-express" {
  metadata {
    name = "terraform-mongo-express"
    labels = {
      app = "mongo-express"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "mongo-express"
      }
    }

    template {
      metadata {
        labels = {
          app = "mongo-express"
        }
      }

      spec {
        container {
          image = "mongo-express"
          name  = "mongo-express"
          port {
            container_port = 8081
          }

          env {
            name = "ME_CONFIG_MONGODB_ADMINUSERNAME"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mongodb_secret.metadata[0].name
                key = "mongo-root-username"
              }
            }
          }
          env {
            name = "ME_CONFIG_MONGODB_ADMINPASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mongodb_secret.metadata[0].name
                key = "mongo-root-password"
              }
            }
          }          
          env {
            name = "ME_CONFIG_MONGODB_SERVER"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.mongo-express-configmap.metadata[0].name
                key = "database_url"
              }
            }
          }  
          }
        }
      }
    }
  }



resource "kubernetes_service" "mongo-express-service" {
  metadata {
    name = "mongo-express-service"
  }
  spec {
    selector = {
      app = kubernetes_deployment.mongo-express.spec.0.template.0.metadata[0].labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 8081
      target_port = 8081
      node_port = 30201
    }
    type = "LoadBalancer"
  }
}
