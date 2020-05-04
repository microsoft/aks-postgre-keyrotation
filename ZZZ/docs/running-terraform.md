# Running Terraform Locally

First, it's strongly encouraged to have a remote state file storage mechanism. We have a [shell script](https://github.com/jwendl/aks-postgre-keyrotation/raw/master/PostGreKeyRotation/Deployment/terraform/add-tf-storage.sh) inside the terraform folder that helps with this.

It can be run by using the command

``` bash
./add-tf-storage.sh -r <resource-group-name> -n <storage-account-name> -l <region-in-azure>
```

Once that command is done, update the terraform/provider.tf file with the storage_account_name value.

## Run Terraform Plan and Terraform Apply

``` bash
#!/bin/bash

mkdir -p ~/tfoutput

export ARM_SUBSCRIPTION_ID=""
export ARM_CLIENT_ID=""
export ARM_CLIENT_SECRET=""
export ARM_TENANT_ID=""

export resourceGroupName=""
export appRegistrationName=""
export location=""
export keyVaultName=""
export keyVaultTenantId=""
export terraformServicePrincipalTenantId=""
export terraformServicePrincipalObjectId=""
export aksServicePrincipalTenantId=""
export aksServicePrincipalObjectId=""
export azdoServicePrincipalTenantId=""
export azdoServicePrincipalObjectId=""
export appServicePrincipalTenantId=""
export appServicePrincipalObjectId=""
export applicationGatewayName=""
export containerRegistryName=""
export servicePrincipalClientId=""
export servicePrincipalClientSecret=""
export clusterName=""
export dnsPrefix=""
export publicIpAddressDomainName=""
export agentCount="1"
export postgreServerName=""
export postgreDatabaseName=""

terraform plan \
    -var "subscription_id=$ARM_SUBSCRIPTION_ID" \
    -var "key_vault_resource_group_name=$resourceGroupName" \
    -var "key_vault_app_registration_name=$appRegistrationName" \
    -var "key_vault_location=$location" \
    -var "key_vault_name=$keyVaultName" \
    -var "key_vault_tenant_id=$keyVaultTenantId" \
    -var "key_vault_tfsp_tenant_id=$terraformServicePrincipalTenantId" \
    -var "key_vault_tfsp_object_id=$terraformServicePrincipalObjectId" \
    -var "key_vault_akssp_tenant_id=$aksServicePrincipalTenantId" \
    -var "key_vault_akssp_object_id=$aksServicePrincipalObjectId" \
    -var "key_vault_azdosp_tenant_id=$azdoServicePrincipalTenantId" \
    -var "key_vault_azdosp_object_id=$azdoServicePrincipalObjectId" \
    -var "key_vault_app_tenant_id=$appServicePrincipalTenantId" \
    -var "key_vault_app_object_id=$appServicePrincipalObjectId" \
    -var "ag_gateway_name=$applicationGatewayName" \
    -var "container_registry_name=$containerRegistryName" \
    -var "sp_client_id=$servicePrincipalClientId" \
    -var "sp_client_secret=$servicePrincipalClientSecret" \
    -var "cluster_name=$clusterName" \
    -var "dns_prefix=$dnsPrefix" \
    -var "publicip_domainname=$publicIpAddressDomainName" \
    -var "agent_count=$agentCount" \
    -var "postgre_server_name=$postgreServerName" \
    -var "postgre_db_name=$postgreDatabaseName" \
    --out ~/tfoutput/key-rotate

terraform apply ~/tfoutput/key-rotate
```

## Generating ARM_CLIENT_ID and ARM_CLIENT_SECRET

``` bash
az ad sp create-for-rbac --name <name-of-service-principal> --role Contributor --scope /subscriptions/<subscription-id>
```
