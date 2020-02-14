#!/bin/bash

ACTIVEROLE=$1
PROJECTURI=$2
ACCESSTOKEN=$3

if [ -z "${ACTIVEROLE}" ] || [ -z "${PROJECTURI}" ] || [ -z "${ACCESSTOKEN}" ]; then
    echo "Usage:  $0 <active role> <azdo project uri> <access token>"
    exit 1;
else
    echo "ACTIVEROLE: ${ACTIVEROLE}"
    echo "PROJECTURI: ${PROJECTURI}"
    echo "ACCESSTOKEN: ${ACCESSTOKEN}"
fi

INACTIVEROLE="pgapproleblue"
if [ "${ACTIVEROLE}" == "pgapproleblue" ]; then
    INACTIVEROLE="pgapprolegreen"
fi

URL="${PROJECTURI}/_apis/distributedtask/variablegroups/1?api-version=5.1-preview.1"

JSON="{
    'id': '1',
    'type': 'Vsts',
    'name': 'key-rotation-variables',
    'variables': {
        'currentActiveRole': {
        'isSecret': false,
        'value': '${INACTIVEROLE}'
        }
    }
}"

echo "Setting currentActiveRole to ${INACTIVEROLE} via api: ${URL} with json: ${JSON}"

curl -s -S -X PUT \
-H "Authorization:Bearer ${ACCESSTOKEN}" \
-H "Content-Type:application/json" \
-d "${JSON}" \
"${URL}"