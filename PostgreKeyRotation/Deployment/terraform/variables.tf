# // Copyright (c) Microsoft Corporation.
# // Licensed under the MIT license.

variable "subscription_id" {
  description = "The subscription id"
}

variable "key_vault_resource_group_name" {
  description = "The key vault resource group"
}

variable "key_vault_app_registration_name" {
  description = "The key vault app registration name"
}

variable "key_vault_location" {
  description = "The key vault location"
}

variable "key_vault_name" {
  description = "The key vault name"
}

variable "key_vault_tenant_id" {
  description = "The key vault tenant id"
}

variable "key_vault_tfsp_tenant_id" {
  description = "The key vault tenant id"
}

variable "key_vault_tfsp_object_id" {
  description = "The key vault object id"
}

variable "key_vault_akssp_tenant_id" {
  description = "The key vault tenant id"
}

variable "key_vault_akssp_object_id" {
  description = "The key vault object id"
}

variable "key_vault_azdosp_tenant_id" {
  description = "The key vault tenant id"
}

variable "key_vault_azdosp_object_id" {
  description = "The key vault object id"
}

variable "key_vault_app_tenant_id" {
  description = "The Azure AD application tenant id"
}

variable "key_vault_app_object_id" {
  description = "The Azure AD client app object id"
}

variable "ag_gateway_name" {
  description = "The application gateway name"
}

variable "container_registry_name" {
  description = "The container registry name"
}

variable "sp_client_id" {
  description = "The sp client id"
}

variable "sp_client_secret" {
  description = "The sp client secret"
}

variable "cluster_name" {
  description = "The cluster name"
}

variable "dns_prefix" {
  description = "The DNS Prefix for AKS"
}

variable "publicip_domainname" {
  description = "The Domain name for the public ip"
}

variable "agent_count" {
  description = "The Agent Count for AKS"
}

variable "postgre_server_name" {
  description = "Postgre Server Name"
}

variable "postgre_db_name" {
  description = "Postgre DB Name"
}

variable "aks_service_cidr" {
  description = "A CIDR notation IP range from which to assign service cluster IPs."
  default     = "10.0.0.0/16"
}

variable "aks_dns_service_ip" {
  description = "Containers DNS server IP address."
  default     = "10.0.0.10"
}

variable "aks_docker_bridge_cidr" {
  description = "A CIDR notation IP for Docker bridge."
  default     = "172.17.0.1/16"
}
