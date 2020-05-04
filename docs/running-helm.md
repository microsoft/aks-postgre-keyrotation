# Helm Commands

Please modify the values.yaml file as follows:

1. Modify the azure.keyVaultName to be the unique name of the key vault desired
2. Modify the azure.applicationGatewayName to be the unique name of the key vault desired
3. Modify the azure.subscriptionId to be your subscription id (found via az account show)
4. Modify the azure.tenantId to be your tenant id (found via az account show)
5. Modify the connectionString.template to be a template of your connection string using something similar to Server=<db-server-name>;Database=<db-database-name>;Port=5432;User Id={RoleName}@<db-server-name>;Password={Pwd};Ssl Mode=Require;
    1. {RoleName}, {Pwd} will be modified by the web api at runtime
6. Modify container.image to be the docker image name of the container you want to run

## Installing the Helm Chart

``` bash
helm install postgrekeyrotation ./
```

> Run from the helm folder

## Uninstalling the Helm Chart

``` bash
helm uninstall postgrekeyrotation
```

## Forwarding Port 80 to the Application

``` bash
kubectl port-forward service/postgrekeyrotation-service 9999:8888
```

## Generating Secrets for Helm 

``` bash
kubectl create secret docker-registry acrsecret --docker-server <acr-server-url> --docker-email <docker-email-address> --docker-username  --docker-password <acr-password> --dry-run=true --output yaml
```

> We recommend strongly that secrets are managed through KeyVault, for this particular example we wanted to simplify some of the configuration of things. In doing so we needed a secret for access into the Azure Container Registry. The secret generated here would be pasted into templates/secret.yaml

