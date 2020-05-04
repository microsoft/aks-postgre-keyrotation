#!/bin/bash

BUILDTAG=$1
PROJECTURI=$2
ACCESSTOKEN=$3

echo "BUILDTAG: ${BUILDTAG}"
echo "PROJECTURI: ${PROJECTURI}"
echo "ACCESSTOKEN: ${ACCESSTOKEN}"

URL="${PROJECTURI}/_apis/distributedtask/variablegroups/2?api-version=5.1-preview.1"

JSON="{
    'id': '2',
    'type': 'Vsts',
    'name': 'pipeline-variables',
    'variables': {
        'buildConfiguration': {
            'isSecret': false,
            'value': 'release'
        },
        'buildTag': {
            'isSecret': false,
            'value': '${BUILDTAG}'
        },
        'imageName': {
            'isSecret': false,
            'value': 'postgrekeyrotation'
        }
    }
}"

echo "Setting buildTag to ${BUILDTAG} via api: ${URL} with json: ${JSON}"

curl -s -S -X PUT \
-H "Authorization:Bearer ${ACCESSTOKEN}" \
-H "Content-Type:application/json" \
-d "${JSON}" \
"${URL}"