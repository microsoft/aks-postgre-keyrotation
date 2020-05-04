#!/bin/bash

# // Copyright (c) Microsoft Corporation.
# // Licensed under the MIT license.

DBHOSTNAME=$1
DBNAME=$2
DBADMINROLE=$3

export PGPASSWORD="MyB@dP2\$\$wd"

echo ""
echo "Resetting password and activating login for role: pgapproleblue"

SQL="ALTER ROLE pgapproleblue WITH PASSWORD 'MyB@dP2\$\$wd'; ALTER ROLE pgapproleblue WITH LOGIN;"

echo ""
echo "------------------------------------------"
echo "psql output:"
echo "------------------------------------------"
echo ""

psql "sslmode=require host=${DBHOSTNAME} dbname=${DBNAME} user=${DBADMINROLE}" -c "${SQL}"

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

psql "sslmode=require host=${DBHOSTNAME} dbname=${DBNAME} user=${DBADMINROLE}" -c "${SQL}"

echo ""
echo "------------------------------------------"