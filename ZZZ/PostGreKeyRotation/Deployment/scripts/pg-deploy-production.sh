#!/bin/bash

ACTIVEROLE=$1
BUILDTAG=$2
DBHOSTNAME=$3
DBNAME=$4

if [ -z "${ACTIVEROLE}" ]; then
    echo "Usage:  $0 <active role> <build tag>"
    exit 1;
else
    echo "ACTIVEROLE: ${ACTIVEROLE}"
    echo "BUILDTAG: ${BUILDTAG}"

    PRODUCTIONSLOT="pgapproleblue"
    BLUEENABLED=true
    GREENENABLED=false

    if [ "${ACTIVEROLE}" == "pgapproleblue" ]; then
        PRODUCTIONSLOT="pgapprolegreen"
        BLUEENABLED=false
        GREENENABLED=true
    fi

    echo "DBHOSTNAME: ${DBHOSTNAME}"
    echo "DBNAME: ${DBNAME}"
    echo "BUILDTAG: ${BUILDTAG}"
    echo "PRODUCTIONSLOT: ${PRODUCTIONSLOT}"
    echo "BLUEENABLED: ${BLUEENABLED}"
    echo "GREENENABLED: ${GREENENABLED}"

    echo "Deploying ${PRODUCTIONSLOT}"

    helm upgrade postgrekeyrotation ../helm \
    --set productionSlot=${PRODUCTIONSLOT} \
    --set blue.enabled=${BLUEENABLED} \
    --set blue.tag=${BUILDTAG} \
    --set blue.connectionString.roleName="pgapproleblue" \
    --set blue.connectionString.mountPoint="/mnt/keyvault/pgmainbluepwd" \
    --set green.enabled=${GREENENABLED}  \
    --set green.tag=${BUILDTAG} \
    --set green.connectionString.roleName="pgapprolegreen" \
    --set green.connectionString.mountPoint="/mnt/keyvault/pgmaingreenpwd" \
    --set connectionString.template="Server=${DBHOSTNAME}.postgres.database.azure.com;Database=${DBNAME};Port=5432;User Id={RoleName}@${DBHOSTNAME};Password={Pwd};Ssl Mode=Require;"
fi
