#!/bin/bash

# // Copyright (c) Microsoft Corporation.
# // Licensed under the MIT license.

KEYVAULTNAME=${KEYVAULTNAME:-"jwrotatekeyvault"}

echo ""
echo "Resetting pgmainbluepwd"
echo ""
echo "------------------------------------------"
echo "az keyvault output:"
echo "------------------------------------------"
echo ""

az keyvault secret set --vault-name "${KEYVAULTNAME}" --name "pgmainbluepwd" --value "MyB@dP2\$\$wd"

echo ""
echo "------------------------------------------"

echo ""
echo "Resetting pgmaingreenpwd"
echo ""
echo "------------------------------------------"
echo "az keyvault output:"
echo "------------------------------------------"
echo ""

az keyvault secret set --vault-name "${KEYVAULTNAME}" --name "pgmaingreenpwd" --value "MyB@dP2\$\$wd"

echo ""
echo "------------------------------------------"