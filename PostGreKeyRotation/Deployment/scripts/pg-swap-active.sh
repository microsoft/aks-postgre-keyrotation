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

    export PGPASSWORD="MyB@dP2\$\$wd"

    echo ""
    echo "Disabling login for role: ${ACTIVEROLE}"
    SQL="ALTER ROLE ${ACTIVEROLE} WITH NOLOGIN;"

    echo ""
    echo "------------------------------------------"
    echo "psql output:"
    echo "------------------------------------------"
    echo ""

    psql "sslmode=require host=${PGSERVER} dbname=${PGDB} user=${PGUSER}" -c "${SQL}"

    echo ""
fi
