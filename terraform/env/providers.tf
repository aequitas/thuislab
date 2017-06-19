# configuration for common providers

/*variable "hydra_host" {
  default = "127.0.0.1"
}*/


/*variable "mysql_root_password" {
  default = "changeme"
}*/


/*variable "admin_user" {
  default = "admin"
}

variable "backup_password" {
  default = "changeme"
}*/

variable "pdns_server_url" {
  default = "http://172.17.0.3"
}

/*variable "pdns_api_key" {
  default = "changeme"
}

variable "postgres_password" {
  default = "geheim"
}*/


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
