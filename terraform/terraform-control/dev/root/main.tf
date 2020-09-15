# Vault Root Provider
provider "vault" {
    address = var.vault_address
    token   = var.vault_token
    version = "~> 2.10"
}

# Vault LDAP Auth Method
module "ldap-auth" {
    source = "../../../modules/terraform-vault-ldap"

    ldap_path           = "ldap"
    ldap_url            = "ldap://10.0.1.100"
    ldap_userdn         = "ou=People,dc=foo,dc=com"
    ldap_userattr       = "uid"
    ldap_groupdn        = "ou=groups,dc=foo,dc=com"
    ldap_groupfilter    = "(&(objectClass=groupOfNames)(member={{.UserDN}}))"
    ldap_groupattr      = "cn"
    ldap_binddn         = "uid=vault,ou=people,dc=foo,dc=com"
    ldap_bindpass       = "password"
}

# Create Namespaces for team_a

module "ns-team-a" {
    source = "../../../modules/terraform-vault-namespace"
    
    namespace_name = var.team_a_namespace_name
}

# Create Namespaces for team_b

module "ns-team-b" {
    source = "../../../modules/terraform-vault-namespace"
    
    namespace_name = var.team_b_namespace_name
}
