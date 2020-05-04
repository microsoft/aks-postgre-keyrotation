# Secret Rotation

## General

This example project demonstrates how to handle secret rotation from a web application running in Azure Kubernetes Service, stores the secrets into KeyVault and then uses those secrets to access Azure SQL PostGre instance. 

This generally requires changes to be done for the source application, the ability to store the secret in a secure vault and updates on the destination application. This is really tricky to do in a way that requires zero down time.

> The reason why we are attempting to accomplish this with zero downtime is to remove the friction and high cost of deploying changes to an environment so we can more frequently rotate secrets.

Please see [Getting Started](docs/getting-started.md) for information on how to run the code.

## Blue / Green Deployment

One approach to handling the source application updates when using Azure Kubernetes Service is to utilize Azure Application Gateway and handle Blue / Green deployments using helm and the Ingress controller that comes with Azure Application Gateway.

![Overall Pipeline](docs/images/overall-pipeline.png)

In this diagram we are showing how Azure Pipelines can be used to orchestrate each stage of the overall key rotation process.

## Steps and Process

1. Application is Live in Production
1. User will run the KeyRotation pipeline
    1. The pipeline generates a new secret.
    1. The pipeline then updates Azure PostGre SQL by activing the secondary role and changing that role's password.
    1. The pipeline then updates KeyVault's definition of that second password.
    1. The pipeline will then update the source application, in our case it's just rotating one slot with the other slot.
    1. Then integration testing runs to ensure basic end to end functionality.
1. Once everything runs the user deploying the key rotation will manually validate that production is setup properly.
1. Once that validation is done, then the user can run another pipeline to delete the old production pod.

![Production is Blue](docs/images/prod-blue-stage.png)

![Both Running](docs/images/both-running.png)

![Swap Services](docs/images/swap-services.png)

![Remove Old Prod](docs/images/remove-old-prod.png)