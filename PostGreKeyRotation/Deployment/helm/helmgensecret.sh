#!/bin/bash

kubectl create secret docker-registry acrsecret --docker-server <acr-server-url> --docker-email <docker-email-address> --docker-username jwrotateacr --docker-password <acr-password> --dry-run=true --output yaml
