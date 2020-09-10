resource "vault_mount" "team-secret-mount" {
    path = "secret/"
    type = "generic"
    description = "kv secrets store"
}

resource "vault_generic_secret" "team-secret" {
    path = "secret/hello/"

    data_json = <<EOT
{
    "value": "world"
}
EOT

    # Is this meta attribute still needed?
    depends_on = [vault_mount.team-secret-mount]
}