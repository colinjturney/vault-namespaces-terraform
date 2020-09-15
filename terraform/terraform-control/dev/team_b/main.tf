# Vault team_b Namespace Provider
provider "vault" {
    address     = var.vault_bddress
    token       = var.vault_token
    alias       = "team_b"
    namespace   = var.team_b_namespace_name
}

module "ns-team-b" {
    source = "../../../modules/terraform-vault-namespace"
    providers = {
        vault = vault.team_b
    }
    
    namespace_name = var.team_b_namespace_name
}

module "team-b-secret" {
    source = "../../../modules/terraform-vault-secret"
    providers = {
        vault = vault.team_b
    }
    secret_path = "/team_b/secret"

    depends_on = [module.ns-team-b]
}