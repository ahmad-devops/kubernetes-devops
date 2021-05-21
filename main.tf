terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.11.0"
    }
  }
}

provider "docker" {
   host = "tcp://127.0.0.1:2375/"
}


resource "docker_container" "hello_from_terraform" {
  image = "webserver:latest"
  name  = "hello_from_terraform"
  restart = "always"
  volumes {
    container_path  = "/usr/share/nginx/html"
    # replace the host_path with full path for your project directory starting from root directory /
    host_path = "/Z/devops" 
    read_only = false
  }
  ports {
    internal = 80
    external = 8080
  }
}