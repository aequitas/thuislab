# concourse worker
resource "docker_container" "concourse-worker" {
  image   = "${docker_image.concourse.latest}"
  name    = "concourse-worker"
  restart = "always"

  privileged = true
  command    = ["worker"]

  env = [
    "CONCOURSE_TSA_HOST=concourse-web",
  ]

  upload {
    content = "${file("${path.module}/../../src/secrets/ci/keys/web/tsa_host_key.pub")}"
    file    = "/concourse-keys/tsa_host_key.pub"
  }

  upload {
    content = "${file("${path.module}/../../src/secrets/ci/keys/worker/worker_key")}"
    file    = "/concourse-keys/worker_key"
  }

  volumes {
    container_path = "/worker-state/"
    host_path      = "/srv/consourse/worker/state/"
  }

  networks = [
    "concourse",
  ]

  depends_on = ["docker_container.concourse-db"]
}
