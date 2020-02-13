#!/bin/bash

ACTIVEROLE=$1

if [ -z "${ACTIVEROLE}" ]; then
    echo "Usage:  $0 <active role>"
    exit 1;
else
    echo "ACTIVEROLE: ${ACTIVEROLE}"

    PGSERVER=${PGSERVER:-"jwpostgreserver.postgres.database.azure.com"}
    PGDB=${PGDB:-"jwpostgredb"}
    PGUSER=${PGUSER:-"psqladminun@jwpostgreserver"}
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

    psql "sslmode=require host=${PGSERVER} dbname=${PGDB} user=${PGUSER}" -c "${SQL}"

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
