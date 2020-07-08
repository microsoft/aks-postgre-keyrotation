#!/bin/bash

mkdir -p ~/tfoutput

export ARM_SUBSCRIPTION_ID="959965bb-d9df-4c6f-825e-37e1090d817d"
export ARM_CLIENT_ID="54a8934f-7e9a-482f-bfcc-cecbe61c483a"
export ARM_CLIENT_SECRET="b9MDRbSRboVQovArjrxNrPsK7_IZl2-MPp"
export ARM_TENANT_ID="72f988bf-86f1-41af-91ab-2d7cd011db47"

export resourceGroupName="KeyRotate"
export appRegistrationName="jwaksrotateapp"
export location="westus2"
export keyVaultName="jwrotatekv"
export keyVaultTenantId="72f988bf-86f1-41af-91ab-2d7cd011db47"
export terraformServicePrincipalTenantId="72f988bf-86f1-41af-91ab-2d7cd011db47"
export terraformServicePrincipalObjectId="7735e5d0-f14f-4f14-9f79-a1263884dab5"
export aksServicePrincipalTenantId="72f988bf-86f1-41af-91ab-2d7cd011db47"
export aksServicePrincipalObjectId="36868e8d-808b-4eaa-815a-842df749dbed"
export azdoServicePrincipalTenantId="72f988bf-86f1-41af-91ab-2d7cd011db47"
export azdoServicePrincipalObjectId="7735e5d0-f14f-4f14-9f79-a1263884dab5"
export appServicePrincipalTenantId="72f988bf-86f1-41af-91ab-2d7cd011db47"
export appServicePrincipalObjectId="7735e5d0-f14f-4f14-9f79-a1263884dab5"
export applicationGatewayName="jwrotateappgw"
export containerRegistryName="jwrotateacr"
export servicePrincipalClientId="7735e5d0-f14f-4f14-9f79-a1263884dab5"
export servicePrincipalClientSecret="EChZ~K5PDCo4juk1JPIsHYJMydYG_L758X"
export clusterName="jwrotatecluster"
export dnsPrefix="jwrotatecluster"
export publicIpAddressDomainName="jwrotatecluster"
export agentCount="2"
export postgreServerName="jwpostgresql"
export postgreDatabaseName="jwpostgresqldb"

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

