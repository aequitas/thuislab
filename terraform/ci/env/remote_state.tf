terraform {
  backend "local" {
    path = "../../.state/ci.tfstate"
  }
}
