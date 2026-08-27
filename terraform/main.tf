terraform {
  required_providers {
    docker = {
        source = "kreuzwerker/docker"
        version = "~> 3.0"
    }
  }
}

provider "docker" {    
}

/*imagem do jenkins*/

resource "docker_image" "jenkins" {
  name = "jenkins/jenkins:lts"
}

/*Dados do jenkins*/

resource "docker_volume" "jenkins_home" {
  name = "jenkins_home"
}

resource "docker_container" "jenkins" {
  name = "jenkins"
  image = docker_image.jenkins.image_id

  ports {
    internal = 8080
    external = 8080
  }

  ports {
    internal = 5000
    external = 5000
  }

  volumes {
    volume_name = docker_volume.jenkins_home.name
    container_path = "/var/jenkins_home"
  }

}