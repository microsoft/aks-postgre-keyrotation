#!/bin/bash

export PGPASSWORD="MyB@dP2\$\$wd"
PGSERVER=${PGSERVER:-'jwpostgreserver.postgres.database.azure.com'}
PGDB=${PGDB:-'jwpostgredb'}
PGUSER=${PGUSER:-'psqladminun@jwpostgreserver'}

sudo apt-get install postgresql-client --yes

psql "sslmode=require host=${PGSERVER} dbname=${PGDB} user=${PGUSER}" -f ddl.sql
