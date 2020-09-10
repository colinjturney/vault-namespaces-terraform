resource "vault_policy" "user-team-a" {
  name = "team-a-policy"

  policy = <<EOT
# Manage auth methods broadly across Vault
path "/auth/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Create, update, and delete auth methods
path "/team_a/sys/auth/*"
{
  capabilities = ["create", "update", "delete", "sudo"]
}

# List auth methods
path "/team_a/sys/auth"
{
  capabilities = ["read"]
}

# Create and manage ACL policies
path "/team_a/sys/policies/acl/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# To list policies
path "/team_a/sys/policies/acl"
{
  capabilities = ["list"]
}

# Create and manage secrets engines broadly across Vault.
path "/team_a/sys/mounts/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# List available secrets engines
path "/team_a/sys/mounts" {
  capabilities = [ "read" ]
}

# Read health checks
path "/team_a/sys/health"
{
  capabilities = ["read", "sudo"]
}

path "/team_a/sys/capabilities"
{
  capabilities = ["create", "update"]
}

path "/team_a/sys/capabilities-self"
{
  capabilities = ["create", "update"]
}

# Full admin on identity secrets engine
path "/team_a/identity/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "identity/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

EOT
}

resource "vault_policy" "user-team-b" {
  name = "team-b-policy"

  policy = <<EOT
path "/team_b/secret/*" {
  capabilities = ["read", "update", "delete", "list"]
}
EOT
}