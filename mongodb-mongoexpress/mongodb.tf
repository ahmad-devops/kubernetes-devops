resource "kubernetes_deployment" "mongodb" {
  metadata {
    name = "terraform-mongodb"
    labels = {
      test = "MymongodbApp"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "MymongodbApp"
      }
    }

    template {
      metadata {
        labels = {
          test = "MymongodbApp"
        }
      }

      spec {
        container {
          image = "mongodb"
          name  = "mongodb"
          port {
            container_port = 27017
          }

        env_from {
          secret_ref {
              name = kubernetes_secret.mongodb_secret.metadata.0.name
          }
        }
          }
        }
      }
    }
  }
