terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "kubernetes" {
  #host = "https://192.168.49.2:8443"
  #config_context_cluster   = "minikube"
  #insecure = true
  config_path    = "~/.kube/config"
}