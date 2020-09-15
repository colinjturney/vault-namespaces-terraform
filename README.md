# Vault Namespaces with Terraform
An example of how to configure Vault Enterprise with Namespaces, using the Terraform OSS Vault Provider.

## Introduction
A key decision that needs to be made when configuring a Vault Enterprise environment is the extent to which administration should be delegated. This will involve utilising the Namespaces feature in Vault Enterprise. 

Often, the "root" (top-level) Namespace is managed by a centralised Vault administration team who bear overall responsibility for Vault. Then, individual application teams will have their own Namespaces created for them by the Vault administrators that allows them to have some level of delegated administration, which could be determined by ACL and Sentinel policies.

In-line with the above decisions, it also needs to be decided how to split out Terraform code. With this demo being written with the brief of using only Terraform OSS CLI, the best approach to take here would be to split out the Terraform working directory into separate directories, that in-turn would produce separate state files. The intention here is that each directory represents somewhere that a user of differing privileges (root - vault admin, team_a - team A admin, etc).

The Terraform code for this demo contains the following:
* terraform-vault-ldap Terraform Module, which creates:
    * An LDAP Authentication Method, mounted on the root namespace
    * A team-a-policy allowing full delegated administration on the team_a namespace.
    * A team-b-policy allowing only access to the static secrets store on team_b namespace.
    * An External Group and alias for team_a and team_b respectively, with policies assigned to them.
* terraform-vault-namespace Terraform Module, which creates:
    * A Vault namespace with the name specified.
* terraform-vault-secret Terraform Module, which creates:
    * A KV static secrets store.
    * A Vault internal identity group that includes in its members the identity groups created at the Root Namespace level, and a policy attached that grants access to the above static secrets store.
* terraform-control repository (from which Terraform should be run), containing the following directories:
    1. root: Creates the LDAP auth mount and applies base-level configurations to Vault and the team_a and team_b namespaces. Requires the root token `root` to be supplied.
    1. team_a: Creates the team_a/secret KV secret store and internal identity group.
    1. team_b: Currently unused but could easily be configured to be similar to team_a.

## Requirements
* Requires the [vagrant-ldap](https://github.com/colinjturney/vagrant-ldap) project to be cloned locally and it's Vagrant VM running with a `vagrant up` command. This is required in order to start an LDAP server that could be used to authenticate against Vault with.
* Requires Vault Enterprise for Namespaces feature(tested using v1.5.3+ent)
* Requires Terraform OSS (tested using v0.13.2)

## Steps
1. Clone the `vagrant-ldap` repository and start the Vagrant VM with a `vagrant up` command within the `vagrant-ldap` directory. 
1. `cd` back into this `vault-namespaces-terraform` directory. Ensure you have a valid Vault Enterprise license key stored in `license-vault.txt` and then run `./0-init-vault.sh`
1. `cd` into the `terraform/terraform-control/root` directory and then run the following commands:
    1. `terraform init`
    1. `terraform plan`
    1. `terraform apply`
1. `cd` into the `terraform/terraform-control/team_a` directory and then run the following commands:
    1. `vault login -method=ldap username=a_user password=password`
    1. Copy the outputted token to your clipboard.
    1. `terraform init`
    1. `terraform plan`, pasting the Vault token when prompted.
    1. `terraform apply`, pasting the Vault token when prompted.
1. To shut-down the demo, run `terraform destroy` in the above directories and then run `./99-kill-vault.sh` to stop Vault.

## Reasonings
* Terraform configurations are split into separate states to mimic situation whereby a less-privileged user would have some delegated administration over their team_a namespace. It wouldn't make sense for the same user to try to perform actions they weren't authorised to do (i.e. those in the root namespace), therefore they authenticate to Vault separately in a separate step. If there was **no** delegated administration, but still namespaces, then multiple Vault provider blocks could be specified with an `alias` meta-parameter.

## Notes on best practices
This demo does not attempt to define all best practices on usage of Vault or Terraform. Most notably:
* Revoke your Vault root token as soon as you're able to.
* Store your Terraform state in a highly-available remote backend such as Terraform Cloud or S3.
* Don't use Vault server in dev mode in a production set-up.
* Enable TLS on your Vault server