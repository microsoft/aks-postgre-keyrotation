#!/bin/bash

# // Copyright (c) Microsoft Corporation.
# // Licensed under the MIT license.

DBHOSTNAME=$1
DBNAME=$2
DBADMINROLE=$3

export PGPASSWORD="MyB@dP2\$\$wd"

sudo apt-get install postgresql-client --yes

psql "sslmode=require host=${DBHOSTNAME} dbname=${DBNAME} user=${DBADMINROLE}" -f ddl.sql
