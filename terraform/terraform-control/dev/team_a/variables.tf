variable "vault_token" {
    description = "Authentication Token to use for Vault"
}

variable "vault_address" {
    default = "http://127.0.0.1:8200"
    description = "Vault server address"
}

variable "team_a_namespace_name" {
    type = string
    description = "Namespace Name"
}
