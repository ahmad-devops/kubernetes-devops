/*
resource "kubernetes_pod" "counter" {
  metadata {
    name = "counter"
  }

  spec {
    container {
      image = "busybox"
      name  = "counter"
      args = [/bin/sh, -c, 'i=0; while true; do echo "$i: $(date)"; i=$((i+1)); sleep 1; done']
    }
  }
}
*/