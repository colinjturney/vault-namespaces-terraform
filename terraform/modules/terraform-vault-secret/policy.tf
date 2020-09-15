
resource "vault_policy" "secret-access" {
  name = "secret-access"

  policy = <<EOT
path "secret/*" {
  capabilities = ["create","read", "update", "delete", "list", "sudo"]
}
EOT
}