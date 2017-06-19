# concourse web frontend, tls termination and DNS.
resource "docker_container" "concourse-web" {
  image   = "${docker_image.concourse.latest}"
  name    = "concourse-web"
  restart = "always"

  command = ["web"]

  env = [
    "CONCOURSE_BASIC_AUTH_USERNAME=concourse",
    "CONCOURSE_BASIC_AUTH_PASSWORD=concourse",
    "CONCOURSE_EXTERNAL_URL=https://concourse.thuislab.ijohan.nl",
    "CONCOURSE_POSTGRES_HOST=concourse-db",
    "CONCOURSE_POSTGRES_USER=concourse",
    "CONCOURSE_POSTGRES_PASSWORD=${var.postgres_password}",
    "CONCOURSE_POSTGRES_DATABASE=concourse",
  ]

  upload {
    content = "${file("${path.module}/../../src/secrets/ci/keys/web/authorized_worker_keys")}"
    file    = "/concourse-keys/authorized_worker_keys"
  }

  upload {
    content = "${file("${path.module}/../../src/secrets/ci/keys/web/tsa_host_key")}"
    file    = "/concourse-keys/tsa_host_key"
  }

  upload {
    content = "${file("${path.module}/../../src/secrets/ci/keys/web/session_signing_key")}"
    file    = "/concourse-keys/session_signing_key"
  }

  networks = [
    "concourse",
    "concourse_db",
  ]

  depends_on = ["docker_container.concourse-db"]
}

resource "tls_private_key" "concourse" {
  algorithm = "RSA"
}

resource "tls_cert_request" "concourse" {
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.concourse.private_key_pem}"

  dns_names = [
    "concourse.thuislab.ijohan.nl",
    "concourse",
    "concourse.thuislab",
  ]

  subject {
    common_name         = "concourse.thuislab.ijohan.nl"
    organization        = "ijohan.nl"
    organizational_unit = "N/A"
    street_address      = ["N/A"]
    locality            = "N/A"
    province            = "N/A"
    country             = "N/A"
    postal_code         = "N/A"
    serial_number       = "N/A"
  }
}

resource "tls_locally_signed_cert" "concourse" {
  cert_request_pem   = "${tls_cert_request.concourse.cert_request_pem}"
  ca_key_algorithm   = "RSA"
  ca_private_key_pem = "${file("${var.ca_keyfile}")}"
  ca_cert_pem        = "${file("${var.ca_certfile}")}"

  validity_period_hours = 42000

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "powerdns_record" "concourse" {
  zone    = "thuislab.ijohan.nl"
  name    = "concourse.thuislab.ijohan.nl."
  type    = "A"
  ttl     = 300
  records = ["${docker_container.concourse-ssl.ip_address}"]
}

resource "docker_container" "concourse-ssl" {
  image   = "${data.terraform_remote_state.infra.docker_ssl_proxy_latest}"
  name    = "concourse-ssl"
  restart = "always"

  env = [
    "DOMAIN=concourse.thuislab.ijohan.nl",
    "TARGET_HOST=concourse-web",
    "TARGET_PORT=8080",
  ]

  upload {
    content = "${tls_locally_signed_cert.concourse.cert_pem}"
    file    = "/etc/nginx/certs/cert.pem"
  }

  upload {
    content = "${tls_private_key.concourse.private_key_pem}"
    file    = "/etc/nginx/certs/key.pem"
  }

  networks = [
    "concourse",
  ]
}
