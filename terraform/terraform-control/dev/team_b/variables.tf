variable "vault_token" {
    default = "root"
    description = "Authentication Token to use for Vault"
}

variable "vault_address" {
    default = "http://127.0.0.1:8200"
    description = "Vault server address"
}

variable "bu1_namespace_name" {
    type = string
    description = "Namespace Name"
}

variable "teama_namespace_name" {
    type = string
    description = "Namespace Name"
}

variable "teamb_namespace_name" {
    type = string
    description = "Namespace Name"
}

variable "bu2_namespace_name" {
    type = string
    description = "Namespace Name"
} 

variable "teamc_namespace_name" {
    type = string
    description = "Namespace Name"
} 

variable "teamd_namespace_name" {
    type = string
    description = "Namespace Name"
} 