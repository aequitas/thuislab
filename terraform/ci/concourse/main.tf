# shared resources
resource "docker_image" "concourse" {
  name = "concourse/concourse:latest"
}

resource "docker_network" "concourse" {
  name     = "concourse"
  internal = true
}
