resource "kubernetes_secret" "mongodb_secret" {
  metadata {
    name = "mongodb-secret"
  }

  data = {
    MONGO_INITDB_ROOT_USERNAME = "dXNlcm5hbWU="
    MONGO_INITDB_ROOT_PASSWORD = "cGFzc3dvcmQ="
  }

  type = "opaque"
}