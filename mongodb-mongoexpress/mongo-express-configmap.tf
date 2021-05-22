resource "kubernetes_config_map" "mongo-express-configmap" {
  metadata {
    name = "mongo-express-configmap"
  }

  data = {
    database_url: kubernetes_service.mongodb-service.metadata[0].name
  }
}