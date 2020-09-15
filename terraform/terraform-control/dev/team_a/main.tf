# Vault team_a Namespace Provider
provider "vault" {
    address     = var.vault_address
    token       = var.vault_token
    namespace   = "team_a"
}

module "team-a-secret" {
    source = "../../../modules/terraform-vault-secret"

    member_group_ids = [data.terraform_remote_state.root.outputs.team_a_entity_group_id,data.terraform_remote_state.root.outputs.team_b_entity_group_id]   
}
