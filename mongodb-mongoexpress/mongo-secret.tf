 resource "kubernetes_secret" "mongodb_secret" {
  metadata {
    name = "mongodb-secret"
  }

  data = {
    mongo-root-username = "dXNlcm5hbWU="
    mongo-root-password = "cGFzc3dvcmQ="
  }

  type = "opaque"
}