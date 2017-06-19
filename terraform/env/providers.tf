# configuration for common providers

provider "mysql" {
  endpoint = "${var.hydra_host}:3306"
  username = "root"
  password = "${var.mysql_root_password}"
}

provider "powerdns" {
  api_key    = "${var.pdns_api_key}"
  server_url = "${var.pdns_server_url}"
}

provider "docker" {
  host = "tcp://${var.hydra_host}:2375/"
}

provider "postgresql" {
  host     = "${var.hydra_host}"
  port     = 5432
  username = "postgres"
  password = "${var.postgres_password}"
}
