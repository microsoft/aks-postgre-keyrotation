#!/bin/bash

# // Copyright (c) Microsoft Corporation.
# // Licensed under the MIT license.

ACTIVEROLE=$1
DBHOSTNAME=$2
DBNAME=$3
DBADMINROLE=$4

if [ -z "${ACTIVEROLE}" ]; then
    echo "Usage:  $0 <active role>"
    exit 1;
else
    echo "ACTIVEROLE: ${ACTIVEROLE}"

    KEYVAULTNAME=${KEYVAULTNAME:-"jwrotatekeyvault"}

    export PGPASSWORD="MyB@dP2\$\$wd"

    KEYVAULTSECRETNAME="pgmainbluepwd"

    INACTIVEROLE="pgapproleblue"
    if [ "${ACTIVEROLE}" == "pgapproleblue" ]; then
        INACTIVEROLE="pgapprolegreen"
        KEYVAULTSECRETNAME="pgmaingreenpwd"
    fi

    echo ""
    echo "Changing password and activating login for role: ${INACTIVEROLE}"

    NEWPWD=$(openssl rand -base64 32)

    SQL="ALTER ROLE ${INACTIVEROLE} WITH PASSWORD '${NEWPWD}'; ALTER ROLE ${INACTIVEROLE} WITH LOGIN;"

    echo ""
    echo "------------------------------------------"
    echo "psql output:"
    echo "------------------------------------------"
    echo ""

    psql "sslmode=require host=${DBHOSTNAME} dbname=${DBNAME} user=${DBADMINROLE}" -c "${SQL}"

    echo ""
    echo "------------------------------------------"

    echo ""
    echo "Setting ${KEYVAULTSECRETNAME}"
    echo ""
    echo "------------------------------------------"
    echo "az keyvault output:"
    echo "------------------------------------------"
    echo ""

    az keyvault secret set --vault-name "${KEYVAULTNAME}" --name "${KEYVAULTSECRETNAME}" --value "${NEWPWD}"

    echo ""
    echo "------------------------------------------"
fi
