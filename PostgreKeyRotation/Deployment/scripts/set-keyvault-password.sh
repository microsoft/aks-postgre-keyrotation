#!/bin/bash

# // Copyright (c) Microsoft Corporation.
# // Licensed under the MIT license.

existingBlueValue=$(az keyvault secret show --id https://<kv uri>/secrets/pgmainbluepwd --vault-name jwrotatekeyvault)
if [ -z "$existingBlueValue" ]
then
    echo "Secret pgmainbluepwd does not exist, we will create it..."
    az keyvault secret set --name pgmainbluepwd --vault-name jwrotatekeyvault --value "MyB@dP2\$\$wd"
else
    echo "Secret pgmainbluepwd already exists"
fi

existingGreenValue=$(az keyvault secret show --id https://<kv uri>/secrets/pgmaingreenpwd --vault-name jwrotatekeyvault)
if [ -z "$existingGreenValue" ]
then
    echo "Secret pgmaingreenpwd does not exist, we will create it..."
    az keyvault secret set --name pgmaingreenpwd --vault-name jwrotatekeyvault --value "MyB@dP2\$\$wd"
else
    echo "Secret pgmaingreenpwd already exists"
fi
