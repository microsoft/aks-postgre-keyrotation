#!/bin/bash

PGSERVER=${PGSERVER:-"jwpostgreserver.postgres.database.azure.com"}
PGDB=${PGDB:-"jwpostgredb"}
PGUSER=${PGUSER:-"psqladminun@jwpostgreserver"}

export PGPASSWORD="MyB@dP2\$\$wd"

echo ""
echo "Resetting password and activating login for role: pgapproleblue"

SQL="ALTER ROLE pgapproleblue WITH PASSWORD 'MyB@dP2\$\$wd'; ALTER ROLE pgapproleblue WITH LOGIN;"

echo ""
echo "------------------------------------------"
echo "psql output:"
echo "------------------------------------------"
echo ""

psql "sslmode=require host=${PGSERVER} dbname=${PGDB} user=${PGUSER}" -c "${SQL}"

echo ""
echo "------------------------------------------"

echo ""
echo "Resetting password and disabling login for role: pgapprolegreen"

SQL="ALTER ROLE pgapprolegreen WITH PASSWORD 'MyB@dP2\$\$wd'; ALTER ROLE pgapprolegreen WITH NOLOGIN;"

echo ""
echo "------------------------------------------"
echo "psql output:"
echo "------------------------------------------"
echo ""

psql "sslmode=require host=${PGSERVER} dbname=${PGDB} user=${PGUSER}" -c "${SQL}"

echo ""
echo "------------------------------------------"