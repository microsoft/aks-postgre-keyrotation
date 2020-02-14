#!/bin/bash

ACTIVEROLE=$1
BUILDTAG=$2
DBHOSTNAME=$3
DBNAME=$4

if [ -z "${ACTIVEROLE}" ]; then
    echo "Usage:  $0 <active role>"
    exit 1;
else
    echo "ACTIVEROLE: ${ACTIVEROLE}"
    echo "BUILDTAG: ${BUILDTAG}"

    echo "DBHOSTNAME: ${DBHOSTNAME}"
    echo "DBNAME: ${DBNAME}"
    echo "BUILDTAG: ${BUILDTAG}"

    echo "Deploying Blue and Green"

    helm upgrade postgrekeyrotation ../helm \
    --set productionSlot=${ACTIVEROLE} \
    --set blue.enabled=true \
    --set blue.tag=${BUILDTAG} \
    --set blue.connectionString.roleName="pgapproleblue" \
    --set blue.connectionString.mountPoint="/mnt/keyvault/pgmainbluepwd" \
    --set green.enabled=true \
    --set green.tag=${BUILDTAG} \
    --set green.connectionString.roleName="pgapprolegreen" \
    --set green.connectionString.mountPoint="/mnt/keyvault/pgmaingreenpwd" \
    --set connectionString.template="Server=${DBHOSTNAME}.postgres.database.azure.com;Database=${DBNAME};Port=5432;User Id={RoleName}@${DBHOSTNAME};Password={Pwd};Ssl Mode=Require;"
fi
