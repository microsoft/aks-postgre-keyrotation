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

    export PGPASSWORD="MyB@dP2\$\$wd"

    echo ""
    echo "Disabling login for role: ${ACTIVEROLE}"
    SQL="ALTER ROLE ${ACTIVEROLE} WITH NOLOGIN;"

    echo ""
    echo "------------------------------------------"
    echo "psql output:"
    echo "------------------------------------------"
    echo ""

    psql "sslmode=require host=${DBHOSTNAME} dbname=${DBNAME} user=${DBADMINROLE}" -c "${SQL}"

    echo ""
fi
