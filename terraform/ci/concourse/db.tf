# postgres database
resource "docker_container" "concourse-db" {
  image   = "${docker_image.postgres.latest}"
  name    = "concourse-db"
  restart = "always"

  env = [
    "POSTGRES_DB=concourse",
    "POSTGRES_USER=concourse",
    "POSTGRES_PASSWORD=changeme",
  ]

  volumes {
    container_path = "/var/lib/postgresql/data/"
    host_path      = "/srv/concourse/postgres/"
  }

  upload {
    content = "host    all             all             172.16.0.0/12            trust"
    file    = "/var/lib/postgresql/data/pg_hba.conf"
  }

  networks = [
    "concourse_db",
  ]
}

resource "docker_image" "postgres" {
  name = "postgres:latest"
}

resource "docker_network" "concourse_db" {
  name     = "concourse_db"
  internal = true
}
