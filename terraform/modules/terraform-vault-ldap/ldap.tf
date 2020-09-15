resource "vault_ldap_auth_backend" "ldap-auth" {
    path        = var.ldap_path
    url         = var.ldap_url
    userdn      = var.ldap_userdn
    userattr    = var.ldap_userattr
    groupdn     = var.ldap_groupdn
    groupfilter = var.ldap_groupfilter
    groupattr   = var.ldap_groupattr
    binddn      = var.ldap_binddn
    bindpass    = var.ldap_bindpass
}

resource "vault_identity_group" "team-a" {
    name = "team_a"
    type = "external"
    policies = ["team-a-policy"] 
}

resource "vault_identity_group_alias" "team-a-alias" {
    name            = "team_a"
    mount_accessor  = vault_ldap_auth_backend.ldap-auth.accessor
    canonical_id    = vault_identity_group.team-a.id
}

resource "vault_identity_group" "team-b" {
    name = "team_b"
    type = "external"
    policies = ["team-b-policy"] 
}

resource "vault_identity_group_alias" "team-b-alias" {
    name            = "team_b"
    mount_accessor  = vault_ldap_auth_backend.ldap-auth.accessor
    canonical_id    = vault_identity_group.team-b.id
}