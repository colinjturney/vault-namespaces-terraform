# Create a group for namespace-external users to access this secret
resource "vault_identity_group" "group" {
    name = "secrets-access"
    type = "internal"
    member_group_ids = var.member_group_ids
    policies = ["secret-access"]
}