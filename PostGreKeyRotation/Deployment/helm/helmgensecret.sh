#!/bin/bash

kubectl create secret docker-registry acrsecret --docker-server jwrotateacr.azurecr.io --docker-email juswen@microsoft.com --docker-username jwrotateacr --docker-password <acr-password> --dry-run=true --output yaml
