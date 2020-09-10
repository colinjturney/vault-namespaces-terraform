data "terraform_remote_state" "root" {
  backend = "local"

  config = {
    path = "../root/terraform.tfstate"
  }
}
